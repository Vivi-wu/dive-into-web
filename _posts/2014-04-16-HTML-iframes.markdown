---
title:  "HTML iframes"
category: HTML
---
## HTML Iframes

iframe 是用来在一个网页视图中展示另一个网页。

Syntax：

    <iframe src="URL"></iframe>

_src_ 特性指定了要显示的网页地址。

<!--more-->

使用 _width_ 和 _height_ 特性来设定大小。默认情况下以 pixels 为单位，也可以是百分数（像 “80%”）

    <iframe src="demo_iframe.htm" width="200" height="200"></iframe>

默认情况下 iframe 元素**有一个黑色的边框**，通过设定元素 CSS特性 _border:none;_ 来去除边框。当然，你也可以修改成你喜欢的边框样式。

### Use iframe as a Target for a link

链接 `<a>` 的 _target_ 特性值要等于 `<iframe>` 的 _name_ 特性值。这样点击链接，所指向的页面将在iframe中显示。

    <iframe src="demo_iframe.htm" name="iframe_a"></iframe>
    <p><a href="http://www.w3schools.com" target="iframe_a">W3Schools.com</a></p>
