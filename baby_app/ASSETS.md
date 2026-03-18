# 图片资源清单

## 应用图标

| 文件名 | 用途 | 尺寸 |
|--------|------|------|
| `app_icon.svg` | 应用启动图标 | 1024x1024 |

## 头像

| 文件名 | 用途 | 说明 |
|--------|------|------|
| `baby_avatar.svg` | 默认宝宝头像 | 中性配色 |
| `baby_boy.svg` | 男宝宝头像 | 蓝色系 |
| `baby_girl.svg` | 女宝宝头像 | 粉色系 |
| `mother_avatar.svg` | 妈妈头像 | 紫色系 |
| `father_avatar.svg` | 爸爸头像 | 蓝色系 |

## 占位图

| 文件名 | 用途 |
|--------|------|
| `placeholder_photo.svg` | 照片占位图 |

## 引导页

| 文件名 | 用途 | 说明 |
|--------|------|------|
| `onboarding_1.svg` | 引导页1 | 记录成长 |
| `onboarding_2.svg` | 引导页2 | 科学管理 |
| `onboarding_3.svg` | 引导页3 | 全家共享 |

## 使用方式

```dart
// 加载图片
Image.asset('assets/images/baby_avatar.svg')

// 头像选择
CircleAvatar(
  backgroundImage: AssetImage('assets/images/baby_${gender}.svg'),
)
```

## 注意事项

- 所有图片均为 SVG 格式，支持任意缩放
- 实际项目中可替换为真实照片
- 建议添加 1x/2x/3x 版本的 PNG 图片以优化性能
