---
title:  "CSS Responsive Web Design"
category: CSS
---
当你使用 CSS 和 HTML 通过重定义大小、隐藏、收缩、拉伸或者移动内容，使它在所有屏幕上看起来不错，这就叫做响应式设计。

本文列举一些面向响应式 Web 设计的技巧。

<!--more-->

## Images

1. 设 _width_ 属性值为 `100%`

    这样图片可以随父元素一起放大或缩小。**缺点**：图片可能被放大到超过原始尺寸，变得非常不清晰。<span class="t-blue">在许多情况下是使用 _max-width_ </span>。

2. 设 _max-width_ 属性值为 `100%`
  
    这样如果父元素的容器宽度小于图片原始宽度，图片会相应地缩小显示。若父元素容器宽度（远）大于图片宽度，图片至多按原始尺寸显示，而不会无限放大。

3. 背景图通过设定 _background-size_ 属性，也可以对容器放大和调整尺寸作出响应，参看 CSS Background 章节。

4. 针对不同设备，使用不同尺寸的图片。

    通过使用媒体查询 _min-device-width_ 检查**设备宽度**，在对应情况下加载合适的图片。当然也可以使用 _min-width_，但是这样在调整浏览器窗口尺寸的时候，也会导致重新加载图片。

## Videos

设 _width_ 属性值为 `100%`，效果同 RWD images。设 _max-width_ 属性值为 `100%`，效果同 RWD images

## 媒体查询

<span class="t-blue">把适用于手机屏幕的 css 代码作为一般情况</span>，而用于大屏幕的 css 代码放在 media queries 媒体查询里，这就是 **mobile first** 的思路。

## Viewport

viewport 是一个网页中用户可以看到的区域。经常看到下面这段代码，为什么要这样做？

    <meta name="viewport" content="width=device-width, initial-scale=1.0">  

其中 `width=device-width`  根据设备屏幕宽度来设置页面宽度。

只设定这个的话，在 iPhone 上，当旋转至横屏模式，手机会显示一个 weird 的放大结果。

`initial-scale=1.0` 设置浏览器第一次加载页面的初始放大等级。添加上面这个设置，横屏、竖屏就会有一样的放大效果。

正如猜测的，就目前来说：Without initial scale you get the zooming bug in rotation(and sometimes compounded effects on double rotation) and media queries for the landscape mode being ignored. No such problems occur when the initial scale=1 is added.

## Grid system

原文地址：[How to build a responsive grid system](https://zellwk.com/blog/responsive-grid-system/)

### 主要从以下三方面考虑：

+ 设计栅格：等宽？多少列？栅格列以及间距的尺寸？
+ 在不同宽度的视区栅格如何表现：栅格列 resize？间距固定？在特定的断点改变栅格数量？
+ HTML（如 Bootstrap，栅格样式写在 HTML 中，这就要求必须使用一定的结构），还是 CSS式（栅格定义在 CSS 里，一定程度上减少 markup）的栅格系统。

### 具体步骤

1. 选择一种技术实现你的栅格：CSS Grid（目前主流浏览器都不支持），Flexbox，或者最简单的 floats
2. 设置所有元素的盒模型为边框盒：

    *, *:before, *:after { box-sizing: inherit; }

3. 创建栅格最外层容器，设定最大宽度，左右外边距 auto
4. 计算栅格列的宽度，这里讨论有间距的栅格系统（无间距的宽度平均分就好了）。四种实现方法：

    + 右边 margin，需要清除最右边的栅格的右边 margin，且设置它为右浮动，避免浏览器 round 半px导致它掉下来。
    + 左右均分 margin，没什么难的，`calc((100% - 20px * 3) / 3)`
    + 右边 padding（不推荐）
    + 左右均分 padding，与第二种类似，但是不需要使用 `calc()` 计算，因为 padding 包含在 width 中。

    巧用 CSS 的计算方法，比如 `calc((100% - 20px * 2) / 3);` 得到除去两个20px宽度，平均分成3个栅格列的列宽。

5. 页面最下面可以写一行用来 debug 的栅格列
6. 创建布局变量，使用可读性强的 CSS class，借助 Sass 计算栅格列宽，比如 `percentage(2/12)`
7. 针对手机、平板、PC 设置断点，在每一个断点处，重新计算 CSS 栅格 class 的宽度
