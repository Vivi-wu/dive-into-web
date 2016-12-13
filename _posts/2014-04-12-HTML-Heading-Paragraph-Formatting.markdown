---
title:  "HTML Heading, Paragraph, Text Formatting"
category: HTML
---
## Headings

Headings are defined with the `<h1>` (the most important heading) to `<h6>` (the least important) heading tags.

**Note**：不要使用heading来实现文本字体的**加粗**或<span style="font-size:large;">加大</span>效果。

因为<span class="t-blue">搜索引擎使用 heading 来索引网页的结构和内容</span>。

<!--more-->

## Horizontal Rules

`<hr>` 元素在网页中创建水平横线，可用于分隔内容。

## Paragraphs

HTML使用 `<p>` 元素来定义段落。

### HTML Display

在 HTML 代码中写额外的空格或者是换行都不能改变文档的输出结果。

浏览器会删除多余的空格和分段，<span class="t-blue">不论你在同一个元素里代码写了多少个空格（或新段落），都将被记为一个空格</span>。

### Line Break

需要在同一个 `<p>` 里换行可以使用标签 `<br>` 元素。

### HTML `<pre>` Element

该元素定义了 pre-formatted text, 使用该元素来保留其中 text node 里的空格和分段格式。

## Text Formatting

HTML也定义了一些特别的元素，用来给文本赋予特殊的**meaning**。

### <b>Bold</b> and <strong>Strong</strong>

The `<b>` element defines bold text, `<strong>` element with added semantic "strong" importance.

### <i>Italic</i> and <em>Emphasized</em>

The `<i>` element defines italic text, `<em>` element defines emphasized text with added semantic importance.

Often `<strong>` renders as `<b>`, and `<em>` renders as `<i>`. However, there is a difference in the meaning of these tags. 
前两者表示希望指定的文本被用户理解为是重要的，而不仅仅是粗/斜体字，尽管目前浏览器让这些元素以粗体或斜体字显示。

If a browser one day wants to make a text highlighted with the strong feature, it might be cursive 草书体 for example and not bold!

### HTML Text Formatting Tags

+ `<b>` bold text 粗体字
+ `<i>` can be used to indicate a technical term 技术词汇, a phrase from another language 其他语言的短语, a thought 一个想法, or a ship name 或者是一个名字, etc.
+ `<strong>` important text
+ `<em>` emphasized text 强调文本
+ `<small>` <small>smaller</small> text
+ `<mark>` new in H5 <mark>marked/highlighted</mark> text, 高亮或标注文本，IE8及之前不支持
+ `<del>` defines <del>deleted</del> (removed) text, 效果同给文本加删除线
+ `<ins>` defines <ins>inserted</ins> (added)text, 效果同给文本加下划线
+ `<sub>` appears half a character <sub>below</sub> the baseline 低于基准线半个字符高度，用于化学式
+ `<sup>` superscripted text 高于基准线半个字符, 用于脚注：WWW<sup>[1]</sup>
