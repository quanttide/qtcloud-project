#!/usr/bin/env bash
# 量潮项目云（qtcloud-project）Studio 部署基础设施
#
# 幂等创建以下资源（已存在则跳过）：
#   1. OSS bucket `qtcloud-project-studio`（静态网站托管）
#   2. CDN 加速域名 `project.cloud.quanttide.com`（源站：OSS）
#   3. DNS 记录 `project.cloud.quanttide.com` CNAME -> CDN
#
# 依赖：aliyun CLI（3.x）、ossutil（1.7.x）、jq
# 凭证：优先使用环境变量 ALICLOUD_ACCESS_KEY / ALICLOUD_SECRET_KEY，
#       未设置时读取 ~/.aliyun/config.json 的 default profile。
#
# 用法：bash scripts/setup.sh
set -euo pipefail

BUCKET="qtcloud-project-studio"
CDN_DOMAIN="project.cloud.quanttide.com"
ROOT_DOMAIN="quanttide.com"
REGION="cn-hangzhou"
OSS_ENDPOINT="oss-${REGION}.aliyuncs.com"

# ---- 凭证 ----
read_credential() {
  python3 -c "
import json, sys
p = json.load(open('$HOME/.aliyun/config.json'))['profiles'][0]
print(p['$1'])
"
}
ACCESS_KEY="${ALICLOUD_ACCESS_KEY:-$(read_credential access_key_id)}"
SECRET_KEY="${ALICLOUD_SECRET_KEY:-$(read_credential access_key_secret)}"

info() { echo "[setup] $*"; }
die()  { echo "[setup] ERROR: $*" >&2; exit 1; }

# ---- 1. OSS bucket ----
if aliyun oss ls oss://"$BUCKET" >/dev/null 2>&1; then
  info "bucket 已存在: oss://$BUCKET"
else
  info "创建 bucket: oss://$BUCKET"
  aliyun oss mb oss://"$BUCKET" --storage-class Standard --acl public-read || die "创建 bucket 失败"
fi

# ---- 2. 静态网站托管（index.html / 404.html）----
WEBSITE_XML=$(mktemp)
cat > "$WEBSITE_XML" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<WebsiteConfiguration>
  <IndexDocument>
    <Suffix>index.html</Suffix>
  </IndexDocument>
  <ErrorDocument>
    <Key>404.html</Key>
  </ErrorDocument>
</WebsiteConfiguration>
EOF
ossutil website --method put oss://"$BUCKET"/ "$WEBSITE_XML" \
  --endpoint "$OSS_ENDPOINT" --access-key-id "$ACCESS_KEY" --access-key-secret "$SECRET_KEY" \
  >/dev/null || die "配置静态网站托管失败"
rm -f "$WEBSITE_XML"
info "静态网站托管已配置: index.html / 404.html"

# ---- 2.5 关闭阻止公共访问（bucket 级）----
python3 "$(dirname "$0")/fix_public_access.py" || die "关闭阻止公共访问失败"
info "阻止公共访问已关闭"

# ---- 3. CDN 加速域名 ----
if aliyun cdn DescribeCdnDomainDetail --DomainName "$CDN_DOMAIN" >/dev/null 2>&1; then
  info "CDN 域名已存在: $CDN_DOMAIN"
else
  info "创建 CDN 域名: $CDN_DOMAIN"
  aliyun cdn AddCdnDomain \
    --DomainName "$CDN_DOMAIN" \
    --CdnType web \
    --Sources "[{\"type\":\"oss\",\"content\":\"$BUCKET.$OSS_ENDPOINT\",\"port\":443,\"priority\":\"20\"}]" \
    || die "创建 CDN 域名失败"
fi

# ---- 等待 CDN 域名上线（最多 3 分钟）----
STATUS=""
for _ in $(seq 1 36); do
  STATUS=$(aliyun cdn DescribeCdnDomainDetail --DomainName "$CDN_DOMAIN" \
    | jq -r '.GetDomainDetailModel.DomainStatus' 2>/dev/null || true)
  [ "$STATUS" = "online" ] && break
  sleep 5
done
info "CDN 域名状态: ${STATUS:-未知}"

# ---- 4. DNS CNAME ----
CNAME=$(aliyun cdn DescribeCdnDomainDetail --DomainName "$CDN_DOMAIN" \
  | jq -r '.GetDomainDetailModel.Cname' 2>/dev/null || true)
if [ -z "$CNAME" ] || [ "$CNAME" = "null" ]; then
  die "未获取到 CDN CNAME"
fi
EXISTING=$(aliyun alidns DescribeDomainRecords --DomainName "$ROOT_DOMAIN" \
  --RRKeyWord project.cloud --TypeKeyWord CNAME 2>/dev/null \
  | jq -r '.DomainRecords.Record[0].Value // empty' || true)
if [ -n "$EXISTING" ]; then
  info "DNS 记录已存在: project.cloud -> $EXISTING"
else
  info "添加 DNS 记录: project.cloud CNAME -> $CNAME"
  aliyun alidns AddDomainRecord \
    --DomainName "$ROOT_DOMAIN" \
    --RR "project.cloud" \
    --Type CNAME \
    --Value "$CNAME" \
    || die "添加 DNS 记录失败"
fi

info "完成！"
info "  bucket : oss://$BUCKET"
info "  CDN    : https://$CDN_DOMAIN -> $CNAME"
info "  HTTPS  : 需在 CDN 控制台为 $CDN_DOMAIN 绑定证书（免费证书或已有 *.quanttide.com 通配符证书不覆盖二级子域）"
