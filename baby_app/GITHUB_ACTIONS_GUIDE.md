# GitHub Actions 构建 APK 指南

## 为什么使用 GitHub Actions？

如果 Codemagic 卡住，GitHub Actions 是完美的替代方案：
- ✅ 完全免费
- ✅ 无需额外注册
- ✅ 已配置好，直接使用

---

## 使用方法

### 1. 触发构建

代码已推送到 GitHub，构建会自动触发。

或者手动触发：
1. 访问 https://github.com/Lemon-shark-cjp/babyAPP
2. 点击 "Actions" 标签
3. 点击 "Build APK"
4. 点击 "Run workflow"

### 2. 等待构建完成

- 构建时间：约 5-10 分钟
- 可以在 Actions 页面查看进度

### 3. 下载 APK

构建完成后：
1. 进入完成的 workflow
2. 底部 "Artifacts" 部分
3. 点击 "release-apk" 下载

---

## 查看构建状态

访问：
https://github.com/Lemon-shark-cjp/babyAPP/actions/workflows/build_apk.yml

---

## 🚀 快速开始（推荐）

**立即构建 APK：**

👉 **点击这个链接直接开始：**
https://github.com/Lemon-shark-cjp/babyAPP/actions/workflows/build_apk.yml

然后：
1. 点击右侧 "Run workflow"
2. 再点击绿色的 "Run workflow"
3. 等待 5-10 分钟
4. 下载 APK（在页面底部的 Artifacts）

---

## 详细步骤

---

## 常见问题

### Q: 构建失败怎么办？
A: 点击失败的 workflow，查看日志，通常是依赖问题。

### Q: APK 在哪里？
A: 在完成的 workflow 页面底部，Artifacts 部分。

### Q: 可以自动发送到邮箱吗？
A: GitHub Actions 不支持直接发邮件，需要下载。

---

## 对比：Codemagic vs GitHub Actions

| 功能 | Codemagic | GitHub Actions |
|------|-----------|----------------|
| 价格 | 免费 500分钟/月 | 免费 2000分钟/月 |
| 易用性 | ⭐⭐⭐ 简单 | ⭐⭐ 中等 |
| Flutter优化 | ⭐⭐⭐ 专门优化 | ⭐⭐ 通用 |
| 邮件通知 | ✅ 支持 | ❌ 不支持 |
| 应用商店发布 | ✅ 支持 | ⚠️ 需配置 |

---

## 推荐

如果 Codemagic 卡住，**直接使用 GitHub Actions**！

访问：https://github.com/Lemon-shark-cjp/babyAPP/actions
