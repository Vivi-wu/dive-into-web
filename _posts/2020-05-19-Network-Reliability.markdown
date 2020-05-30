---
title:  "Network Reliability"
category: Other
---
## 什么是网络可靠性，如何衡量？

1. 断网情况下你的 web app 是否能工作？当你看到原生 app 图标时，无论当前是否有网，你都希望能够点击它打开某种体验。
2. 当用户网络不理想时，是否可以相信你的 web app 能以足够快的速度加载？

借助谷歌的[Lighthouse](https://developers.google.com/web/tools/lighthouse/)工具，可以检测 PWA 的可靠性。

### 加载了哪些文件？

通过谷歌开发者工具-》Network，关闭  Preserve log，开启 Disable cache，选 All，观察下网站加载了哪些文件，然后置顶缓存策略。

### 何时加载？

用于渲染初始 HTML 的 CSS、JS （只有加载了这些文件才能显示可交互的页面）位于关键加载路径中。 通过缓存它们使 web app 可靠得快。

通过谷歌开发者工具-》Network 中 Waterfall 这一列可以看出各资源加载的先后顺序及加载时间。

<!--more-->

### HTTP Cache

是一种有效的方式提升加载性能，它减少了不必要的网络请求，跨浏览器。

### Service workers 和 Cache Storage API

除了 HTTP 缓存，通过引入 Service workers 和 Cache Storage API，我们可以创建可靠的 web app。前者内置于浏览器，等待 web app 发送请求，一些请求被放行，就像 service worker 不存在；而另一些请求利用浏览器的 HTTP cache 返回可靠的快速响应。

通过 the Cache Storage API 可以实现 HTTP cache 不能或很难实现的功能：

+ 后台刷新
+ 设置最大缓存资源上限，并在达到该限制后实施自定义过期策略以删除项目
+ 比较之前缓存的和最新的网络响应，以查看是否有任何更改，并在有更新时，允许用户更新内容（例如，使用按钮）。

### 实际应用

这里引入 [Workbox](https://developers.google.com/web/tools/workbox/)，一个构建于 Service workers 和 Cache Storage API，可直接运行在生成环境，为 web app 增加离线支持的 js 库。

这个工具包由2部分组成：

+ 运行在你的 service worker 内部的代码：决定sw是否响应（routing），以及如何响应（caching strategy）
+ 与构建过程集成：基于配置选项，使用 Workbox's runtime libraries 创建一个sw脚本。基于配置模式在构建过程中，添加或排除文件，生成一个需要 precached的 URL 清单。

好处：

+ 帮你处理缓存更新，底层 Cache Storage API 功能强大，但是没有任何内置的缓存过期支持。既可以绑定到构建过程中使用预缓存，也可以通过配置 ize/age 策略使用运行时缓存
+ Workbox 自动检测是否运行在 localhost 本地开发，开启 debug 日志，在浏览器 console 里可以看到日志和错误报告
+ 代码针对跨浏览器测试套件开发的，对于当前浏览器不支持的 API，提供了 fallback

一些官方工具集成了 Workbox，比如我们 H5 登录由 [create-react-app](https://create-react-app.dev/docs/making-a-progressive-web-app/) 创建，可以参考官方文档使用。

#### Precaching
 
对于指定版本的 web app，有一个 precache manifest（由 URLs 以及每个 URL 相连的版本信息组成的清单）

```js

[{
  url: 'app.abcd1234.js'
}, {
  url: 'index.html',
  revision: '518747aa'
}]
```

对于第一条，url 已包含版本信息，Workbox构建工具可以检测到，故可以缺省 revision 字段。对于第二条，构建工具跟将本地文件内容生成 hash 写入 revision字段。

每次重新构建网站时都生成一个完整的 precache manifest，就可以保证更新已缓存的 URL，预缓存新的资源，删除过期的条目。

预缓存带来了原生app相同的体验，不必等用户去访问每一个单独的视图，提前缓存web app所有需要展示的 URL，这样用户之后访问每个部分都能很快地展示。

记住预缓存涉及到使用网络带宽和用户设备的存储空间，长远来看，重复访问我们 web app 的人将从预缓存的前期成本中受益。

缓存那些对于展示指定页面基本结构重要的 HTML、JS、CSS，对于 web app 功能不那么重要的媒体或其他资源，使用 runtime 缓存策略。

#### Runtime caching

运行时缓存是指“按需”将响应逐渐添加到缓存中。尽管运行时缓存无法帮助提高当前请求的可靠性，但可以使之后对同一URL的请求更加可靠。浏览器的 HTTP cache 是运行时缓存的一个例子。

运行时缓存以多种方式组合 network 和 cache，形成了不同的缓存策略：

+ Network-first，sw先尝试从网路上获取响应，如果请求成功，则把响应的副本存储下来（创建一个新的entry，或者更新相同的URL的entry）。当网络请求完全失败，或者长时间没有响应，则从缓存里返回最新的一个响应。
+ Cache-first，与 Network-first 相反，sw拦截请求，想查看缓存里是否有可用的响应，如果有，则返回响应。如果没有，sw去网路上尝试获取响应。请求成功，就把响应的副本存储到缓存里，用于下一次相同URL的请求。
+ Stale-while-revalidate，sw 会立刻检测缓存的响应，找到了就返回给 web app。同时，不论是否有匹配的缓存，sw也会发起一个网路请求，获取一个新鲜的响应。该响应用于更新任何之前缓存的响应。如果缓存检测没有找到匹配的响应，那么网络返回的响应副本也会传给 web app

#### 使用什么策略缓存哪些资源？

1. reliability 优于 freshness 时，用 Stale-while-revalidate 策略。即使是旧的值，但立即显示什么更重要。比如用户头像（profile images），用来填充视图的初始api。
2. freshness 优于 reliability 时，用 Network-first 策略。比如一个频繁更新的文章的内容。这种策略的好处是即使离线，仍然能够 fall back 一些东西。
3. 仅在你知道资源不太会改变的情况下使用 cache-first 策略，因为一个entry一旦被缓存，永远不更新。URL 最好包含版本信息。

## Workbox

[Workbox webpack Plugins](https://developers.google.com/web/tools/workbox/modules/workbox-webpack-plugin) 提供了2种插件： `GenerateSW` 和 `InjectManifest`，create-react-app 用的是前者（构建是帮你创建一个service worker文件，并添加到 webpack 的资源管道种），m 站用的是后者（生成要预缓存的 URL 列表，并将该预缓存清单添加到已有的 service-worke.js 文件中）。

关于选择哪一种方案，谷歌给出了一些建议，见上面 webpack 插件的链接：

GenerateSW
用：
- 需要 precache文件
- 简单的 runtime 配置需求（定义 routes 和策略）
不用：
- 需要使用其他 Service Worker 的功能，比如 Web Push
- 你想要引入额外的脚本和逻辑

InjectManifest
用：
- 需要对 service worker 有更多的控制
- 需要precache 文件
- 在routing有跟多复杂需求
- 结合其他 API 使用 service worker，如：Web Push
不用：
- 你想要用最简单的方式给网站添加一个 service worker

改进：
+ js chunk：vendor、common、login
+ css head引用加preload
