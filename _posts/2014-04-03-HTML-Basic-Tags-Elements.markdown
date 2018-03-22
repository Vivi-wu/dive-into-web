---
title:  "HTML Basic, Tags and Elements"
category: HTML
---
## What is HTML?

HTML is a **markup** language for **describing** web documents. 它是一种用于描述网页文件的标记语言。

+ HTML stands for **H**yper **T**ext **M**arkup **L**anguage, a markup language is a set of markup tags
+ 每一个标签描述了 HTML 文件的内容
+ HTML文件也被称作网页，由标签和纯文本组成
+ 浏览器不会展示标签，而是根据标签决定如何展示文档。
+ Only the `<body>` area is displayed by the browser (`<body>` describes the **visible page content**)
+ All HTML document **must start with** a type declaration: `<!DOCTYPE html>`

<!--more-->

## HTML Tags

HTML tags are **keywords** (tag names) surrounded by angle brackets:

    <tagname>content</tagname>

+ They normally **come in pairs** 通常成对出现，the closing tag is considered optional. 虽然大部分浏览器可以正确显示 HTML without the End tag, 但是考虑到严格版本的XHTML，最好还是写上。
+ The first tag in a pair is the **start** (opening) tag , the second tag is the **end** (closing) tag
+ Some HTML elements do not have an end tag like `<br>` (which defines a line break 回车)
+ HTML tags are **case insensitive** (大小写不敏感)

W3C建议在HTML4和XHTML中标签使用小写。因此，尽管 HTML5 标准没有要求标签小写，我们**使用小写的标签**。

## HTML Elements

Strictly speaking, an HTML **element** is everything between the start tag and the end tag, including the tags. HTML元素指的是在开标签和闭合标签之间所有的东西，包括这两个标签。

+ HTML elements can be nested (也就是说一个元素的内容可以是其他元素)
+ 没有内容的元素被称为 empty elements **空元素**
+ HTML5 没有要求空元素要闭合，为了让你的文档对于XML解析器是可读的，记得闭合所有HTML元素
+ 设置了 _id_ 属性的 HTML 元素，可以通过 id 值直接进行dom操作

**Tip**: In XHTML, all elements must be closed. **Adding a slash inside the start tag**, like `<br />`, is the proper way of closing empty elements in XHTML (and XML).

### Element.classList

该属性是**只读**的，返回 DOMTokenList（以空格分隔的 token）类型的元素的 class 属性名称。

常用的方法：

+ add()，添加一个或多个css类名。添加已存在的类名直接忽略。
+ remove()，移除一个或多个css类名。删除不存在的类名不会报错。
+ contains()，检查一个类目是否已存在。
+ replace(old, new)，替换已存在的类名。
+ toggle(),

文件后缀

HTML files should have a .html extension (not .htm).

.htm "smells" of early DOS systems where the system limited the extensions to 3 characters.

.html "smells" of Unix operating systems that did not have this limitation.
