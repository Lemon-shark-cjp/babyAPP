# GitHub 仓库设置指南

## 方式一：使用脚本自动上传（推荐）

### 1. 在 GitHub 创建仓库

1. 访问 https://github.com/new
2. 填写信息：
   - **Repository name**: `baby_app`
   - **Description**: 宝宝成长记 - 母婴育儿记录App
   - ☑️ Public（或 Private）
   - ☐ Initialize with README（不要勾选）
3. 点击 **Create repository**

### 2. 复制仓库地址

创建后会显示类似：
```
https://github.com/你的用户名/baby_app.git
```

### 3. 运行上传脚本

```bash
cd /root/.openclaw/workspace/baby_app
./git_push.sh https://github.com/你的用户名/baby_app.git
```

### 4. 完成

脚本会自动：
- 添加所有文件
- 提交更改
- 推送到 GitHub

---

## 方式二：手动上传

### 1. 创建 GitHub 仓库（同上）

### 2. 执行 Git 命令

```bash
cd /root/.openclaw/workspace/baby_app

# 配置 Git（如果未配置）
git config user.email "your-email@example.com"
git config user.name "Your Name"

# 添加文件
git add lib/ assets/ pubspec.yaml *.md *.sh .github/

# 提交
git commit -m "Initial commit: Baby Growth Tracker App v1.0.0"

# 添加远程仓库
git remote add origin https://github.com/你的用户名/baby_app.git

# 推送
git push -u origin master
```

---

## 方式三：使用 GitHub Desktop（图形界面）

1. 下载 GitHub Desktop: https://desktop.github.com
2. 登录你的 GitHub 账号
3. File → Add local repository
4. 选择 `/root/.openclaw/workspace/baby_app`
5. 点击 "Publish repository"

---

## 验证上传

上传完成后：
1. 访问 `https://github.com/你的用户名/baby_app`
2. 确认文件都已上传
3. 查看代码是否正确

---

## 下一步：Codemagic 构建

代码上传后：
1. 访问 https://codemagic.io
2. 登录并点击 "Add application"
3. 选择 `baby_app` 仓库
4. 配置构建设置
5. 点击 "Start new build"
6. 下载生成的 APK

详细步骤见 `CODEMAGIC_SETUP.md`
