---
title:  "What's new in HTML5?"
category: HTML
---
HTML5 is the latest standard for HTML. It was specially designed to deliver rich content without the need for additional plugins. HTML5 is also cross-platform. It is designed to work whether you are using a PC, or a Tablet, a Smartphone, or a Smart TV. HTML5 是 HTML 的最新标准，特别地，HTML5被设计用于传达丰富的多媒体内容而无需额外的插件。它同时也是跨平台的。

W3C will develop a definitive HTML5 and XHTML5 standard, as a "snapshot" of <dfn><abbr title="Web Hypertext Application Technology Working Group">WHATWG</abbr></dfn>.

The [W3C HTML5 recommendation](http://www.w3.org/TR/html/) was released 28. October 2014.

<!--more-->

## What's new?

1.HTML5 DOCTYPE declaration 文档类型声明，如下：

    <!DOCTYPE html>

There are many different documents on the web, and a browser can only display an HTML page 100% correctly if it knows the HTML type and version used.

两个作用：
1. 验证器根据此来判断应采用何种验证规则去验证代码。
2. 能强制 IE6,7,8 以标准模式 standards mode 渲染页面。

2.new **semantic**/structural elements

A semantic element clearly describes its meaning to both the browser and the developer. 语义化的元素清楚地描述了它对于浏览器和开发者的含义。

+ `<header>` 定义文档或者一个区域的头部，用于存放介绍性的内容
+ `<footer>` 定义文档或者一块区域的脚部，页面footer通常包含 author of the document, copyright information, links to terms of use, contact information, etc.
+ `<nav>` 定义一组导航链接，但不是文档中所有的链接都要放到这个元素里
+ `<section>` 定义了一组有主题的内容，通常含有一个标题
+ `<main>` 定义文档的主要内容区域
+ `<article>` 定义独立完整的内容，与网站中其他内容分离出来也可以被阅读：Forum post、Blog post、Newspaper article
+ `<aside>` 定义与它所处位置的内容以外的一些内容（有点像花絮、补白之类的），要与周围的内容相关
+ `<figure>` 定义含有标题的图片内容，可以是 illustrations 插图实例， diagrams, photos, code listings, etc,
+ `<figcaption>` 定义 `<figure>` 元素的标题，可以作为 `<figure>` 元素的第一个或最后一个子元素
+ `<details>` 定义用户可以看到或隐藏的额外细节，块级元素，默认内容是不可见的（close），通过设定它的 _open_ 特性，重写默认状态 be visible to user (open)
+ `<summary>` 定义 `<details>` 元素的 visible heading，点击可以显示`<details>` 元素的完整内容，注意：IE和FF不支持这两个元素
+ `<time>` 定义一个人类可读的日期/时间，该元素在主流浏览器中并没有特别的显示样式
+ `<mark>` 定义被标记或高亮显示的文字

**语义化 HTML 的意义**：
<details>语义化的(X)HTML文档有助于提升你的网站对访客的易用性，比如使用 PDA、文字浏览器以及残障人士将从中受益。对于搜索引擎或者爬虫软件来说，则有助于它们建立索引，并可能给予一个较高的权值。</details>

+ 和搜索引擎建立良好沟通，有助于爬虫抓取更多的有效信息，比如 `<h1>`~`<h6>`、`<strong>` 用于不同权重的标题
+ 提升用户体验，例如 _title_ 用于解释名词，_alt_ 作为图片替代文字信息，`<label>` 标签包裹 `<input>` 元素扩大可点击区域
+ 使页面结构清晰、代码可读、便于维护、易于扩展
+ 对辅助设备(如 screen reader 屏幕阅读器)友好，如 _role_ 提供机器可读取的语义信息解释一个元素的用途

3.图形元素

+ `<canvas>` 定义用JavaScript绘制的图像
+ `<svg>` 定义使用 Scalable Vector Graphics 绘制的图形

4.多媒体元素

+ `<audio>` 定义声音或音乐内容
+ `<video>` 定义视频或电影内容
+ `<source>` 定义 audio、video 两个元素的媒体资源
+ `<track>` 定义 audio、video 的轨迹
+ `<embed>` 定义用于外部应用（如：插件）的容器

5.新增的Web应用元素

+ `<ruby>` 定义ruby注释
+ `<rt>` 定义字符的解释/读法（针对东亚的字体）
+ `<rp>` 定义那些不支持ruby注解的浏览器要显示的内容
+ `<dialog>` 定义对话框或弹窗
+ `<bdi>` 定义一块文字可能与其他文字以不同的方向显示
+ `<wbr>` 定义可能的line-break
+ `<meter>` 定义一个含已知范围的标量测量仪器
+ `<progress>` 定义任务进度状态

6.表格元素

+ `<datalist>` 为input提供预定义的选项，用于输入控制
+ `<keygen>` 定义了表格里的一个 key-pair 生成器区域
+ `<output>` 进行计算并显示结果

7.New Input Types

为表单提供更好的输入控制和确认: color，date，datetime-local，email，month，number，range，search，tel，time，url，week

8.New API

Geolocation，Drag and Drop，Local Storage，Web Workers，SSE

## HTML5 Browser Support

所有浏览器，不论新版还是旧版，<span class="t-blue">对于识别不了的 HTML 元素自动按 _inline_ 行内级元素处理</span>。因此，我们可以教旧浏览器正确处理“未知的” HTML 元素。

为了在旧浏览器中安全地正确地显示 `<header>` `<section>` `<footer>` `<aside>` `<nav>` `<main>` `<article>` `<figure>` 这些 block-level 块级元素，通过CSS _display_ 属性设定为 block 来实现

    header, section, footer, aside, nav, main, article, figure {
      display: block;
    }

对于IE8及之前版本的IE浏览器，不允许对未知元素设定样式。因此上述办法不起作用。解决办法：

    <!--[if lt IE 9]>
      <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

**注意**：因为IE需要在读取之前知道所有的新元素，所有上述脚本**必须**放在 `<head>` 元素里。

### Add new HTML element

你可以自己创建新的的HTML元素，然后用CSS设定它的样式。除IE外可以直接使用这个新元素。

对于IE浏览器，需要在头部添加以下JS代码：

    <script>document.createElement("myHero")</script>
