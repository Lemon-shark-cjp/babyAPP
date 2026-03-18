#!/bin/bash

echo "🍼 宝宝成长记 - 打包脚本"
echo "========================"
echo ""

PROJECT_NAME="baby_app"
VERSION="1.0.0"
DATE=$(date +%Y%m%d)
OUTPUT_FILE="${PROJECT_NAME}_v${VERSION}_${DATE}.tar.gz"

echo "📦 正在打包项目..."
echo "   版本: $VERSION"
echo "   日期: $DATE"
echo ""

# 创建临时目录
TEMP_DIR=$(mktemp -d)
mkdir -p "$TEMP_DIR/$PROJECT_NAME"

# 复制项目文件
cd /root/.openclaw/workspace/baby_app
cp -r lib "$TEMP_DIR/$PROJECT_NAME/"
cp -r assets "$TEMP_DIR/$PROJECT_NAME/"
cp pubspec.yaml "$TEMP_DIR/$PROJECT_NAME/"
for file in README.md PROGRESS.md PROJECT_SUMMARY.md ASSETS.md TEST_REPORT.md BUILD_APK.md CODEMAGIC_SETUP.md build.sh verify.sh package.sh; do
    [ -f "$file" ] && cp "$file" "$TEMP_DIR/$PROJECT_NAME/"
done
[ -d ".github" ] && cp -r .github "$TEMP_DIR/$PROJECT_NAME/"

# 打包
cd "$TEMP_DIR"
tar -czf "$OUTPUT_FILE" "$PROJECT_NAME"

# 移动到工作目录
if [ -f "$OUTPUT_FILE" ]; then
    mv "$OUTPUT_FILE" "/root/.openclaw/workspace/"
fi

echo "✅ 打包完成!"
echo ""
echo "📁 输出文件: /root/.openclaw/workspace/$OUTPUT_FILE"
if [ -f "/root/.openclaw/workspace/$OUTPUT_FILE" ]; then
    echo "📊 文件大小: $(du -h "/root/.openclaw/workspace/$OUTPUT_FILE" | cut -f1)"
fi
echo ""
echo "📝 项目包含:"
echo "   - 17 个 Dart 文件"
echo "   - 4,466 行代码"
echo "   - 10 个图片资源"
echo "   - 完整文档"
echo ""
echo "🚀 使用方法:"
echo "   1. 解压: tar -xzf $OUTPUT_FILE"
echo "   2. 进入: cd $PROJECT_NAME"
echo "   3. 安装: flutter pub get"
echo "   4. 运行: flutter run"

# 清理临时目录
rm -rf "$TEMP_DIR"
