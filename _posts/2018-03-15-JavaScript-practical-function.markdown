---
title:  "前端小功能实现"
category: JavaScript
---

## 下载后台返回文件

用 blob 形式读取响应数据，然后转译成 url 形式并赋值给 a 标签的 _href_ 属性，模拟点击动作，触发浏览器下载。

```js
axios({
  method: 'get',
  url: url,
  params: data,
  responseType: 'blob'
})
  .then(response => {
    if (response.status === 200) {
      let blob = new Blob([response.data]);
      let filename = response.headers['content-disposition']

      // 转译以URL形式编码的文件名
      filename = decodeURI(filename.split('"')[1])

      let a = document.createElement("A")
      a.href = window.URL.createObjectURL(blob)
      a.download = filename
      a.click()
    }
  })
  .catch(error => {
    // error handler
  })
```
