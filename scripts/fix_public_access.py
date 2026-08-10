#!/usr/bin/env python3
"""查询/关闭 OSS 公共访问阻止（bucket 级 + 账号级）"""
import base64
import hashlib
import hmac
import json
import sys
import urllib.request

CONFIG = json.load(open("/home/iguo/.aliyun/config.json"))["profiles"][0]
AK = CONFIG["access_key_id"]
SK = CONFIG["access_key_secret"]


def sign(method, resource, date, content_type="", content_md5=""):
    string_to_sign = f"{method}\n{content_md5}\n{content_type}\n{date}\n{resource}"
    digest = hmac.new(SK.encode(), string_to_sign.encode(), hashlib.sha1).digest()
    return "OSS " + AK + ":" + base64.b64encode(digest).decode()


def request(method, url, resource, body=None):
    date = urllib.request.Request(url, method=method)
    headers = {"Date": __import__("email").utils.formatdate(usegmt=True)}
    if body is not None:
        headers["Content-Type"] = "application/xml"
    auth = sign(method, resource, headers["Date"], headers.get("Content-Type", ""))
    headers["Authorization"] = auth
    req = urllib.request.Request(url, method=method, headers=headers, data=body.encode() if body else None)
    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            return resp.status, resp.read().decode()
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode()


BUCKET = "qtcloud-project-studio"
ENDPOINT = "oss-cn-hangzhou.aliyuncs.com"

# 1. bucket 级
status, body = request("GET", f"https://{BUCKET}.{ENDPOINT}/?publicAccessBlock", f"/{BUCKET}/?publicAccessBlock")
print("bucket 级 publicAccessBlock:", status, body.strip()[:200])
if "BlockPublicAccess" in body and "<BlockPublicAccess>true" in body:
    status, body = request(
        "PUT", f"https://{BUCKET}.{ENDPOINT}/?publicAccessBlock", f"/{BUCKET}/?publicAccessBlock",
        '<?xml version="1.0" encoding="UTF-8"?>\n<PublicAccessBlockConfiguration><BlockPublicAccess>false</BlockPublicAccess></PublicAccessBlockConfiguration>')
    print("关闭 bucket 级阻止:", status, body.strip()[:200])

# 2. 账号级
status, body = request("GET", f"https://{ENDPOINT}/?blockPublicAccess", "/?blockPublicAccess")
print("账号级 blockPublicAccess:", status, body.strip()[:200])
if "BlockPublicAccess" in body and "<BlockPublicAccess>true" in body:
    status, body = request(
        "PUT", f"https://{ENDPOINT}/?blockPublicAccess", "/?blockPublicAccess",
        '<?xml version="1.0" encoding="UTF-8"?>\n<BlockPublicAccessConfiguration><BlockPublicAccess>false</BlockPublicAccess></BlockPublicAccessConfiguration>')
    print("关闭账号级阻止:", status, body.strip()[:200])
