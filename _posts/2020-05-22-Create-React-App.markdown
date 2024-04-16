---
title:  "Create React App Tips"
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
<!--more-->

因为目前前端项目的线上自动化构建，对应的目录名是 dist，所以在项目根目录下运行： `serve -s dist`。

这只是一个服务器，不支持hot reload。

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

一篇简单讲解如何让 React app 运行起来的文章 [Creating a React App… From Scratch.](https://blog.usejournal.com/creating-a-react-app-from-scratch-f3c693b84658) 。

### eject

H5项目里引入mobX使用decorator，需要配置eslint，要么eject，要么官方推荐fork react-scripts。

## Pre-rendering HTML

[Pre-Rendering into Static HTML Files](https://create-react-app.dev/docs/pre-rendering-into-static-html-files) 官网说如果你的 build 文件放在一个静态托管服务器上，可使用 [react-snapshot](https://github.com/geelen/react-snapshot) 或者 [react-snap](https://github.com/stereobooster/react-snap) 为每一个 route 、或者你应用里 relative link 生成 HTML 页面。这些页面在js bundle 加载完成时将无缝地变成 active。

这两个工具前者最后一次更新在 17年11月，64个issue，后者在 19年10月，95个issue。感觉有坑。

预渲染的好处是，无论你的js bundle 是否成功下载，你可以通过 HTML 的 payload 获取每个页面的核心内容，这样也增加了搜索引擎选择你应用每个路由的可能性。

### 预渲染踩坑记录

采用 react-snapshot，自从项目引入 react-app-rewired，预渲染失效了。

```shell
🕷   Starting crawling http://localhost:55340/
🔥 'render' from react-snapshot was never called. Did you replace the call to ReactDOM.render()?
🕸   Finished crawling.
```

网上搜了一圈没找到解决办法。改用 react-snap 在本地运行是ok了。但是，推到测试环境的 Linux 机器上又不行。。。

```shell
Error: Failed to launch chrome!
/var/opt/jenkins/workspace/fe_easyboost_login_develop/node_modules/puppeteer/.local-chromium/linux-686378/chrome-linux/chrome: error while loading shared libraries: libX11-xcb.so.1: cannot open shared object file: No such file or directory

TROUBLESHOOTING: https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md
```

官方 github issue 里找到相同的问题 [Failed to launch chrome! (Ubuntu)](https://github.com/stereobooster/react-snap/issues/256)，运维表示解决不了。

以 react-snapshot 为例，将所有公共可获取的页面做一个静态网页快照，剩下需要 auth 的任何东西保持原样，还是 js 驱动的单页应用。

看[描述](https://github.com/geelen/react-snapshot#options)，可以指定额外的 path 作为 entry points 用于crawling（爬取）什么意思？可以生成多页？

对于不简单的 case，作者推荐了 [Webpack Static Site Generator Plugin](https://github.com/markdalgleish/static-site-generator-webpack-plugin)

此外，作者说如果你的应用有更加复杂的 stuff，比如需要 login 后预渲染，那就做 server-side react node server

#### postcss

想引入plugins，官方不支持，尝试不 eject 的方法。antd 推荐了一个 [craco](https://github.com/gsoft-inc/craco/blob/master/packages/craco/README.md#installation)，没例子不会用。看了下 Acknowledgements 里有[react-app-rewired](https://github.com/timarney/react-app-rewired)，start 数挺多了，很多文章也是基于这个。

另外这个工具配套有[React App Rewire PostCSS](https://github.com/csstools/react-app-rewire-postcss)，用起来简单直接。项目里主要是用 postcss-px-to-viewport 这个插件。

```js
// 参考 front-web 项目
require('postcss-px-to-viewport')({
  viewportWidth: 750, // 视窗的宽度，对应的是我们设计稿的宽度，一般是750
  viewportHeight: 1334, // 视窗的高度，根据750设备的宽度来指定，一般指定1334，也可以不配置
  unitPrecision: 3, // 指定`px`转换为视窗单位值的小数位数（很多时候无法整除)
  viewportUnit: 'vw', // 指定需要转换成的视窗单位，建议使用vw
  selectorBlackList: ['.ignore', '.hairlines'], // 指定不转换为视窗单位的类，可以自定义，可以无限添加,建议定义一至两个通用的类名
  minPixelValue: 1, // 小于或等于`1px`不转换为视窗单位，你也可以设置为你想要的值
  mediaQuery: false, // 允许在媒体查询中转换`px`
})
```

坑死了。selectorBlackList 文档说支持写正则表达式，实际不生效。我们项目自定义 bt 主题，exclude 文件不起作用。单行注释 ignore 也不生效。

烦死了，为了支持 decorator 语法，网上找到方案要么过时，要么建议再安装一个 customize-cra。

好不容易在 create-react-rewire 文档推荐里找到 react-app-rewire-babel-loader，结果作者说他不维护了。

社区没有统一解决方案，不稳定。

好嘛那就不用装饰器的写法，安那个customize-cra，结果报路径找不到，其他的问题。

## 引入antd

2020.7.8
国外主流都用 sass，且CRA默认支持 sass-loader，antd 官方只支持less，不提供好的适配方法，让自己 google。

针对不同情况的解决办法：

+ 静态单页面（含少量js交互，使用已封装好的第三方组件），选用 sass，bootstrap 按需引入，抽出颜色、字体变量文件，在组件里 override 样式。使用 react-app-rewired、customize-cra。【Easyboost landing】
+ 复杂单页应用（需要 auth，单独 login 页，含路由），eject【Easyboost】

最新版create react app创建项目后，官方加了一个 `<React.StrictMode>` 于是 antD 的 button 组件报错
```shell
https://github.com/ant-design/ant-design/issues/22493
Using <Button> results in "findDOMNode is deprecated in StrictMode" warning
```

想抽出 Sider 组件，单独侦听数量变化，结果不行，必现放在 layout 组件里，且影响布局。

Input 组件没有校验，必现内嵌在Form组件里。校验规则设置在 Form.Item 组件上，且必须提供 name（相当于提交字段名，默认会设置为组件 id 的属性值），同时在 Form 组件 initialValues 里提供同名属性及输入框初始值。

清空输入框后显示 placeholder，必须设置 value 为 null。

在 Form 组件上设置唯一name，移除console warning（列表循环内有form，会导致输入组件id重名）。[表单名称](https://ant.design/components/form-cn/) 会作为表单字段 id 前缀使用

Modal组件 mask 的 z-index 默认是1000，当页面上同时有多个modal，最好按层级关系手动设置的 z-index，否则可能因为 modal 渲染的顺序，导致互相遮挡
