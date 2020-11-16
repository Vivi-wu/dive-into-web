---
title:  "React Native开发"
category: JavaScript
---

1.代码修改完，在simulator模拟器中 cmd + R 刷新，才能看到代码生效
2.模拟器里开启 Remote JS Debugging，在默认浏览器里新开tab（React Native Debugger），在开发者工具里就可以看到 console 输出了
3.使用 xcode 打开 ios 项目，等待扫描项目文件结束（时间长短与项目代码量有关）选择一个模拟器。在 RN 项目根目录下，新建 ios 文件夹，将 ios 项目代码移动到此文件夹中。启动 RN 项目，xcode 中点运行，将自动打开模拟器中的 app
4.使用 simulator 打包编译过一次 app 后，下次可直接打开 simulator。注意：记住打包时所选的系统版本和机型，再次打开 simulator -》File -》Open Simulator-》iOS 14.2 -》iPhone 8

## 第一个 RN 应用

[Mac上设置开发环境](https://reactnative.dev/docs/environment-setup)，选择 React Native CLI Quickstart。创建新应用 `npx react-native init 项目名称`。

安装依赖过程中遇到 CocoaPods 会让你选择使用 gem 还是 homebrew。如果 homebrew 安装失败，可以尝试：

```shell
brew cleanup -d -v
brew install cocoapods
```
确保安装成功后，再次运行 `npx react-native init 项目名称`，直到安装程序自行结束。

进入项目目录：

1. 启动 Metro，类似 webpack，先 resolution 解析模块引用依赖，与 transformation（将模块转换成 RN 可读的格式） 同时进行，当所有模块的转换结束，对 它们进行 serialization，生成一个或多个 js bundles。

    npx react-native start

2. 新开一个 Terminal 的标签，运行以下命令，building 需要一段时间，之后将自动打开指定的 iOS Simulator 并运行 app

    npx react-native run-ios

## 官方文档学习笔记

RN 在 0.58 版本以后已经支持 React HOOK，因此建议新的组件都写成 function components

在原生应用开发中，_view_ 是基本的 UI 构建模块。RN 的 [core components](https://reactnative.dev/docs/components-and-apis) 包含了一些重要的开箱即用的原生组件。

### ScrollView vs. List Views

前者是一个可包含多个组件和 views 的通用的滚动容器。所含 items 不一定是同类型的。既可以横向，也可以纵向滚动。支持横向 swiping 手势进行翻页。

ScrollView 最好用于展示具有 limited 尺寸的 small 数量的东西。因为**即使当前没有显示到屏幕上，其所含全部元素都被渲染**。

因此如果是组很长的 list 包含需要元素，建议使用 FlatList，仅渲染当前屏幕上显示的元素。

- 具有相似结构、数量随时间改变、可滚动的列表数据元素，使用 FlatList 组件
- 按照逻辑将一组数据划分成 section，可能有区块标题，那么使用 SectionList 组件

### Fast Refresh

默认是开启的。可以在 RN developer menu 里 Enable/Disable。类似热替换。

- 在 function 组件（HOOKs）里保持 RN local state
- 只要不改变参数或者 HOOK 的调用顺序，_useState_ 和 _useRef_ 将保留它们之前的值；而有依赖的 HOOKs，如：_useEffect_、_useMemo_ 和 _useCallback_ 在 fast refresh 时总是会 re-run。

### Debugging

iOS simulator 工具栏，Device-》Shake，或者快捷键 cmd+D，可以弹出 developer menu。

使用 standalone 版本的 RN 开发者工具，全局安装

```shell
npm install -g react-devtools
// 运行
react-devtools
```

注意：此时需要关闭 simulator 自带的 JS Debug，否则互相干扰导致app crash。

使用 in-app 的 Inspector，可以看到一个半透明浮层，显示 UI 元素。

如果已启动 react-devtools，这个 Inspector 将进入折叠模式，当在 simulator 里点击元素，将直接定位到 DevTools 中组件树的相关组件。

