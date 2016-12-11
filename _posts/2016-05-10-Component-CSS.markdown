---
title:  "Component CSS"
category: CSS
---
## Component CSS or CCSS

组件化的 CSS 是一种针对大型 web 应用，简化 CSS 创建体验的架构。本文主要观点摘自[这篇文章](http://www.sitepoint.com/introducing-ccss-component-css/)。

大型 web 应用通常会采用许多框架、工具，会有许多开发人员对一些 CSS 文件同时进行修改，因此我们需要一个可维护、可管理和可扩展的 CSS 体系结构。

基于组件化的 Web 开发将是大势所趋。Web 组件把标记和样式封装成可重用的 HTML 元素，这就意味着我们需要考虑**基于组件的 CSS 开发**。

<!--more-->

CCSS 的基本原则：

+ 可重用的 CSS 组件**不是**仅仅存在 DOM 树上某个特殊部分，或者需要配合使用特定的元素类型。
+ 每一个组件应该是隔离的，它不直接改变、依赖其他 CSS 组件。
+ **隔离比代码重用更重要！**，因为重用可能增加依赖，导致 css 可管理性降低

还有一些说得模棱两可，此处省略。

非常赞同的一点：关于 Documentation 文档/注释，许多人认为 CSS 是可自我解释的，但实际上，通常不是这样。 <span class="blue-text">CSS 组件必须有一个清晰的文档，用来描述它们是做什么，应该怎么使用</span>。

## File Organization / Directory Structure

下图给出使用 scss 的项目样式文件结构。

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
       |   |-- _base.scss
       |   |-- _bootstrap-overrides.scss
       |   |-- _layout.scss
       |   |-- _utility－classes.scss
       |   |__ images.scss
       |-- components
       |   |-- pages
       |   |   |-- _404.scss
       |   |   |-- _redirect.scss
       |   |__ standard
       |       |-- _dialog.scss
       |       |-- _modal.scss
       |       |__ _alarm-state.scss
       |-- main.scss
       |__ mixins
           |-- _animation.scss
           |__ _icon.scss
</pre>

1. 只编辑 `scss/` 文件夹下面的文件，方便位于 `ext/` 中的外部样式库的版本迭代。
2. 对于外部 CSS 框架，编译好的 css 文件放在根目录下，可配置可编译的 scss 文件放在 `ext/` 目录下。**不要修改这里的文件**（除非外部框架提供专门的 override 的配置文件，如 BT v4 的 _custom.scss 文件），对于框架里代码的重写和扩展放到 `base/` 目录下。
3. `base/` 目录用来放置**全局基本样式**。

    + 其中 `_base.scss` 只用来写 **元素选择器样式**（某种意义上的 CSS resets）
    + `_layout.scss` 用来书写布局相关的样式
    + `_utility－classes.scss` 用来写应用范围内（application－wide） 用于多页面、views、components 的 **utility 样式** 。以（`u-`）作为类名前缀。
    + `images.scss` 是作为 styles/image.css 文件的 SCSS 编译源文件，用来定义整站使用到的、 _Data URLs_ 形式的图片。
    + `_bootstrap-overrides.scss` 只用来放置**覆盖框架源码的CSS**。

4. 以上没有提到的，任何可重用的 CSS 单元被认为是一个组件，放到 `components/` 目录下。
5. 有一点很重要，组件里 CSS 类的定义顺序反应了 HTML 的结构。
6. 参考一下 <a href="http://sass-lang.com/documentation/file.SASS_REFERENCE.html" target="_blank">Sass guideline</a>。

## Naming Convention 命名规范

作者的举例：

+ u-className，全局的 base/utility 类
+ img-className，全局图片类
+ animate-className，全局动态效果类
+ ComponentName，标准组件
+ ComponentName-elementName，组建的元素
+ ComponentName--modifierName，组建的修饰

使用 UpperCamelCase 命名组件，来表明它是 master 元素。

注意：不要使用 hyphen （`-`）来分隔开组建的名称。
