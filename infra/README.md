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

## HTTPS 证书（后续步骤）

现有通配符证书 `*.quanttide.com` 只覆盖一级子域，`project.cloud.quanttide.com` 为二级子域，需要单独证书：

- 方式一（推荐）：在 CDN 控制台为 `project.cloud.quanttide.com` 申请/绑定免费证书（与 `data.cloud.quanttide.com` 等域名做法一致）
- 方式二：通过 ZeroSSL 等签发包含 `project.cloud.quanttide.com` 的证书后，在控制台上传绑定

绑定完成后验证：`curl -I https://project.cloud.quanttide.com/`

## CI 部署

tag `studio/*` 推送后由 GitHub Actions 自动构建并上传至 `qtcloud-project-studio`，见 `.github/workflows/deploy-studio.yml`。
