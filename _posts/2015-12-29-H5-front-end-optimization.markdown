---
title:  "H5手机端优化"
categories: HTML
---
参考文章<a href="https://github.com/amfe/article/issues/21/">H5性能最佳实践</a>

可以借鉴的方面如下：

+ 减少请求数量
    - 将js，css分别合并成单个资源，Stylesheets放在页面头部（let the browser display whatever content it has as soon as possible，这样使页面看起来loading faster），Scripts放在页面下部（因为脚步加载can block parallel downloads 并行下载）。
    - 使用css，svg，iconfont替换UI图片（在手机端iconfont可以只加载ttf格式的字体文件，如果像PC端照顾到各种浏览器，加载各种format的字体文件，会造成极大的网络带宽消耗）
+ 避免重定向：页面和静态资源端重定向会造成巨大的性能消耗。Redirects are accomplished using the **301** and **302** status codes。最常见的wasteful redirect而web developers通常没有意识到的就是，在URL末尾少了"/"。
+ 图片优化
    - 使用WebP格式图片（目前只有Google Chrome和Opera系下的浏览器原生支持该格式），参考文章<a href="http://isux.tencent.com/introduction-of-webp.html/">WebP探寻之路</a>
    - 在CDN服务上生成各个尺寸和质量的图片，合理使用CDN图片尺寸提升下载图片的性能，减少不必要的内存消耗（不要因为可以设置图片尺寸，就用一个特别大的图，然后实际显示用小的尺寸，每浪费10pixel点宽高都可以造成很大的内存资源浪费）。
    - 根据设备DPI值和图片质量做优化，DPI高的，宽高增加后可适当降低质量，对于小项目，目前不涉及这方面。
+ 使用Sprite图片，减少请求数量，方便图标管理。生成紧凑的Sprite图片，减少消耗。
+ 预加载和离线化
+ 渲染优化
    - 禁止使用GIF图片实现Loading效果（降低CPU消耗）
+ 域名收敛，控制页面中使用的域名数量，降低DNS域名解析成本。对于小项目，目前都放在同一个域名下。HTTP/1.1 specification suggests that browsers download no more than two components in parallel per hostname.
