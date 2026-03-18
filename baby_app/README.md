# 宝宝成长记 - 母婴育儿App

一款专注于0-3岁宝宝成长的育儿记录工具，支持安卓和鸿蒙双平台。

## 功能模块

### 1. 首页
- 宝宝信息卡片（年龄、疫苗提醒）
- 快捷记录按钮（喂奶、睡觉、辅食、排便、体温、拍照）
- 今日数据概览
- 最近记录时间轴

### 2. 记录页
- 日历视图（周/月切换）
- 今日相册展示
- 详细时间轴（支持照片、视频标记）
- 快速添加记录

### 3. 档案页
- 宝宝基本信息
- 生长曲线图表（体重/身高/头围/BMI）
- 疫苗接种计划（已接种/待接种）
- 成长里程碑记录

### 4. 健康页
- 健康工具（体温/用药/症状自查/医院导航/急救指南）
- 健康档案管理
- 常见症状护理指南

### 5. 我的
- 用户信息
- 多宝宝管理
- 家人共享
- 设置（云同步、数据导出、提醒、夜间模式）

## 技术栈

- **框架**: Flutter 3.x
- **语言**: Dart
- **图表**: fl_chart
- **日历**: table_calendar
- **数据库**: SQLite + SharedPreferences

## 项目结构

```
baby_app/
├── lib/
│   ├── main.dart              # 应用入口
│   ├── screens/               # 页面
│   │   ├── home_screen.dart   # 首页
│   │   ├── record_screen.dart # 记录页
│   │   ├── profile_screen.dart# 档案页
│   │   ├── health_screen.dart # 健康页
│   │   └── settings_screen.dart # 设置页
│   └── widgets/               # 组件
│       ├── quick_record_buttons.dart
│       └── timeline_item.dart
├── pubspec.yaml
└── README.md
```

## 运行方式

```bash
# 安装依赖
flutter pub get

# 运行调试
flutter run

# 构建安卓APK
flutter build apk --release

# 构建鸿蒙HAP（需鸿蒙SDK）
flutter build hap --release
```

## 设计特点

- 温暖的珊瑚橙主色调
- 圆角卡片式UI
-  emoji图标增强亲和力
- 底部5Tab导航
- 支持照片/视频记录
- 生长曲线可视化
