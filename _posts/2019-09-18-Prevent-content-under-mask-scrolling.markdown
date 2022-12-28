---
title:  "阻止蒙版浮层底部内容随页面滚动"
category: JavaScript
---

Safari fixed定位的滚动穿透问题：

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

<!--more-->

浏览器兼容性：
Safari 滚动数字动效不生效：
```js
scrollTop = Math.max(document.body.scrollTop, document.documentElement.scrollTop)
```

### 第三方库解决

上面方法简单粗暴。问题：打开弹层未关闭，通过路由跳转至其他页面（针对SPA），页面内容无法滚动。

解决：引入 "body-scroll-lock"。针对 React 组件用法如下：

scrollTargetEle 表示在锁定 body 滚动时，希望保持 scroll 功能的 DOM 元素。

```js
const [scrollTargetEle, setScrollTargetEle] = useState(null)
const eleRef = useCallback(node => {
  if (node !== null) {
    setScrollTargetEle(node)
  }
}, [])
useEffect(() => {
  if (visible) {
    scrollTargetEle && disableBodyScroll((scrollTargetEle as unknown) as Element)
  } else {
    scrollTargetEle && enableBodyScroll((scrollTargetEle as unknown) as Element)
  }
  return () => {
    clearAllBodyScrollLocks()
  }
}, [visible])
```

### 页面元素平滑滚动

通过 css 属性 `scroll-behavior: smooth;`，默认值是 auto，即立即滚动到指定位置。

window.getComputedStyle(document.body).scrollBehavior，mac Chrome 得到值为 auto，Safari 则为 undefined

### iOS 15 fixed定位的元素被浏览器地址栏遮挡

在手机端以侧边推出的形式打开隐藏内容。通常会设置这个元素为 fixed 定位，并置于顶层。

```css
.mobile-facets {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 999 !important;
}
```

当滚动页面在address bar消失后打开侧边栏，虽然设置侧边栏占满屏幕，但其底部被一块空白区域遮挡。空白高度恰好是地址栏高度。解决：

```js
if (navigator.platform === 'iPhone') document.documentElement.style.setProperty('height', `100vh`);
```

## iOS15 兼容性问题

在iOS 15之前 Safari 滚动网页有2种情况：
- 上方网址栏、下方工具栏同时显示
- 上下方都收起来

现在又多出2种情况，网址栏和工具栏合并
- 在下方都显示
- 在下方都收起来

## iOS 14以下 fixed、absolute 定位bug

当锚定元素滚动后，fixed 定位的元素位置定位出现不准确/随机位置，absolute 定位的元素仍然停留在原地。

解决：
```css
// 在 fixed、absolute 定位元素上添加以下代码
transform: translate3d(0,0,0);
```
