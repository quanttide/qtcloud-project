# Flutter Studio 部署到阿里云 OSS + CDN 经验（2026-08-10）

记录首次发布 `studio/v0.1.0-alpha.2` 的部署过程与关键经验。
线上地址：https://project.cloud.quanttide.com/

## 部署架构

```
GitHub Actions（tag studio/* 触发）
  → flutter build web
  → ossutil 上传 oss://qtcloud-project-studio/（public-read + 网站托管）
  → CDN project.cloud.quanttide.com（源站 OSS，回源 443）
  → DNS CNAME project.cloud.quanttide.com → *.kunlunaq.com
  → HTTPS 证书（Let's Encrypt，acme.sh 自动续期 + 续期后自动重绑 CDN）
```

资源创建脚本：`scripts/setup.sh`（幂等）。命名约定：`qt<领域>-studio` bucket + `<领域>.cloud.quanttide.com` 域名。

## 关键经验

### 1. OSS：阻止公共访问会导致 403

创建 bucket 并设置 `ACL=public-read` 后，公网与 CDN 回源仍返回 **403 Forbidden**。
原因是 bucket 级「阻止公共访问」（Block Public Access）默认开启，会覆盖 ACL 设置。

- `aliyun oss` 子命令（已废弃）与 ossutil v1 **均无** public access block 命令
- 修复需调用签名 REST API：`PUT /?publicAccessBlock`，见 `scripts/fix_public_access.py`
- 验证：`curl -I http://<bucket>.oss-cn-hangzhou.aliyuncs.com/<object>` 应为 200

### 2. ossutil v1 的网站托管配置参数

`ossutil website --method put oss://bucket/ --index-file ...` **不存在**（报 `Bad flag`）。
正确用法是传本地 XML 文件：

```bash
ossutil website --method put oss://bucket/ /tmp/website.xml
```

XML 内容：`<WebsiteConfiguration><IndexDocument><Suffix>index.html</Suffix></IndexDocument><ErrorDocument><Key>404.html</Key></ErrorDocument></WebsiteConfiguration>`

### 3. CDN 创建：Sources 字段名

`AddCdnDomain --Sources` 的 JSON 字段必须是 `type/content/port/priority`。
写成 `source`/`bucket` 会报 `MissingParameter: Origin server information is not complete`。

```json
[{"type":"oss","content":"qtcloud-project-studio.oss-cn-hangzhou.aliyuncs.com","port":443,"priority":"20"}]
```

域名状态 `configuring` → `online` 约 1–3 分钟，需轮询 `DescribeCdnDomainDetail`。

### 4. 缓存策略（版本化资源 vs 入口文件）

| 文件 | Cache-Control | 原因 |
|------|---------------|------|
| `assets/`、`main.dart.js` 等版本化资源 | `max-age=31536000` | 文件名带版本哈希，长缓存不会过期 |
| `index.html` / `manifest.json` / `flutter_bootstrap.js` | `no-cache` | 内容随版本变更，长缓存导致浏览器拿不到新版 |

部署后需刷新 CDN：`RefreshObjectCaches`（Directory 刷新 `https://<域名>/`）。

### 5. HTTPS 证书：通配符证书不覆盖二级子域

- 现有 `*.quanttide.com` 通配符证书只覆盖**一级**子域，不覆盖 `project.cloud.quanttide.com`
- 阿里云 CAS 免费证书额度不足（`InsufficientQuota`），无法走阿里云免费证书
- 方案：**acme.sh + Let's Encrypt，DNS-01 验证**（`Ali_Key` 凭证由 acme.sh 自动添加/删除 TXT 记录）
- 绑定 CDN：`SetCdnDomainSSLCertificate --CertType upload --SSLPub <fullchain> --SSLPri <key>`，`ServerCertificateStatus` 由 `off` 变 `on`（绑定后若仍 `off` 即未生效）

### 6. 证书自动续期链路（已配置）

```
crontab（21 1,7,13,19 * * *）→ acme.sh --cron
  → 到期前 30 天自动续期（dns_ali 插件，SAVED_Ali_Key 凭证）
    → 续期成功触发 Le_ReloadCmd → deploy-cdn-cert.sh → 重绑 CDN
```

关键点：`--install-cert --reloadcmd "bash ~/.acme.sh/deploy-cdn-cert.sh"` 将续期动作与部署动作解耦，
续期脚本只负责把新证书上传绑定（幂等）。

### 7. 网络环境：github 不可达

- GitHub 直连超时：terraform provider（alicloud）无法下载，aliyun/tencent/huawei 镜像路径均 404
- 解决：本方案用 `aliyun CLI` 幂等脚本代替 Terraform（组织现有 Terraform state 也只管理 OSS bucket）
- acme.sh 安装：gitee 镜像 `git clone https://gitee.com/neilpang/acme.sh.git`
- ossutil 下载：`https://gosspublic.alicdn.com/ossutil/1.7.19/ossutil-v1.7.19-linux-amd64.zip`

### 8. CI 发布流程

- tag `studio/<version>` 推送触发 `deploy-studio.yml`（参考 qtdata）
- 版本 bump 提交：`chore: bump studio version to vX.Y.Z`，tag 打在 bump 提交上
- 仓库需配置 Secrets：`ALIYUN_ACCESS_KEY_ID` / `ALIYUN_ACCESS_KEY_SECRET`
- GitHub Actions 查看运行状态：
  `curl https://api.github.com/repos/quanttide/qtcloud-project/actions/runs?event=push`

## 上线验证清单

```bash
# 1. HTTPS 可达 + 标题
curl -sI https://project.cloud.quanttide.com/          # 200
curl -s  https://project.cloud.quanttide.com/ | grep <title>
# 2. PWA manifest 品牌
curl -s  https://project.cloud.quanttide.com/manifest.json | jq '.name, .description'
# 3. 证书
echo | openssl s_client -connect project.cloud.quanttide.com:443 -servername project.cloud.quanttide.com \
  | openssl x509 -noout -subject -dates
# 4. 入口缓存策略
curl -sI https://project.cloud.quanttide.com/index.html | grep -i cache-control   # no-cache
# 5. 404 兜底
curl -so /dev/null -w '%{http_code}\n' https://project.cloud.quanttide.com/nonexistent   # 404
```
