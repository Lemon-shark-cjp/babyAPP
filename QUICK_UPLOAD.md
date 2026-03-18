# 快速上传到 GitHub

## 最简单的方法：网页上传

### 步骤1：准备文件

我已经生成了压缩包：
```
/root/.openclaw/workspace/baby_app_for_upload.tar.gz (46KB)
```

### 步骤2：在你的电脑上解压

```bash
# 下载压缩包后解压
tar -xzf baby_app_for_upload.tar.gz
```

### 步骤3：推送到 GitHub

```bash
# 进入解压后的目录
cd baby_app

# 初始化 git
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit"

# 添加远程仓库
git remote add origin https://github.com/Lemon-shark-cjp/babyAPP.git

# 推送
git push -u origin master
```

## 如果遇到权限问题

### 使用 GitHub Token

1. 访问 https://github.com/settings/tokens
2. 点击 "Generate new token (classic)"
3. 勾选 `repo` 权限
4. 生成 Token

5. 使用 Token 推送：
```bash
git remote set-url origin https://TOKEN@github.com/Lemon-shark-cjp/babyAPP.git
git push -u origin master
```

## 验证

上传成功后访问：
https://github.com/Lemon-shark-cjp/babyAPP

## 下一步：Codemagic 构建

1. 访问 https://codemagic.io
2. 登录并点击 "Add application"
3. 选择 babyAPP 仓库
4. 点击 "Start new build"
5. 下载 APK
