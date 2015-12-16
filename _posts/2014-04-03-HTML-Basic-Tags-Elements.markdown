---
title:  "HTML Basic, Tags and Elements"
categories: HTML
---
## What is HTML?

HTML is a **markup** language for **describing** web documents. 它是一种用于描述网页文件的标记语言。

+ HTML stands for Hyper Text Markup Language, a markup language is a set of markup tags
+ Each HTML tag describes document content 每一个标签描述了HTML文件的内容
+ HTML documents contain HTML tags and plain text, are also called web pages. HTML文件也被称作网页，由标签和纯文本组成
+ The browser dose not display the HTML tags, but uses them to determine how to display the document. 浏览器不会显示展示标签，而是根据标签决定如何展示文档。
+ Only the <body> area is displayed by the browser (**<body>** describes the **visible page content**)
+ All HTML document must start with a type declaration: **<!DOCTYPE html>**

## HTML Tags

HTML tags are **keywords** (tag names) surrounded by angle brackets:

    <tagname>content</tagname>

+ They normally come **in pairs** 通常成对出现，the closing tag is considered optional. 虽然大部分浏览器可以正确显示 HTML without the End tag, 但是考虑到严格版本的XHTML，最好还是写上。
+ The first tag in a pair is the **start** (opening) tag , the second tag is the **end** (closing) tag
+ Some HTML elements do not have an end tag like **<br>** (which defines a line break 回车)
+ HTML tags are **not case sensitive** (大小写不敏感)

The World Wide Web Consortium (W3C) **recommends lowercase** in HTML 4, and demands lowercase tags in XHTML.
W3C建议在HTML4和XHTML中标签使用小写。因此，尽管 HTML5 标准没有要求标签小写，我们使用小写的标签。

## HTML Elements

Strictly speaking, an HTML **element** is everything between the start tag and the end tag, including the tags. HTML元素指的是在开标签和闭合标签之间所有的东西，包括这两个标签。

+ HTML elements can be nested (elements can contain elements 也就是说一个元素的内容可以是其他元素).
+ HTML elements with no content are called **empty elements**. 没有内容的元素被称为**空元素**
+ HTML5 dose not require empty elements to be closed，but if you want stricter validation, or you need to make your document readable by XML parsers, you should close all HTML elements. 尽管 HTML5 没有要求空元素要闭合，为了让你的文档对于XML解析器是可读的，记得闭合所有HTML元素。

Tip: In XHTML, all elements must be closed. Adding a slash inside the start tag, like <br />, is the proper way of closing empty elements in XHTML (and XML).

<!--more-->
文件后缀

HTML files should have a .html extension (not .htm).
