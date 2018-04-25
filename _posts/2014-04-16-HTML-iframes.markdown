---
title:  "HTML iframes"
category: HTML
---
## HTML Iframes

iframe 是用来在一个网页视图中嵌入另一个网页。

Syntax：

    <iframe src="URL"></iframe>

_src_ 特性指定了要显示的网页地址。

<!--more-->

使用 _width_ 和 _height_ 特性来设定大小。默认情况下以 pixels 为单位，也可以是百分数（像 “80%”）

    <iframe src="demo_iframe.htm" width="200" height="200"></iframe>

默认情况下 iframe 元素**有一个黑色的边框**，通过设定元素 CSS特性 _border:none;_ ，或者在 iframe 元素上添加 `frameborder='0'` 来去除边框。当然，你也可以修改成你喜欢的边框样式。

### Use iframe as a Target for a link

链接 `<a>` 的 _target_ 特性值要等于 `<iframe>` 的 _name_ 特性值。这样点击链接，所指向的页面将在iframe中显示。

    <iframe src="demo_iframe.htm" name="iframe_a"></iframe>
    <p><a href="http://www.w3schools.com" target="iframe_a">W3Schools.com</a></p>

## 脚本

frame 元素包含在**伪数组类型**的 `window.frames` 变量中。

从 `HTMLIFrameElement` DOM 对象中，脚本可以通过 _contentWindow_ 属性读取嵌入的 HTML 页面的 window 对象。

_contentDocument_ 属性指向 iframe 中的 `document` 元素，等同于 `contentWindow.document`。

在 iframe 内部，脚本可以通过 `window.parent` 指向父窗口。

但是！！！

脚本读取 frame 内容受制于**同源策略**。如果 frame 加载的内容来自其他 domain，则（其他窗口对象中的）大部分属性无法访问。

该策略同样适用于 frame 内部脚本访问其父窗口。

Cross-domain communication can still be achieved using Window.postMessage()

### 被自动跳转

在网页里设置一个iframe，然后嵌入其他的网站（如1688的商品页面）。出现了莫名其妙的问题：当iframe中的网页加载完毕后，当前浏览器tab页会自动跳转/打开为这个页面。

原因是这个网页里可能写入了以下代码：

    if (top.location != self.location) {top.location=self.location;}

即自动判断当前的 location 是否为顶层的（即是否被嵌套到iframe里面了），如果是，则强制跳转。

解决办法：

    <iframe src="..." security="restricted" sandbox="">

即增加了两个属性，前者是IE的禁止js的功能，后者是HTML5的功能。
