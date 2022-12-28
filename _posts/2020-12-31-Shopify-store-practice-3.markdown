---
title:  "Shopify独立站实践（3）"
category: Other
---

## Shopify theme最佳实践

1. 优化js
  + 减少js的使用（用css代替js），压缩文件（少于16kb），当从storefront请求时，Shopify 自动压缩主题的 JavaScript 和 CSS 文件。
  + 减少外部框架、库的依赖，尽可能使用浏览器原生的功能和现代DOM APIs。
  + 在 script 标签上使用 `defer` 或 `async`，在 HTML 文档解析时下载文件，区别：前者不阻塞HTML文档解析，后者下载完毕后立即执行，会中断HTML parse（https://stackoverflow.com/a/39711009/2474841）
2. 提前加载关键资源
3. 交互驱动的late loading，让首次加载时main thread更加free空闲
  + 仅当页面需要时加载图片，非首屏的图片延迟加载
  + 使用css、html实现入口，直到用户产生交互时才加载功能代码，如：点击share、help聊天工具
  + 使用facade（表面，视频的封面+一个假的播放按钮），如果用户不点击播放，则不去fetch和处理视频资源
  + 基于组件进行代码split
4. 使用system font
5. 静态资源放到Shopify server上。使用相同的host，避免unnecessary http链接
  + 把资源放到主题的 assets 目录下
### lazy-loading图片

浏览器级别的 lazy-loading：在 `<img>` 元素上使用 _loading_ 属性。值设为 lazy，元素出现在可是区域时浏览器立即加载图片，当用户滚动到其他图像附近时获取其他图像。

当前支持率为74.7%，Safari不支持，三星android手机也有兼容性问题。对于不支持该属性的浏览器需要结合以下方法之一来实现图片懒加载。

#### Intersection Observer

当前支持率为94.9%

用于检测元素的可见性，或两个元素相对于彼此的相对可见性。Intersection Observer API 允许代码注册一个回调函数，只要希望监视的元素进入或退出另一个元素（或 viewport），或者当两者相交的量改变了达到 requested 的量时，就会执行该回调函数。这样，网站不再需要在主线程上做任何事情来监视这类元素相交，并且浏览器可以自由地、以它认为合适的方式来优化 intersection 的管理。

Intersection Observer API 不能指出两元素相交的具体 pixel 数量，而是以目标元素的百分比的形式，显示目标元素与 root 元素相交的程度。

创建：

```js
let options = {
  root: document.querySelector('#scrollArea'), // 不指定，或 null 时，默认时浏览器的 viewport，必须为目标元素的 ancestor 元素
  rootMargin: '0px', // 表示环绕 root 的外边距，用法类似 CSS margin（top, right, bottom,left），可以为百分数。
  threshold: 1.0 // 表示当目标的 100% 部分在 root 选项指定的元素中可见时调用回调函数。.也可以传入 number[]。默认 0，表示只要一个像素可见，就会运行回调
}
let observer = new IntersectionObserver(callback, options);
let target = document.querySelector('#listItem');
observer.observe(target); // 我们可以选择通过为每个元素调用 observer.observe()，来监控多个元素相对于视口的可见交集变化

let callback = (entries, observer) => { // 回调函数接收一个 IntersectionObserverEntry list 和观察者
  entries.forEach(entry => {
    // 每个条目描述了一个观察到的目标元素的交集变化
    //   entry.boundingClientRect
    //   entry.intersectionRatio
    //   entry.intersectionRect
    //   entry.isIntersecting，表示target当前是否与根元素相交
    //   entry.rootBounds
    //   entry.target
    //   entry.time
  });
};
```

注意：回调是在主线程上执行的。应该尽快运行；如果需要做任何耗时的事情，请使用 `Window.requestIdleCallback()`

### import on interaction

使用dynamic `import()`，懒加载模块，返回一个promise。

使用基于promise的 `scriptLoader()`，动态插入 script。

## A/B test

- 可以从读Cookies吗？我们自己是在服务端通过cookie控制前端输出，实现A/Btest。但是 Shopify liquid 目前不支持读取cookies。
- 可以扩展Liquid吗？Shopify Liquid不能通过theme code进行扩张。只能官方自己修改core代码。

## Online store speed score

不可控制的因素：用户的设备、网络和地理位置，Shopify infrastructure

+ Shopify host网店在全球服务器，经常会做代码和基础设施的升级，这些提升可能会反应到店铺speed评分上。
+ Shopify给商家提供世界级的 CDN，保证在线店铺在全球各地加载快速。
+ Shopify为店铺可缓存的资源（图片、PDFs、js文件、css文件）设置了浏览器本地缓存，每个文件1年过期时间。此外，Shopify在服务端缓存页面。
+ 通过 content_for_header liquid tag 加载的资源

可控的因素：

+ app，不用的app就移除掉，残留app代码要及时清理掉。只run在admin的app，不影响online store speed
+ 主题或app功能，加载用户不用的额外数据会影响店铺speed。可以使用 heatmap（https://apps.shopify.com/search?q=heatmap）工具，看下用户是否使用某功能。
+ 复杂或低效的 Liquid 代码，重复执行复杂操作会增加Liquid渲染时间。可以使用 Shopify Theme Inspector for Chrome（https://shopify.dev/themes/tools/theme-inspector?shpxid=0dc37285-68ED-40C1-DDE7-1D1DF7612701）来检查导致页面变慢的代码行。

图片和视频：
超大图片和可视区域之外的图片可能会干扰页面中更重要的部分的加载。
+ Shopify限制store过度加载图片或视频：collection页不超过50个，首页不超过25个sections
+ 推迟加载还不在当前屏幕内的图片（https://www.shopify.com/partners/blog/lazy-loading）
+ 更加屏幕尺寸加载specific尺寸大图片

图片优化 tips：https://www.shopify.ca/blog/7412852-10-must-know-image-optimization-tips?shpxid=0dd80ef9-F892-44C4-1F20-AF536A552156

### 影响评分的因素

apps、第三方库和服务、分析工具的库、主题代码、图片和视频的数量及尺寸

speed score 根据 Google Lighthouse 性能指标，测量在线商店在 Shopify 测试环境中的性能表现。

分数是基于以下页面的 Lighthouse 性能评分的加权平均值：home页、过去 7 天内流量最大的产品页面、过去 7 天内流量最大的产品系列页面。

权重基于多个因素，包括各个类型页面与所有 Shopify 商店比较的相对流量。

在线商店速度评分是 Lighthouse performance scores 多天的平均值。这是因为每次测试的性能分数可能略有不同，多天的平均值可更好地代表商店的日常性能。

点 view insigths 是在 Google PageSpeed Insights 上运行 Lighthouse 报告，而不是 Shopify test 环境，两者测试条件不同。因此看到的分数会跟Shopify 这边显示的 online store scores 不一样。所有平台上的分数仅代表您商店在当前时间点的测量值。

很高的Google Lighthouse 评分比较难实现，因为它是将在线店铺跟所有类型的网站做比较，其中有很多不提供相似的功能。

所有用于 speed scores 的 Lighthouse 性能报告都是使用相同的 Shopify 环境运行的，因此 Shopify 将店铺的得分与 Shopify 平台上的其他在线商店的得分进行准确比较。也就是为什么 Shopify 的 ranking 更有参考价值。

Shopify ranking标准：slower than、same speed as、faster than similar stores。每次 speed score 更新时会重新计算 ranking。speed score 在 UTC 时间上午 9:00 重新计算。

similar stores拥有不限于这些共同属性：迄今为止的销售数量、销售总额、产品和变体的数量、产品类型、流量、安装的应用程序、使用的主题。

## 新建webpage

https://help.shopify.com/en/manual/online-store/pages

1. Online Store -》Themes -》Edit Code -》Template里点 Add new template -》suffix写自定义的名称，如：help_center
2. Online Store -》Pages -》新建page，标题不要随便写，会显示在浏览器标题栏以及seo里 -》修改template为自定义的那个suffix
3. 如需修改访问链接的path，默认是 /pages/{handlize处理过的title}，点下方的 seo 模块修改
