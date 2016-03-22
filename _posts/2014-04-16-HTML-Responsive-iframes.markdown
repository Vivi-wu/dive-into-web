---
title:  "HTML Responsive, iframes"
category: HTML
---
## HTML Responsive Web Design

响应式web设计是说不论使用什么设备，你的web页面都应该看起来不错，而且好用。

响应式web设计是网页使用相同的URL和相同的代码，不论用户是通过台式机电脑、平板电脑或者手机来访问网——-只有显示的内容在调整或者根据屏幕尺寸"响应"变化。谷歌推荐使用RWD而不是其他设计模型。**相关文章**: [谷歌：打造面向跨屏时代用户的网站]({{ site.baseurl }}/google-multiscreen-consumer/)

**Tip**：可以使用 _float:left;_ 实现在浏览器窗口尺寸变小时，块级元素自动掉下来。此外，可以使用像 Bootstrap 这样的框架。

## HTML Iframes

iframe 是用来在一个网页视图中展示另一个网页。

<!--more-->

Syntax

    <iframe src="URL"></iframe>

_src_ 特性指定了要显示的网页地址。

使用 _width_ 和 _height_ 特性来设定大小。默认情况下以 pixels 为单位，也可以是百分数（像 “80%”）

    <iframe src="demo_iframe.htm" width="200" height="200"></iframe>

默认情况下 iframe 元素**有一个黑色的边框**，通过设定元素 CSS特性 _border:none;_ 来去除边框。当然，你也可以修改成你喜欢的边框样式。

### Use iframe as a Target for a link

链接 `<a>` 的 _target_ 特性值要等于 `<iframe>` 的 _name_ 特性值。这样点击链接，所指向的页面将在iframe中显示。

    <iframe src="demo_iframe.htm" name="iframe_a"></iframe>
    <p><a href="http://www.w3schools.com" target="iframe_a">W3Schools.com</a></p>
