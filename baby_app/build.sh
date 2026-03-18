#!/bin/bash

echo "🍼 宝宝成长记 - 构建脚本"
echo "========================"

# 检查Flutter环境
if ! command -v flutter &> /dev/null; then
    echo "❌ 错误：未找到Flutter，请先安装Flutter SDK"
    exit 1
fi

echo ""
echo "📦 步骤1: 获取依赖..."
flutter pub get

echo ""
echo "🔍 步骤2: 代码检查..."
flutter analyze

echo ""
echo "🧪 步骤3: 运行测试..."
flutter test

echo ""
echo "📱 步骤4: 构建Android APK..."
flutter build apk --release

echo ""
echo "📦 步骤5: 构建Android App Bundle..."
flutter build appbundle --release

echo ""
echo "✅ 构建完成！"
echo ""
echo "输出文件:"
echo "  - APK: build/app/outputs/flutter-apk/app-release.apk"
echo "  - AAB: build/app/outputs/bundle/release/app-release.aab"
echo ""
echo "安装到设备:"
echo "  flutter install"
