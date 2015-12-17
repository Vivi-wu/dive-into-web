---
title:  "HTML Heading & Paragraph & Text Formatting"
categories: HTML
---
## Headings

Headings are defined with the `<h1>` (the most important heading) to `<h6>` (the least important) heading tags.

注意：Use HTML headingsfor headings only. Don't use headings to make text **BIG** or **bold**. 不要使用heading来实现文本字体的加粗或加大效果。

Search engines use your headings to index the structure and content of your web pages. 搜索引擎使用heading来索引网页的结构和内容。

## Horizontal Rules

The **`<hr>`** tag creates a horizontal line in an HTML page. 在网页中创建水平横线，可用于分隔内容。

## Paragraphs

HTML使用 `<p>` 元素来定义段落。

### HTML Display

You cannot change the output by adding extra spaces or extra lines in your HTML code. 在HTML代码中写额外的空格或者是换行都不能改变文档的输出结果。

The browser will remove extra spaces and extra lines when the page is displayed. Any number of new lines, and any number of spaces **count as one space**. 浏览器会删除多余的空格和分段，不论你在同一个元素里代码写了多少个空格（或新段落），都将被记为一个空格。

### Line Break

Use `<br>` if you want a line break without starting a new paragraph. 需要在同一个 `<p>` 里换行可以使用标签 `<br>`

### HTML `<pre>` Element

该元素定义了 pre-formatted text, use it if you want to preserve spaces and lines. 写在这个元素中的文本可以保留代码里的空格和分段格式。

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
+ `<small>` smaller text
+ `<mark>` new in H5 marked/highlighted text, 高亮或标注文本，IE8及之前不支持
+ `<del>` defines **deleted** (removed) text, 效果同给文本加删除线
+ `<ins>` defines **inserted** (added)text, 效果同给文本加下划线
+ `<sub>` appears half a character below the baseline 低于基准线半个字符高度，用于化学式
+ `<sup>` superscripted text 高于基准线半个字符, 用于脚注：WWW[1]
