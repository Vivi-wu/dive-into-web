---
title:  "JavaScript JSON, JSONP"
category: JavaScript
---
JSON 是指 **J**ava**S**cript **O**bject **N**otation, 是一种轻量级的数据存储和传输格式，独立于语言（text only，可用任何编程语言来读取和生产 JSON 数据）。

JSON 可以“自描述”（human readable），容易理解。

JSON 文件的后缀名为 _.json_

## Syntax

数据以 name/value 成对出现，由**逗号**分隔，**大括号**里放对象，对象可以包含多个 name/value 对；**方括号**里放数组，数组可以包含多个对象。

<!--more-->

注意：<span class="t-blue">JSON 的 name 需要以**双引号**括起来，这一点区别于 JavaScript Object name</span>。

### JSON Value

可以是 number（整数或浮点型的）、string（**双引号**括起来）、Boolean（true 或 false）、Array、Object、`null`。

JSONNumber 是十进制数字，含两位小数，可以为正或负值。默认去掉末尾的0

    5.00 -> 5
    5.30 -> 5.3

### Convert JSON string to JS Object

JS 程序可以容易将 JSON 数据转为原生的 JS 对象。

假设得到一个包含 JSON 语法的 JS 字符串，使用 JS 内置的 `JSON.parse()` 函数将这个<span class="t-blue">字符串转为 JS 对象</span>。

    var obj = JSON.parse(text);

### Convert JS value to JSON string

使用 JS 内置的 `JSON.stringify(`value[, replacer[, space]]`)` 函数将 <span class="t-blue">JS 值转换成 JSON string</span>。

replacer 可以是过滤 function 或 array（指定输出的属性名组成的数组）

space 取值为 string（分隔符）或 number（指定输出时几个 space characters 作为一个空白符，超出10则取10，小于1则认为没有空格）

```js
JSON.stringify([1, 'false', false]); // '[1,"false",false]'
JSON.stringify({ x: 5 });            // '{"x":5}'
```

+ non-array 无序性， stringified 对象不能保证遵循任何指定的顺序。
+ Boolean, Number, 和 String 对象被转为对应的 primitive 值。

其他注意事项参考[这里 ](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify)

用 ajax 传数据时，前端可以将数据转为 JSON string 格式发给后端，并指定 request header，这样后端（目前服务器端都支持）可将接收到的数据自动解析为 JSON 数据来用。

Note: JSON text SHALL be encoded in Unicode. The default encoding is UTF-8.

     XHR.setRequestHeader('Content-Type', 'application/json;charset=utf-8');

```js
var a = { test: '' }
var val = JSON.stringify(a.test)

// 判断对象某属性的值是否为：空字符串、空对象、空数组、null 或 undefined
if (a.test === "" || val === '{}' || val === '[]' ||  val === 'null' || !val) {}
```
### JSON vs. XML

不了解的人会经常比较这两者，我比较赞同的一个观点是，JSON 只是一种**数据格式**，而 XML 是一种**语言**，比前者拥有更广泛的用途和强大的功能。

当然，对于 AJAX 应用来说，JSON 比 XML 更快更容易。

使用 XML，需要 fetch XML 文件，使用 XML DOM 循环遍历文件（使用 document.getElemenById 或者 document.getElemenByTagName 方法来 extract data），然后提取 values 并将它们存储在变量中。

而使用 JSON 只需要 fetch JSON string，然后使用 `JSON.parse` 解析这个 JSON 字符串。

## JSONP

目前并没有遇到需要使用 JSONP 的场景，但是有至少两次面试都被问到这个问题😓

常见的答案是：用来解决纯前端 Ajax 不能跨域请求资源文件的问题。

一句话说明：引用一段脚本，执行页面里定义的方法。

详细地说：页面动态添加 `<script>` 标签，标签的 _src_ 属性值 url 后添加 `?callback=myFunction` 参数。以该链接向服务器端发起请求，服务器检测到 callback 参数（myFunction），把要发给客户端的数据包裹在函数名里，如：`myFunction("foobar");` 以 js 文件形式返回。客户端接到请求结果，调用页面里自定义的函数 myFunction 处理数据。

前提是**后台服务支持 jsonp 协议**，对 json 数据进行了函数包装。

补充：

1. jQuery 把 jsonp 作为 ajax 的一种形式进行了封装，但 ajax 和 jsonp 本质上是不同的东西。ajax 的核心是通过 XMLHttpRequest 获取非本页内容，而 jsonp 的核心则是在需要的时候，通过动态添加 `<script>` 标签请求数据执行定义在页面里的方法。
2. Ajax 通过服务端代理一样可以实现跨域，jsonp 本身也不排斥同域的数据的获取。
3. jsonp 是一种方式或者说非强制性协议，如同 ajax 一样，它也不一定非要用 json 格式来传递数据，只不过提供公共通用服务还是选择支持广泛的数据格式，以便不同端处理数据。
4. jsonp 的 Content-Type 是 `text/javascript`。
5. jsonp 只支持 get 请求。

对于拥有 _src_ 属性的标签都拥有跨域的能力，比如 `<script>`、`<img>`、`<iframe>`。
