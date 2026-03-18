#!/bin/bash

echo "🍼 宝宝成长记 - 代码验证脚本"
echo "==========================="
echo ""

# 检查项目结构
echo "📁 检查项目结构..."
REQUIRED_FILES=(
  "lib/main.dart"
  "lib/models/baby.dart"
  "lib/models/record.dart"
  "lib/providers/app_provider.dart"
  "lib/services/database_service.dart"
  "lib/screens/home_screen.dart"
  "lib/screens/record_screen.dart"
  "lib/screens/profile_screen.dart"
  "lib/screens/health_screen.dart"
  "lib/screens/settings_screen.dart"
  "lib/screens/onboarding_screen.dart"
  "lib/widgets/quick_record_buttons.dart"
  "lib/widgets/timeline_item.dart"
  "lib/widgets/record_dialogs.dart"
  "pubspec.yaml"
)

ALL_EXIST=true
for file in "${REQUIRED_FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "  ✅ $file"
  else
    echo "  ❌ $file (缺失)"
    ALL_EXIST=false
  fi
done

echo ""
echo "📊 代码统计..."
echo "  Dart 文件数: $(find lib -name '*.dart' | wc -l)"
echo "  总代码行数: $(find lib -name '*.dart' -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}')"
echo "  图片资源数: $(find assets/images -name '*.svg' | wc -l)"
echo ""

# 检查 pubspec.yaml
echo "📦 检查依赖配置..."
if [ -f "pubspec.yaml" ]; then
  echo "  主要依赖:"
  grep -E "^  (provider|fl_chart|table_calendar|sqflite):" pubspec.yaml | sed 's/^/    /'
fi

echo ""
if [ "$ALL_EXIST" = true ]; then
  echo "✅ 所有必要文件都存在！"
  echo ""
  echo "📝 提示: 当前环境没有 Flutter SDK，无法直接运行。"
  echo "   请在安装 Flutter 后执行: flutter run"
  exit 0
else
  echo "❌ 部分文件缺失"
  exit 1
fi
