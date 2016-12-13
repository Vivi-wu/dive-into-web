---
title:  "HTML Quotation, Citation, Comments"
category: HTML
---
## HTML Quotation and Citation Elements

+ `<q>` defines an inline (short) quotation 该元素定义行内级的短的引用, browser usually insert quotation marks around the `<q>` element. 通常自动加引号把该元素包围起来 
+ `<blockquote>` defines a quoted section, browser usually indent `<blockquote>` elements, 浏览器通常给该元素加缩进
+ `<abbr>` defines an abbreviation 缩写 or an acronym. 可用 title 属性显示完整拼写, 告诉浏览器、翻译系统和搜索引擎有用的信息
+ `<address>` defines contact information (author/owner) of a document or an article, 通常斜体显示, 大多数浏览器会在该元素前后加 line break
+ `<cite>` defines the title of a work 作品名 (e.g. a book, a song, a movie, a TV show, a painting, a sculpture, etc.) 通常斜体显示
+ `<bdo>` defines bi-directional override 用来重新定义当前文字从左到右（或从右到左）输出方向

<!--more-->

## HTML Comments

HTML中插入注释用 `<!-- I am a comment -->`, it will not displayed by the browser. 在debug阶段，可以把相关HTML元素放在开闭箭头之间。

### Conditional comments

Conditional comments enable you to add a browser specific code that executes only if the browser is IE but is treated as a comment by other browsers. 条件注释使得元素中的代码只在IE浏览器下运行显示

syntax：

    <!--[if IE 8]>This is IE 5<br><![endif]-->

### HTML `<dfn>`

该元素的使用方法有三种情况：

1.如果有 _title_ 属性，则它的title定义这个条款

    <p>The <dfn title="World Health Organization">WHO</dfn> was founded in 1948.</p>

2.如果该元素包含一个定义了 _title_ 的 `<abbr>` 元素，则 `<abbr>` 的 _title_ 定义这个条款

    <p>The <dfn><abbr title="World Health Organization">WHO</abbr></dfn> was founded in 1948.</p>  

3.该元素的内容是条款，而它的父元素则包含该条款的定义。

    <p>The <dfn>WHO</dfn> World Health Organization was founded in 1948.</p>

#### `<noscript>` tag

The `<noscript>` tag is used to provide an alternate content for users that have disabled scripts in their browser or have a browser that doesn't support client-side scripting. 该标签旨在当用户浏览器禁止scripts或者浏览器不支持客户端脚本运行时，提供并显示可替换的内容。

The `<noscript>` element can contain all the elements that you can find inside the `<body>` element of a normal HTML page. 该元素可以包含所有那些适用于正常HTML页面`<body>`元素中的元素。

只有在客户端不支持或者禁用了JS的情况下，才会显示该标签里的内容。
