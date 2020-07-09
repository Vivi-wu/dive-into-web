---
title:  "JavaScript Basic"
category: JavaScript
---
JavaScript旨在作为脚本语言运行在主机环境（除了广为人知的浏览器，JavaScript interpreters 解释器还存在于 Adobe Photoshop、SVG image、服务端环境Node.js、NoSQL数据库、GNOME等）。

JavaScript 是web开发人员必学的三大基本语言之一。It makes HTML pages more dynamic and interactive.

## Where To

JavaScript 代码可以放在 HTML 页面的 `<head>` 和/或 `<body>` 部分。

+ HTML 页面里的 JS 代码必须写在 `<script>` 和 `</script>` 标签之间
+ 在 HTML 文档里可以放置任意数量的 scripts
+ keep all codes in one place is always a good practice
+ 把脚本放在 `<body>` 元素的底部可以提高页面加载速度，因为脚本编译会减缓页面显示
+ 如果有无法加载的JS文件，浏览器会在N秒后才放弃，如果文件是在内容中间，这个会让流畅加载的页面突然中断N秒

**注意**：在老的JS代码里会看到，`<script type="text/javascript">`，现在该标签的 _type_ 特性不是必须的，**JavaScript 是 HTML 的默认脚本语言**。

<!--more-->

### External JavaScripts

脚本代码可以放在外部JS文件里，引用方式：

    <script src="myScript.js"></script>

The script will behave as if it was located exactly where the `<script>` tag is located.

使用外部js的好处：

+ 将 HTML 和 JS 代码分离开来
+ 使得 HTML 和 JS 更容易阅读和维护
+ Cached JavaScript files can speed up page loads

## Output

JavaScript 没有内置的打印或显示函数，有以下几种方法查看输出：

+ **window.alert()**，弹出窗口显示
+ **document.wirte()**，只用来测试，且不要在页面完全加载后使用，将 **delete all existing HTML**
+ **innerHTML**，在 HTML 中显示数据，多数情况下通过设置该元素的 innerHTML 特性实现
+ **console.log()**，在支持调试工具的浏览器里，可以在 Console 中查看

## Comments

JS注释可以用来解释代码，也可以用来阻止代码执行，用于测试。

### 单行注释

以 double slashs `//` 开始，任何在**双斜线**和**行尾之间**的内容都将被JS忽略（不被执行）.

单行注释可以写在每一行代码前（上一行），也可以写在每行代码分号后面。

### 多行注释

以 `/*` 开始，以 `*/` 结束。任何写在这之间的内容都将被JS忽略。通常多行注释用于 formal documentation。
