---
title:  "Web optimization"
category: Other
---
关键指标：

- 白屏时间：从浏览器输入地址并回车后到页面开始有内容的时间（这个过程包括dns查询、建立tcp连接、发送首个http请求（如果使用https还要介入TLS的验证时间）、返回html文档、html文档head解析完毕）
- 首屏时间：从浏览器输入地址并回车后，在不滚动屏幕下的前提下，用户看到完整第一屏内容花费的时间（= 白屏时间 + 首屏渲染时间）
- 用户可操作时间节点：domready触发节点，点击事件有反应
- 总下载时间：window.onload的触发节点

<!--more-->

开始请求的时间点：

performance.timing.navigationStart

### 首屏时间

首屏时间一般在 5秒以内是优秀，10秒以内可接受，10s 以后根本不能忍

知道第一屏内容底部在 html 文档的什么位置。第一屏内容底部，定义一个首屏线。

一般来说，首屏内容加载最慢的就是图片资源，可以把首屏内加载最慢的图片的时间当做首屏时间。监听图片标签的 onload 事件，并收集到他们的加载时间，最后比较得到加载时间的最大值。

### 使用 Chrome DevTool 捕捉屏幕渲染瞬间

打开 Console-》选择Device模拟-》调整可视区域，可完整看到手机屏幕-》Network-》点击右侧小齿轮，勾选Capture screenshots-》清空历史请求log

在Chrome地址栏左侧，长按 Reload 图标，在dropdown menu里选择“Empty Cache and Hard Reload”（清空缓存并硬性重新加载）。

捕捉到frame的画面后，双击frame可以放大。图片上方有时间。

## 测量 Performance

Lab data 用 Lighthouse，可以用网页版，也可以从 DevTool 的工具栏里找。这提供一个可以 reproduce 和 debug 的环境。

Field data 用 [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/)，利用谷歌的爬虫生成给予 url 的真实世界 Chrome 用户体验报告。

### Text Content

https://developers.google.com/web/fundamentals/performance/get-started/textcontent-3

用工具minify文件，一个是混淆内容，min文件用于生产环境；另一个是减少字符/文件大小。

server自动压缩整个文件set，所有现代浏览器都支持 HTTP 请求的 Gzip 压缩。就像单文件的压缩，gzip 对text resources表现最佳，能达到70%的压缩。

减少 Library 的使用。比如jQuery，如果只用到很少的功能，没必要下载整个js库。

### Graphical Content

https://developers.google.com/web/fundamentals/performance/get-started/graphicalcontent-4

获得显着性能提升的主要方法之一是减少加载图像所需的时间。

删掉不必要的图片，判断图片是否可以推迟加载。

无需下载的图片（base64编码进html）是最快的。

正确选择图片类型：剪贴画、线条图或任何需要透明度的地方用 PNG；照片用 JPG；动画用 GIF

对于大多数网站，图片的 Metadata 不重要，可以从文件里strip out。

基于图片使用的场景，加载合适size的图片。

### HTTP Requests

假设所有css、js都是external文件。2个相对直观的js位置因素需要考虑：
- 惯例是把js引用放在page head。这种定位的问题在于，在页面显示之前，没有真正要执行的脚本在加载时，阻止了页面呈现。简单有效的解决办法是，把js放在body闭合标签处。
- 例外：任何在渲染之前或期间，用来操作初始内容或 DOM、提供所需页面功能的脚本

为获得最大效率而必须加载资源的顺序称为关键渲染路径。

将关键的预渲染脚本直接放置在页面本身内，称为“inline push”（内联推送）。与html一起加载，并立即执行。

### 使用 performance API 测量关键路径渲染

[评估关键渲染路径:](https://developers.google.com/web/fundamentals/performance/critical-rendering-path/measure-crp?hl=zh-cn)


## 首屏时间

加载是并行的，执行是串行的。html 开始加载的时候，浏览器会将页面外联的 css 文件和 js 文件并行加载，如果一个文件还没回来，它后面的代码是不会执行的。
css 文件的阻塞会影响后面 js 代码的执行，自然也包括 html 代码的执行，即是说此时你的页面就是空白的。所以 css 文件尽量内联

1. “无关紧要”的 js 不要放在负责渲染的 js 前面，这里的“ 无关紧要” 是指和首屏渲染无关，如：数据上报。把渲染相关的代码抽离出来并用原生 js 书写，放到最前面。【我性能优化一期就是这么做的】
2. 动态加载的 js 的执行，跟 HTML 文档后面外联的 js 的执行顺序是不确定的，它不会受到后面 js 阻塞的影响。因此要小心处理好文件的依赖关系。最不容易出错的方法：负责动态加载 js 的文件作为 html 外联的最后一个文件

## Google lighthouse

First Input Delay is a field-only metric, lab data instead shows Total Blocking Time.

Often multiple URLs are grouped together, so the metrics you see in PageSpeed Insights are not necessarily for that particular URL