# GitHub 认证方式

## 问题
当前环境无法直接推送到 GitHub，需要认证。

## 解决方案

### 方案1：使用 GitHub Token（推荐）

1. 生成 Token：
   - 访问 https://github.com/settings/tokens
   - 点击 "Generate new token (classic)"
   - 勾选 `repo` 权限
   - 生成并复制 Token

2. 使用 Token 推送：
   ```bash
   cd /root/.openclaw/workspace/baby_app
   git remote set-url origin https://TOKEN@github.com/Lemon-shark-cjp/babyAPP.git
   git push -u origin master
   ```

### 方案2：手动上传（最简单）

1. 下载项目压缩包：
   ```bash
   cd /root/.openclaw/workspace
   tar -czf baby_app_for_github.tar.gz baby_app/
   ```

2. 在你的电脑上：
   - 解压文件
   - 进入 baby_app 目录
   - 执行：
     ```bash
     git init
     git add .
     git commit -m "Initial commit"
     git remote add origin https://github.com/Lemon-shark-cjp/babyAPP.git
     git push -u origin master
     ```

### 方案3：使用 GitHub CLI

```bash
# 安装 GitHub CLI
# 然后登录
git push -u origin master
```

---

## 推荐：方案2 - 手动上传

因为安全原因，当前环境无法存储 GitHub 凭证，建议：

1. 下载压缩包
2. 在本地解压
3. 推送到你的仓库

需要我生成压缩包吗？
