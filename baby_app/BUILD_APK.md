# 构建 APK 说明

## 环境要求

- Flutter SDK 3.0+
- Android Studio 或 Android SDK
- Java JDK 11+

## 快速构建步骤

### 1. 安装 Flutter

```bash
# macOS
brew install flutter

# Windows
# 下载: https://docs.flutter.dev/get-started/install/windows

# Linux
sudo snap install flutter --classic
```

### 2. 验证环境

```bash
flutter doctor
```

确保以下项目都是 ✅：
- Flutter SDK
- Android toolchain
- Android Studio (可选)

### 3. 构建 APK

```bash
# 进入项目目录
cd baby_app

# 获取依赖
flutter pub get

# 构建 Release APK
flutter build apk --release

# 构建结果位置：
# build/app/outputs/flutter-apk/app-release.apk
```

### 4. 安装到手机

```bash
# 方式1：自动安装
flutter install

# 方式2：手动安装
# 将 APK 复制到手机，点击安装
```

## 构建脚本

已提供 `build.sh` 脚本，直接运行：

```bash
cd baby_app
./build.sh
```

## 常见问题

### 问题1：找不到 Android SDK
```bash
# 设置 ANDROID_HOME
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

### 问题2：签名错误
```bash
# 生成签名密钥
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# 创建 android/key.properties 文件
```

### 问题3：构建失败
```bash
# 清理后重新构建
flutter clean
flutter pub get
flutter build apk --release
```

## 文件大小

- Debug APK: ~50MB
- Release APK: ~20MB (推荐)

## 下一步

构建完成后，APK 文件在：
```
build/app/outputs/flutter-apk/app-release.apk
```

可以通过以下方式安装：
1. USB 连接手机：`flutter install`
2. 发送到手机：微信、QQ、邮件
3. 上传到应用商店
