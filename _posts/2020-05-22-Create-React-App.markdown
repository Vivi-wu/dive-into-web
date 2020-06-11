---
title:  "Create React App 使用tips"
category: JavaScript
---
根据官网所介绍，这是一个用于学习 React 的舒服的环境，是创建一个新的单页 React 应用最好的方式。

### 本地调试 PWA

使用 Create React App 创建的项目，根据 [create react app](https://create-react-app.dev/docs/making-a-progressive-web-app/) 官方文档：

1. 只有 production 环境开启了 serviceWorker
2. 如果需要本地测试离线服务，先用 `npm run build` 构建，然后从构建好的目录下使用标准的 http server 启动页面

实际上，构建之后在终端里可以看到下文：

```bash
The build folder is ready to be deployed.
You may serve it with a static server:
  npm install -g serve
  serve -s build
```
因为前端统一的线上自动化构建对于的目录是 dist，所以在项目根目录下运行： `serve -s dist`


### todo

使用自定义模板[Custom Templates](https://create-react-app.dev/docs/custom-templates/)创建新项目.

```bash
npx create-react-app my-app --template [template-name]
```

在 VS code 里安装 Chrome Debugger Extension，可以在代码里打断点，联动浏览器表现，保持连续的开发流程。

### 支持的语言功能

package.json 文件里的 `browserslist` 配置，使得开发时适于现代浏览器（开发时使用新语法，提升开发体验），而生产环境则覆盖最广范围的浏览器。

这个配置并不会自动安装 polyfills。因此使用 ES6+ features，需要自己手动安装合适的 polyfill。

学习、巩固[js语法新特性](https://create-react-app.dev/docs/supported-browsers-features#supported-language-features)

## Creating a Toolchain from Scratch

如果你倾向于自己设置 JS 工具链，官方也给了提示，一个 JavaScript toolchain 通常包含：

+ package manager，包管理工具，如 Yarn、 npm。让你方便第安装和更新，以充分利用强大生态系统里的第三方包
+ bundler 打包工具，如 webpack、Parcel。让你写模块化的代码，并打包成小文件，优化加载时间
+ compiler 编译器，如 Babel，让你能够写现代JS代码，而代码也能在旧浏览器里运行

一篇简单讲解如何让 React app 运行起来的文章 [Creating a React App… From Scratch.](https://blog.usejournal.com/creating-a-react-app-from-scratch-f3c693b84658) ，会有启发。

### eject

H5项目里引入mobX使用decorator，需要配置eslint，要么eject，要么官方推荐fork react-scripts。这次先eject