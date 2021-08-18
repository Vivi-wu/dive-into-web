---
title:  "jQuery 实战"
category: JavaScript
---
设置 ajax POST request 参数为 JSON 格式。一个是设置请求头的 content-type，一个是 data 的值转为 JSON 的字符串。

```js
$.ajax({
  contentType: "application/json; charset=UTF-8",
  dataType: "json",
  type: "POST",
  data: JSON.stringify({pageNo: 1, pageSize: 100})
})
```

取出与 jQuery 对象匹配的 DOM 元素

```js
$("li").get(0);
$("li")[0]; // also
```
