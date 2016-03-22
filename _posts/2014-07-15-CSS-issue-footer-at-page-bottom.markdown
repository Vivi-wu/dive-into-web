---
title:  "Keep your footer at the bottom of the page"
category: Style
---
项目里遇到的问题，让 footer 显示在**页面**最下方。注意，这里讨论的不是让 footer 固定在 viewport（或浏览器窗口）的底部。具体来说分两种情况。

假设你还没有对 `<html>`，`<body>`，`<footer>` 这些元素的 _position_ 或是 _height_ 属性做任何改动。

## 问题描述

1. **long page**

    When a page contains a large amount of content, the footer is pushed down off the viewport, and if you scroll down, the page ‘ends’ at the footer. 简单来说，当页面包含大量内容，并且 footer 被自然地推到超出 viewport ，此时，你滚动页面到下方，自然地，会看到页面结束在 footer。所以你不会注意到 footer 有什么不妥的地方。

2. **short page**

    However, if the page has small amount of content, the footer can sometimes ‘cling’ to the bottom of the content, floating halfway down the page, and leaving a blank space underneath. 然而当页面只有少量内容的时候（实际内容不足以占满整个窗口高度），footer 有时会紧跟着页面实际内容的底部，你会看到 footer 出现在半路，距离 viewport 底部有一大片空白。发现问题！

<!--more-->

## 尝试解决

本以为简单地设置 footer 的位置就ok的，如下：

    footer {  
      position: absolute;  
      bottom: 0;  
      width: 100%;  
    }

This usually ends up in it either overlapping (hiding) the bottom of the page content, or staying in the same position when the viewport is scrolled.
然而理想和现实是有差距滴。这样写，可以解决 short page 页脚的问题。

而对于 long page 乍一看 footer 放置在了浏览器的底部，**遮住了页面靠近浏览器底部的内容**（如果你还没有给 body 内容区域设置 _padding-bottom_）。此时当你向下滚动页面时，会看到 footer 一直被定在那个“初始”位置。

本来没问题的 long page 现在出现问题了😔

### `<html>` vs. `<body>`

参考此[文章](http://phrogz.net/css/htmlvsbody.html)中的观点，盗个图。

<img src="{{ "/assets/images/html_body.png" | prepend: site.baseurl }}" alt="html vs. body in browser">

中文翻译重点：

+ `<html>` 和 `<body>` 元素是不同的块级元素，是父/子元素的关系
+ <span class="blue-text">html 元素的宽和高由浏览器窗口决定</span>
+ html 元素 默认 _overflow_ 属性值为 _auto_，当需要时自动出现 scrollbar
+ 大部分浏览器内置的页面边距应用在 body 的 _margin_ 上，而**不是** html 的 _padding_
+ 块级元素如果不指定高度，会根据包裹其中的内容自动增长高度，如果为其指定高度，接下来发生的事就要取决于 overflow 这个属性的值了。

## 解决问题

现在再来分析下之前页面出现问题的原因。此时 footer 的位置是相对于 html 而言（因为它的最近的父元素 body 此时 position 还是 _static_ 的，所以它的相对位置是针对 html 元素而言）。我认为就是相对于浏览器窗口底部放置，当你不向下滚动页面，只改变窗口高度。效果同 `position: fixed; bottom: 0;` 看到 footer 随着窗口底部移动。

区别是：当你向下滚动时，设为 _fixed_ 的页脚始终可见，而如上设置 _absolute_ 的页脚，滚着滚着就滚上去看不见了。

添加以下代码：

    body {
      position: relative;  
    }

这样 footer 的相对放置位置为 body 元素的底部，在 long page 页脚就自然而然放置在页面结尾处，long page 问题解决。
但已经改好的 short page 又有问题了。

### 页面高度问题

Many people assume that the `<html>` and `<body>` elements are always at least the height of the browser (min-height:100%). This is not the case: these elements, just like any other, will shrink to fit the least possible height, meaning that on pages with very little content. 

许多人认为 html、body 这些元素总是有至少和浏览器窗口一样的高度，<span class="blue-text">事实上，html、body 元素会收缩以符合尽可能小的高度</span>。里面的实际内容撑起高度。

What this means is that your footer can never be at the bottom of the browser window unless the `<html>` and `<body>` elements are at least 100% in height.

因此，对于 short page 只有 html、body 元素高度至少为 100% 时，footer 才可能被放在底部。

添加以下代码

    html {
      height: 100%;
    }
    body {
      min-height: 100%;  
    }

使文件可视化区域高度（body）至少达到浏览器窗口的高度，这个添加改动对于 long page 是没有明显影响的。

### Bonus

The space below is an empty void – nothing can be styled there or take up space there (apart from the background style of the `<html>` element, which most browsers recognise as needing to fill the screen.) 在短页面的实际内容之下的**空区域**，只能设置 body 元素的 _background_ 属性，任何其他元素都不能占据这块空间或被 styled.
