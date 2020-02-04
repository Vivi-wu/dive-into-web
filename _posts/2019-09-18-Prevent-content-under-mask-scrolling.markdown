---
title:  "阻止蒙版浮层底部内容随页面滚动"
category: JavaScript
---
`Element.scrollTop` 属性可以**获取**或**设置**一个元素的内容垂直滚动的像素数。

https://segmentfault.com/a/1190000012313337
pc端通常用方案一。
在body元素上toggle _overflow:hidden_ 即可。

手机端在iPhone Safari上无效。

亲测方法三有效。

```js
let bodyEl = document.body
let top = 0 // 记录蒙版出现时页面scroll的y值

function stopBodyScroll (isFixed) {
  if (isFixed) {
    top = window.scrollY

    bodyEl.style.position = 'fixed'
    bodyEl.style.top = -top + 'px'
  } else {
    bodyEl.style.position = ''
    bodyEl.style.top = ''

    window.scrollTo(0, top)
    // 滚动回到蒙版出现时页面的位置
    // 否则，当蒙版消失，body的position改变，页面回到top为0的位置
  }
}
```

浏览器兼容性：
safari滚动数字动效不生效：
```js
scrollTop = Math.max(document.body.scrollTop, document.documentElement.scrollTop)
```

### 页面元素平滑滚动

通过 css 属性 `scroll-behavior: smooth;`，默认值是 auto，即立即滚动到指定位置。

window.getComputedStyle(document.body).scrollBehavior)，mac Chrome 得到值为 auto，Safari 则为 undefined