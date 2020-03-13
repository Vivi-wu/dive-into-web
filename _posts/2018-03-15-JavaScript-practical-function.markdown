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

### Blob实现大文件切片上传

在JavaScript中，文件FIle对象是Blob对象的子类，Blob对象包含一个重要的方法slice，通过这个方法，我们就可以对二进制文件进行拆分。

将文件拆分成piece大小的分块，然后每次请求只需要上传这一个部分的分块即可。

```js
function slice(file, piece = 1024 * 1024 * 5) {
  let totalSize = file.size; // 文件总大小
  let start = 0; // 每次上传的开始字节
  let end = start + piece; // 每次上传的结尾字节
  let chunks = []
  while (start < totalSize) {
    // 根据长度截取每次需要上传的数据
    // File对象继承自Blob对象，因此包含slice方法
    let blob = file.slice(start, end); 
    chunks.push(blob)

    start = end;
    end = start + piece;
  }
  return chunks
}

let file =  document.querySelector("[name=file]").files[0];

const LENGTH = 1024 * 1024 * 0.1;
let chunks = slice(file, LENGTH); // 首先拆分切片

chunks.forEach(chunk=>{
  let fd = new FormData();
  fd.append("file", chunk);
  post('/mkblk.php', fd)
})

```