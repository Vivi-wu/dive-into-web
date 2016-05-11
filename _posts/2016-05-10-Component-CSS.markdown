---
title:  "Component CSS, 了解 ionic"
category: CSS
---
## Component CSS

组件化的 CSS 是一种针对大型 web 应用，简化 CSS 创建体验的结构。本文主要观点摘自[这篇文章](http://www.sitepoint.com/introducing-ccss-component-css/)。

大型 web 应用通常有许多开发人员同时工作在大量的 CSS 文件上，开发人员需要一个可维护、可管理和可扩展的 CSS 结构。

文章里关于 CCSS 的基本原则感觉说得比较模棱两可，这里就不一一列举了。

赞同的一点：关于 Documentation，许多人认为 CSS 是可自我解释的，但实际上，通常不是这样的。<span class="blue-text">CSS 组件必须有一个清晰的文档，用来描述它们是做什么，应该怎么使用</span>。

### Naming Convention

作者的举例：

+ u-className，全局的 base/utility 类
+ img-className，全局图片类
+ animate-className，全局动态效果类
+ ComponentName，标准组件
+ ComponentName-elementName，组建的元素
+ ComponentName--modifierName，组建的修饰

<!--more-->

注意：不要使用 hyphen （`-`）来分隔开组建的名称。

### File Organization

<pre>
styles
   |-- bootstrap.css
   |-- ext
   |   |-- bootstrap
   |   |   |-- _settings.scss
   |   |   |__ bootstrap.scss
   |   |__ font-awesome
   |       |__font-awesome.scss
   |-- font-awesome.css
   |-- images.css
   |-- main.css
   |__ scss
       |-- base
       |   |-- _base－classes.scss
       |   |-- _base.scss
       |   |-- _bootstrap-overrides.scss
       |   |__ images.scss
       |-- components
       |-- main.scss
       |__ mixins
           |-- _animation.scss
           |-- _icon.scss
</pre>

1. 考虑到一些应用使用外部 CSS 框架，将它们的 CSS 文件放在样式根目录下，可配置可编译的 scss 文件放在 **ext/** 目录下。方便更新外部 CSS 样式库。**不要修改这里的文件**，对于框架里代码的重写和扩展，放到 **base/** 目录下。
2. **base/** 目录用来放置 global base style **全局基本样式**。其中 **_base.scss** 只用来写 element selectors **元素选择器样式**（某种意义上的 CSS resets）
3. **_base－classes.scss** 用来写所有 application－wide 用于多页面、views、components 的 **utility 样式** 。以（`u-`）作为类名前缀。
4. **images.scss** 是作为 styles/image.css 文件 SCSS 编译的源文件，用来定义和 inline all site images 作为 _Data URLs_ 。
5. **_bootstrap-overrides.scss** 只用来放置**对于框架重写的代码**。有时框架里的选择器有非常高的特殊性（CSS 权重高），重写它们需要很长的特殊选择器，因此对于框架的重写不要放在组件的环境里，而是放在这里。
6. 以上没有提到的，任何可重用的 CSS 单元被认为是一个组件，放到 **components** 目录下。
7. 有一点很重要，组建里 CSS 类的定义顺序反应了 HTML 的结构。遵循 CSS/Sass guideline

## 了解 ionic

碰巧看到的，就了解一下。[官网](http://ionicframework.com/) 。

<span class="blue-text">使用 web 技术（针对移动设备优化的 HTML、CSS、JS 组件和工具）创建高互动的原生 mobile apps 的工具</span>。开源免费。搭配 Sass，为 AngularJS 优化。

实际上是一个 HTML5 应用开发框架（需要一个本地的包装层如 **Cordova** 或 PhoneGap 将它运行在一个本地应用中），构建混合移动应用。混合移动应用是运行在 app 浏览器壳里的网站（就像 iOS 中的 UIWebView 或者安卓里的 WebView，这个网站不能通过一个 URL 进行链接，只能在内部进行跳转），同时可以访问本地平台层。

可以理解成针对本地应用开发的 Bootstrap 框架，它支持很多常见本地移动组件，设计精美。

PS：谷歌搜索中的结果，对于 Cordova 和 PhoneGap 的区别是这样说的：

PhoneGap 是 Apache Cordova 的一个 distribution，可以认为 Apache Cordova 是支持 PhoneGap 的引擎，与 Webkit 是 power Chrome 和 safari 相似。
