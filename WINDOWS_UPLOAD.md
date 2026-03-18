# Windows 系统上传指南

## 方法1：使用 GitHub Desktop（最简单，推荐）

### 1. 下载安装
- 访问 https://desktop.github.com
- 下载并安装 GitHub Desktop

### 2. 登录账号
- 打开 GitHub Desktop
- 登录你的 GitHub 账号

### 3. 克隆仓库
- 点击 "File" → "Clone repository"
- 选择 "URL" 标签
- 输入：`https://github.com/Lemon-shark-cjp/babyAPP.git`
- 选择本地保存路径（例如 `C:\Users\你的用户名\Documents\babyAPP`）
- 点击 "Clone"

### 4. 复制项目文件
- 下载 `baby_app_for_upload.tar.gz` 到你的电脑
- 解压到桌面（会得到 `baby_app` 文件夹）
- 打开克隆的 `babyAPP` 文件夹
- 将 `baby_app` 文件夹里的**所有内容**复制到 `babyAPP` 文件夹中

### 5. 提交推送
- 回到 GitHub Desktop
- 会看到所有变更的文件
- 填写提交信息：`Initial commit: Baby Growth Tracker App v1.0.0`
- 点击 "Commit to master"
- 点击 "Push origin"

### 6. 完成
- 访问 https://github.com/Lemon-shark-cjp/babyAPP 查看

---

## 方法2：使用命令行（Git Bash）

### 1. 安装 Git
- 访问 https://git-scm.com/download/win
- 下载并安装 Git for Windows

### 2. 打开 Git Bash
- 右键点击桌面 → "Git Bash Here"

### 3. 执行命令

```bash
# 进入你想保存的目录（例如桌面）
cd ~/Desktop

# 克隆仓库
git clone https://github.com/Lemon-shark-cjp/babyAPP.git
cd babyAPP

# 现在将 baby_app_for_upload.tar.gz 解压到当前目录
# 你可以用 7-Zip 或 WinRAR 解压

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit: Baby Growth Tracker App v1.0.0"

# 推送
git push origin master
```

---

## 方法3：使用 VS Code

### 1. 安装 VS Code
- 访问 https://code.visualstudio.com
- 下载并安装

### 2. 安装 Git
- 同上，安装 Git for Windows

### 3. 克隆仓库
- 打开 VS Code
- 点击左侧源代码管理图标（分支图标）
- 点击 "Clone Repository"
- 输入：`https://github.com/Lemon-shark-cjp/babyAPP.git`
- 选择保存位置

### 4. 复制文件
- 将解压后的 `baby_app` 文件复制到克隆的目录

### 5. 提交推送
- 在 VS Code 左侧源代码管理中
- 会看到所有变更
- 输入提交信息
- 点击 ✓ 提交
- 点击 ... → Push

---

## 方法4：网页直接上传（不需要 Git）

### 1. 访问仓库
- 打开 https://github.com/Lemon-shark-cjp/babyAPP

### 2. 上传文件
- 点击 "Add file" → "Upload files"
- 拖拽或选择文件
- 但是这个方法只能上传单个文件，不能上传文件夹结构

**不推荐**，因为文件太多。

---

## 推荐方案总结

| 方法 | 难度 | 推荐度 |
|------|------|--------|
| GitHub Desktop | ⭐ 简单 | ⭐⭐⭐ 最推荐 |
| Git Bash | ⭐⭐ 中等 | ⭐⭐ 适合程序员 |
| VS Code | ⭐⭐ 中等 | ⭐⭐ 适合开发者 |
| 网页上传 | ⭐⭐⭐ 困难 | ⭐ 不推荐 |

---

## 下一步

上传完成后：
1. 访问 https://github.com/Lemon-shark-cjp/babyAPP 确认
2. 访问 https://codemagic.io
3. 登录并添加项目
4. 构建 APK

详细步骤见 `CODEMAGIC_SETUP.md`
