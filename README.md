# WebF Demo

这是一个使用 WebF 框架的 Flutter 示例项目。

## 项目结构

```
webf_demo/
├── lib/
│   └── main.dart          # 主应用代码
├── android/               # Android 平台配置
├── web/                   # Web 平台配置
└── pubspec.yaml           # 依赖配置
```

## 功能特性

- 集成 WebF 渲染引擎
- 在 Flutter 中渲染 HTML/CSS 内容
- 支持交互式 Web 内容

## 运行项目

确保已安装 Flutter SDK：

```bash
# 安装依赖
flutter pub get

# 运行 Android 版本
flutter run -d android

# 运行 Web 版本
flutter run -d chrome
```

## 注意事项

1. WebF 通过 GitHub 依赖集成，首次运行需要下载源码
2. WebF 当前处于活跃开发阶段，API 可能会有变化
3. 建议使用 Flutter 3.0+ 版本
