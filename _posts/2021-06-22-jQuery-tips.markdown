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