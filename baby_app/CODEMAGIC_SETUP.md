# Codemagic CI/CD 配置指南

## 什么是 Codemagic？

Codemagic 是一个专为 Flutter 设计的 CI/CD 平台，可以：
- 🔄 自动构建 APK/IPA
- 📱 发布到应用商店
- 🧪 运行测试
- 📊 生成构建报告

## 快速开始

### 1. 注册账号

访问 https://codemagic.io
- 点击 "Sign up"
- 使用 GitHub/GitLab/Bitbucket 账号登录

### 2. 添加项目

1. 登录后点击 "Add application"
2. 选择代码仓库（GitHub/GitLab/Bitbucket）
3. 选择 `baby_app` 项目
4. 点击 "Add application"

### 3. 配置构建设置

#### Flutter 版本
```
Stable channel
```

#### Build triggers（构建触发器）
- ☑️ Trigger on push
- ☑️ Trigger on pull request
- ☐ Trigger on tag creation

#### Build platforms
- ☑️ Android
- ☐ iOS（需要 Apple Developer 账号）

### 4. 配置构建脚本

在 "Build" 标签页添加：

```yaml
# Pre-build script
flutter pub get

# Build script
flutter build apk --release
```

### 5. 配置代码签名（Android）

#### 方式1：自动生成（测试用）
Codemagic 会自动生成调试签名

#### 方式2：使用自己的签名（发布用）

1. 生成签名密钥：
```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. 在 Codemagic 中：
   - 进入 "Code signing" 标签
   - 点击 "Android keystore"
   - 上传 `upload-keystore.jks`
   - 填写密钥信息

3. 创建 `android/key.properties`：
```properties
storePassword=你的密码
keyPassword=你的密码
keyAlias=upload
storeFile=../upload-keystore.jks
```

### 6. 配置发布

#### 方式1：下载 APK
- 构建完成后自动提供下载链接

#### 方式2：发送到邮箱
在 "Distribution" 标签：
```
Email: your-email@example.com
```

#### 方式3：发布到 Google Play
需要：
- Google Play Developer 账号
- Service Account JSON

### 7. 开始构建

点击 "Start new build"

等待 5-10 分钟，构建完成后：
- 下载 APK
- 或自动发送到配置的邮箱

## 完整 codemagic.yaml 配置

在项目根目录创建 `codemagic.yaml`：

```yaml
workflows:
  android-workflow:
    name: Android Build
    instance_type: mac_mini_m1
    max_build_duration: 30
    environment:
      flutter: stable
      xcode: latest
      cocoapods: default
    cache:
      cache_paths:
        - ~/.pub-cache
        - $CM_BUILD_DIR/.dart_tool
    triggering:
      events:
        - push
        - pull_request
      branch_patterns:
        - pattern: main
          include: true
          source: true
    scripts:
      - name: Get dependencies
        script: flutter pub get
      - name: Build APK
        script: flutter build apk --release
    artifacts:
      - build/app/outputs/flutter-apk/*.apk
    publishing:
      email:
        recipients:
          - your-email@example.com
        notify:
          success: true
          failure: true
```

## 使用步骤总结

1. **上传代码到 GitHub/GitLab**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/baby_app.git
   git push -u origin main
   ```

2. **在 Codemagic 添加项目**
   - 登录 https://codemagic.io
   - 选择仓库

3. **配置构建设置**
   - 选择 Flutter 版本
   - 启用 Android 构建

4. **开始构建**
   - 点击 "Start new build"

5. **下载 APK**
   - 构建完成后下载

## 免费额度

Codemagic 免费版：
- 每月 500 分钟构建时间
- 无限公共仓库
- 私有仓库需要付费

## 替代方案

如果 Codemagic 不方便，还可以使用：
- **GitHub Actions** - 免费，配置稍复杂
- **GitLab CI** - 免费，适合 GitLab 用户
- **Bitrise** - 类似 Codemagic

## 需要帮助？

- 📖 官方文档：https://docs.codemagic.io
- 💬 社区论坛：https://github.com/codemagic-ci-cd/codemagic-docs/discussions
