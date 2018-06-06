---
title:  "H5 页面开发：设计稿还原"
category: [CSS, HTML]
---
本文主要是关于 H5 页面开发，还原设计稿 web 前端技术实现的一些经验和思考。

如何组织代码的逻辑顺序？ Your code should give you a good structure for your smallest screen devices。

即当用户在手机上滚动一个长的文档时，优先希望用户看到的东西，应该与代码中元素的书写顺序一致。

参考 [一篇真正教会你开发移动端页面的文章-二](http://hcysun.me/2015/10/19/%E4%B8%80%E7%AF%87%E7%9C%9F%E6%AD%A3%E6%95%99%E4%BC%9A%E4%BD%A0%E5%BC%80%E5%8F%91%E7%A7%BB%E5%8A%A8%E7%AB%AF%E9%A1%B5%E9%9D%A2%E7%9A%84%E6%96%87%E7%AB%A0-%E4%BA%8C/)

95%会使用的基本设定：

```html
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
```
<!--more-->

## 图片

几种方案可供挑选：

+ **字体图标** fonticon 方案应该是最好的解决方案了，能非常契合 rem 布局，能完成不同场景下显示效果一致的问题。

    **缺点**：做字体工作量巨大，让视觉去做这么多矢量图，再转成svg与字体文件，视觉不一定愿意去做。

    一个字体图标生成网站 [iconmoon](https://icomoon.io/)。

+ **每个图标一张大图**，在任何 dpr 的机型之中，都对应同一张图片。好处是通过 rem 的方式，在任何尺寸下都能完美的还原视觉稿。

    **缺点**：给用户流量造成了不必要的开支，即在 dpr1 的 pad 上面，无论如何都是请求最高分辨率的图片。同时，每张图片一个请求不符合减少HTTP请求这一条优化原则。

    据说手淘有自己的技术实现 http 请求时间优化，所以可忽略请求数多带来的时间成本。

+ 图标采取 base64 方案在通过 background-size 缩放。

    **缺点**：如果 base64 图片增多，尤其是在 retina 这种需要双倍图的情况下，会大大增加 css 文件的大小（gzip压缩base64字符也并不明显）。如果css文件过大，还不如增加一个请求来请求图片资源。如果用了自动化工具还好，一旦没有使用自动化工具，代码混乱且难以维护。

    这种方式比较适合图片小而且不经常更换的场景，因此该方案不能作为主体方案。

+ CSS sprite 图，目前 _background-size_ 属性支持不够好。若不改变雪碧图尺寸，则不能 100% 还原视觉稿，因为**在任何手机下看到的图标大小都是固定的**。如果视觉接受这种方案，可以采用 compass 方式自动生成雪碧图。

## 强大的 rem

**优**：保持整体缩放；在移动端不同手机上屏蔽设计上的差异。

实现方法：

    html { //设置页面的rem大小
      font-size: calc(100vw/7.5);
    }

解释：

1. CSS `calc()` 函数，提供加减乘除四则运算，可混合使用各种 CSS 单位（如：%、px、em、rem 等单位）计算长度。如：`calc((100% - 20px * 2) / 3);`

    <span class="t-blue">加号、减号前后的空格不能省略！</span>

2. 以 iPhone6 为基准的高清视觉稿，ps 中看到宽为 750px，实际设备宽度为 375px。上面的 calc 计算可得根元素实际字体大小为 50px。那么:

        1rem = 50px;
        0.28rem = 14px; // 视觉稿上量的 28px，除以 100 转换成 rem 单位 0.28rem

3. 这样在 iPhone6 下，所有元素的尺寸还是和视觉稿的尺寸一样，而 iPhone5 中，因为设备的宽度变小了，`100vw/7.5` 得到的值相应地变小，即 rem 的单位值变小，页面中所有的尺寸会等比例缩放。
4. `7.5` 是让根元素 `<html>` 的 _font-size_ 等于 100px（为了换算方便）计算所得的比例，换成 iPhone5 则为 `6.4` （640px / 100px = 6.4）。

跨浏览器兼容方案：

```javascript
document.documentElement.style.fontSize = document.documentElement.clientWidth / 7.5 + 'px'
```

**注意**:

+ `clientwidth` 以像素计。该属性包括 padding，但不包括垂直滚动条（如果有的话）、border 和 margin。
+ `document.documentElement.clientWidth` 也可用 `window.innerWidth` 代替（但 IE9 以下不支持）。

### initial-scale, maximum-scale

**本文讨论的 px 是 CSS 逻辑像素**，与设备的物理像素是有区别的。如 iPhone 6 使用的是 Retina 视网膜屏幕，使用 2px x 2px 的 device pixel 代表 1px x 1px 的 CSS pixel。

我们知道 CSS 编写的样式尺寸是基于布局视口 viewport 计算的。我们说 iPhone6 设备像素尺寸是 750px，其设备像素比 DPR 是 2。理想视口像素个数 device-width 等于 `375px = 设备像素个数 / DPR`。

这就提供了另一种思路，既然 CSS像素可以放大或缩小，我们将 CSS 像素缩放至与设备像素宽度相等，那么 750 个设备像素也就能显示 750 个 CSS 像素。就可以直接使用 PSD 中所量得的元素尺寸了。

```javascript
var scale = 1 / window.devicePixelRatio;
document.querySelector('meta[name="viewport"]').setAttribute('content','width=device-width,initial-scale=' + scale + ', maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no');
```

然而我们发现，无论是 iPhone5 还是 iPhone6，即使设备像素变了（320px ——> 375px），可是元素的宽度并没有变（始终是 PSD 中量的尺寸），因为它们的 `window.devicePixelRatio` 都是 2。

### 听听设计师怎么说

rem 简单粗暴的实现，使得“屏幕越大按钮越大”。设计师认为“屏幕的尺寸和字体的大小不应该是一个完全正比或者说线性的关系”。

可行的方案：针对不同断点（宽度区间）设置 html 元素的字体大小，当屏幕尺寸大于当前我们认同的手机尺寸时，根元素字体恒为 100px。

### 设置 `<html>` 字体大小完整方案

综上，下面给出原生 JS 实现设置 html 元素字体大小的方法。

```javascript
(function (doc, win) {
    var docEl = doc.documentElement,
    resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
    recalc = function () {
        var clientWidth = docEl.clientWidth;
        if (!clientWidth) return;
        if(clientWidth >= 750){
            docEl.style.fontSize = '100px';
        }else{
            docEl.style.fontSize = clientWidth / 7.5 + 'px';
        }
    };
    if (!doc.addEventListener) return;
    win.addEventListener(resizeEvt, recalc, false);
    doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window);
```

## 文字

使用 `px` 作为**文本**的单位，使用媒体查询来进行动态设置。

```css
@media screen and (max-width: 321px) {
    body {
        font-size:16px
    }
}
@media screen and (min-width: 321px) and (max-width:400px) {
    body {
        font-size:17px
    }
}
@media screen and (min-width: 400px) {
    body {
        font-size:19px
    }
}
```

规律是一二区段字体大小差 1px，二三区段字体大小差 2px。按这个规律来设置其他元素的字体大小。

## iframe

通过设置页面缩放比例 `initial-scale`，需要考虑页面中是否中含有 `<iframe>`，因为 iframe 同样会被缩放。

比如使用 URS 登陆组件，因为它本质就是一个 iframe，我们可以修改其中的样式来达到自己想要的效果。问题在于我们**无法修改** iframe 中根节点 html 的 _font-size_，因此缩放 iframe，无法自动变换其中各个元素的大小。

## Flex 布局

弹性盒子作为布局神器可以完成很多富有创造力的布局，常用的属性 references 看 [这里](https://css-tricks.com/snippets/css/a-guide-to-flexbox/){:target="_blank"}，网站打不开的时候在搜索结果里选缓存页。

关于**兼容性**：测试系统 IOS 8、IOS 9、android 4.2、android 4.4、android 6.0 都 ok。在华为的部分手机上发现flex不支持行内元素，必须改成块级元素才能被支持。

## Grid 布局

具体参考 CSS Grid 章节

## box-sizing

_box-sizing_ 使用它后，不用再单独计算元素宽度和间距，全部根据视觉稿测量的为准。

## 辅助开发工具

切图神器 [cutterman](http://www.cutterman.cn/zh/cutterman)

标记神器 [markman](http://www.getmarkman.com/) 非 PS 插件

视觉稿比对自动调整代码神器 [AlloyDesigner](http://alloyteam.github.io/AlloyDesigner/)

