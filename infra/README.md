# 量潮项目云（qtcloud-project）基础设施

## 资源清单

| 资源 | 名称 | 说明 |
|------|------|------|
| OSS bucket | `qtcloud-project-studio` | Flutter Studio Web 静态站点（public-read，网站托管 index.html/404.html） |
| CDN 加速域名 | `project.cloud.quanttide.com` | 源站为上述 OSS bucket（web 类型，回源 443） |
| DNS 记录 | `project.cloud.quanttide.com` CNAME | 指向 CDN 分配的 CNAME（*.kunlunaq.com） |

命名与量潮现有约定一致（参考 `qtdata-studio` / `data.quanttide.com`、`qtcloud-data-studio` / `data.cloud.quanttide.com`）。

## 用法

```bash
# 幂等创建/补齐所有资源
bash infra/setup.sh
```

依赖：`aliyun` CLI（3.x）、`ossutil`（1.7.x）、`jq`。
凭证：优先使用环境变量 `ALICLOUD_ACCESS_KEY` / `ALICLOUD_SECRET_KEY`，否则读取 `~/.aliyun/config.json` 的 default profile。

## HTTPS 证书（Let's Encrypt，已签发绑定）

`project.cloud.quanttide.com` 为二级子域，现有 `*.quanttide.com` 通配符证书不覆盖，
本次通过 acme.sh（DNS-01 验证，阿里云 DNS API 自动添加 TXT 记录）签发 Let's Encrypt 证书并绑定到 CDN。

证书有效期 90 天，需要续期。当前 acme.sh 安装在 `/tmp`（临时），后续应迁移到持久目录并配置自动续期：

```bash
# 迁移后重新签发/续期并绑定（示例）
export Ali_Key=<AK> Ali_Secret=<SK>
acme.sh --issue --dns dns_ali -d project.cloud.quanttide.com --server letsencrypt \
  --home <持久目录>/acme.sh --config-home <持久目录>/acme.sh-data
# 续期后需重新上传并绑定到 CDN（SetCdnDomainSSLCertificate）
```

## CI 部署

tag `studio/*` 推送后由 GitHub Actions 自动构建并上传至 `qtcloud-project-studio`，见 `.github/workflows/deploy-studio.yml`。
