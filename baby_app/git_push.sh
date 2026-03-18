#!/bin/bash

echo "🚀 宝宝成长记 - Git 上传脚本"
echo "============================"
echo ""

# 检查参数
if [ -z "$1" ]; then
    echo "❌ 请提供 GitHub 仓库地址"
    echo ""
    echo "使用方法:"
    echo "  ./git_push.sh https://github.com/用户名/baby_app.git"
    echo ""
    echo "或者先创建仓库:"
    echo "  1. 访问 https://github.com/new"
    echo "  2. 仓库名: baby_app"
    echo "  3. 点击 Create repository"
    echo "  4. 复制仓库地址"
    exit 1
fi

REPO_URL=$1

cd /root/.openclaw/workspace/baby_app

echo "📦 准备上传文件..."
echo ""

# 配置 Git（如果未配置）
if [ -z "$(git config user.email)" ]; then
    git config user.email "developer@example.com"
    git config user.name "Developer"
fi

# 添加所有项目文件
echo "➕ 添加文件到 Git..."
git add lib/
git add assets/
git add pubspec.yaml
git add README.md
git add PROJECT_SUMMARY.md
git add PROGRESS.md
git add ASSETS.md
git add TEST_REPORT.md
git add BUILD_APK.md
git add CODEMAGIC_SETUP.md
git add build.sh
git add verify.sh
git add package.sh
git add .github/

# 提交
echo "💾 提交更改..."
git commit -m "Initial commit: Baby Growth Tracker App v1.0.0

Features:
- 6 complete screens (Onboarding, Home, Records, Profile, Health, Settings)
- Record dialogs (Feeding, Sleep, Food, Diaper)
- SQLite database with 5 models
- Provider state management
- 10 SVG image assets
- CI/CD configuration (Codemagic + GitHub Actions)

Total: 17 Dart files, 4,466 lines of code"

# 检查是否在子目录
if [ -d "baby_app" ]; then
    echo "⚠️  检测到代码在 baby_app/ 子目录，需要移动到根目录..."
    mv baby_app/* .
    mv baby_app/.* . 2>/dev/null || true
    rmdir baby_app
fi

# 添加远程仓库
echo "🔗 配置远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"

# 推送
echo "📤 推送到远程仓库..."
git push -u origin master 2>/dev/null || git push -u origin main 2>/dev/null || echo "推送失败，请检查权限"

echo ""
echo "✅ 上传完成!"
echo ""
echo "🌐 仓库地址: $REPO_URL"
echo ""
echo "下一步:"
echo "  1. 访问 $REPO_URL 确认代码已上传"
echo "  2. 登录 https://codemagic.io"
echo "  3. 添加项目并构建 APK"
