---
title:  "CSS 布局"
category: CSS
---
## CSS 实现网页的居中布局

常见的需求有水平居中、垂直居中。

<!--more-->

### 水平居中

方法一：
```css
.parent {
    text-align: center;
}
.child {
    display: inline-block;
}
```

方法二：
```css
.child {
    display: table;
    margin: 0 auto;
}
```

方法三：
```css
.parent {
    position: relative;
}
.child {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
}
```

### 垂直居中

方式一：
```css
.parent {
    display: table-cell;
    vertical-align: middle;
}
```

方式二：
```css
.parent {
    position: relative;
}
.child {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
}
```

## CSS 实现网页的全屏布局

全屏布局：网页铺满整个浏览器的窗口，没有滚动条，并且随浏览器viewport大小的变化而变化。

case 1:
```html
<div class="container">
    <div class="top">顶：固定高度</div>
    <div class="left">左：固定宽度</div>
    <div class="right"> 右：自适应
        <div class="inner"></div>
    </div>
    <div class="bottom">底：固定高度</div>
</div>
```

```css
.top,
.left,
.right,
.bottom {
    position: absolute;
}
.top {
    top: 0;
    left: 0;
    right: 0;
    height: 100px;
}
.left {
    left: 0;
    top: 100px;
    bottom: 50px;
    width: 200px;
}
.right {
    left: 200px;
    right: 0;
    top: 100px;
    bottom: 50px;
}
.bottom {
    left: 0;
    right: 0;
    bottom: 0;
    height: 50px;
}
```
