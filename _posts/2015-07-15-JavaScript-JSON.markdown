---
title:  "JavaScript JSON"
category: JavaScript
---
JSON 是指 **J**ava**S**cript **O**bject **N**otation, 是一种轻量级的数据存储和传输格式，独立于语言（text only，可用任何编程语言来读取和生产 JSON 数据）。

JSON 可以“自描述”（human readable），容易理解。

JSON 文件的后缀名为 _.json_

## Syntax

数据以 name/value 成对出现，由**逗号**分隔，**大括号**里放对象，对象可以包含多个 name/value 对；**方括号**里放数组，数组可以包含多个对象。

注意：<span class="blue-text">JSON 的 name 需要以**双引号**括起来，这一点区别于 JavaScript name</span>。

### JSON Value

可以是 number（整数或浮点型的）、string（**双引号**括起来）、Boolean（true 或 false）、array、object、`null`

### Convert JSON text to JS Object

JS 程序可以容易将 JSON 数据转为原生的 JS 对象。

假设得到一个包含 JSON 语法的 JS 字符串，使用 JS 内置的 `JSON.parse()` 函数将这个字符串转为 JS 对象。

    var obj = JSON.parse(text);

### JSON vs. XML

不了解的人会经常比较这两者，我比较赞同的一个观点是，JSON 只是一种**数据格式**，而 XML 是一种**语言**，比前者拥有更广泛的用途和强大的功能。

当然，对于 AJAX 应用来说，JSON 比 XML 更快更容易。

使用 XML，需要 fetch XML 文件，使用 XML DOM 循环遍历文件（使用 document.getElemenById 或者 document.getElemenByTagName 方法来 extract data），然后提取 values 并将它们存储在变量中。

而使用 JSON 只需要 fetch JSON string，然后使用 `JSON.parse` 解析这个 JSON 字符串。
