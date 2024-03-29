---
title:  "Pro HTML5 Programming 读书笔记"
category: Other
---
## SVG （Scalable Vector Graphic）

在栅格图形中，图像由一组二维像素网格表示。Canvas 2d API 就是一款栅格图形API。PNG 和 JPEG 是两种栅格图形的格式。

在矢量图形中，图像由数学描述的几何形状表示。SVG 是一种矢量格式。HTML5 引入了内联 SVG，因此 SVG 元素可以直接出现在 HTML 标记中。

1. 在 Canvas 元素上绘制文本，字符会以像素方式固定在上面，文本成为图像的一部分，除非重新绘制 Canvas 绘图区域，否则无法改变文本内容。而 SVG 绘制的文本（text 元素中的文本）是鼠标可选的，也可以被搜索引擎获取。Canvas 则做不到。

2. SVG是用来创建视觉结构的语言，同 HTML 一样，它支持脚本操作和添加样式。

3. 放大、旋转或用其他手段变换SVG内容的时候，渲染程序会立即重绘所有构成图像的线条。因此缩放 SVG 不会导致其质量下降。因为 SVG 文档在呈现时会**保留构成它的矢量信息**。而像素图形在图像完成绘制后便丢失了构成图像的路径和图形（基本信息）。

4. SVG 绘制形状对象时，是按照对象在文档中出现的顺序进行的。

5. `<g>`元素代表“组”。可用于将多个元素结合起来，使它们作为一个整体进行变换或链接。

<!--more-->

6. `<defs>` 元素定义留待将来使用的内容，定义的组本身不可见。`<use>` 元素用来链接到 `<defs>` 元素定义的内容。借助这两个元素，可以实现内容的复用。

7. SVG 绘制路径。`<path>` 元素中 _d_ 代表数据 data，_M_ 代表移至 moveto，_L_ 代表绘线至 lineto，_Q_ 代表二次曲线，_Z_ 代表闭合路径。

## Geolocation API

位置信息由纬度、经度坐标和一些其他元数据组成，利用这些位置信息可以构建位置感知类应用程序。

经纬度坐标可以用以下两种方式表示：

+ 十进制（如：39.172 22）
+ DMS（degree minute second，角度）格式（如，39° 10‘20‘）

1. HTML5 Geolocation API 返回坐标的格式为十进制格式。除了坐标，还提供位置坐标的准确度。一些其他元数据包括海拔、海拔准确度、行驶方向和速度等。如果这些数据不存在则返回 null

2. HTML5 Geolocation 只是用于检索位置信息的 API，并不能保证设备返回的实际位置时精确的。

3. 位置信息来源：

    + IP地址，如果用户IP地址是ISP（互联网服务提供商）提供的，其位置往往由服务供应商的物理地址决定，一般精确到城市级。
    + GPS，可以看到天空的地方，就可以提供非常精确大定位结果，但定位时间长，不适合需要快速响应的应用程序。
    + wifi，通过三角距离（用户当前位置到已知的多个wifi接入点的距离）计算得出，在室内也非常准确。
    + 手机，通过用户到一些基站的三角距离确定的。此方法通常同基于wifi和基于GPS的地理定位信息结合使用
    + 用户自定义数据，用户自行输入可能比自动检测更快，但当用户位置变更久不准确了。

4. 规范提供了一套保护用户隐私的机制，除非得到用户明确许可，否则不可获取位置信息。应用程序不能直接访问设备，只能请求浏览器从其寄主设备中检索坐标信息。

5. 只要所添加的 HTML5 Geolocation 代码被执行，浏览器就会提示用户应用程序要共享他们的位置。

6. 位置数据属于敏感信息，如果用户没有授权存储这些数据，那么应该在相应任务完成后立即删除它。上传位置数据，建议先对其进行加密。

7. 收集地理定位数据时，应该着重提示用户以下内容：

    + 会收集位置数据
    + 为什么收集
    + 将保存多久
    + 怎样保证数据的安全
    + 位置数据怎样共享、和谁共享（如果同意共享）
    + 用户怎样检查和更新他们的位置数据

8. 如果存在地理定位对象，`navigator.geolocation` 调用将返回该对象

9. 单次定位请求核心函数 `getCurrentPosition(successCallback, errorCallback, options)`。第一个参数是收到实际位置信息并进行处理的地方，第二个参数是提供跟用户解释或提示其重试的地方（可选，不过建议选用），options 对象可以调整 HTML5 Geolocation 服务的数据收集方式（也是可选的，包含：

    + enableHighAccuracy，启用该参数，可能没有任何差别，也可能会导致机器花费更多的时间和资源来确定位置，默认值为 false
    + timeout，单位为ms，计算当前位置所允许的最长时间，默认值为Infinity
    + maximumAge，单位为ms，浏览器重新计算位置的时间间隔，默认值为零。

10. 位置对象包含坐标（coords特性）和一个获取位置数据的时多时间戳。Coords 特性中重要的三个特性：latitude（纬度）、longitude（经度）、accuracy（准确度，以m为单位指定纬度和经度值与实际位置间的差距，置信度为95%）。其他特性如果不支持则返回null。比如使用笔记本电脑，怎无法访问以下信息：altitude、altitudeAccuracy、heading（行进方向）、speed（m/s为单位）

11. 错误对象作为 code 参数传递给错误处理程序：

    + PERMISSION_DENIED（错误编号1），用户拒绝浏览器获得其位置信息
    + POSITION_UNAVAILABLE（错误编号2），尝试获取用户位置数据，但失败了
    + TIMEOUT（错误编号3），设置了可选点timeout值，尝试确定用户位置的过程超时了

12. 以既定间隔多次请求用户位置函数 `watchPosition(updateLocation, handleLocationError)`，只要用户位置发生变化，Geolocation 服务就会调用 updateLocation 处理程序。请注意，地理位置API不允许我们为浏览器制定多长时间重新计算一次位置信息，这是完全由浏览器的实现所决定的。我们所能做的就是高速浏览器maximumAge的返回值是什么。实际频率是一个我们无法控制的细节。

13. 当不再需要接收用户的持续位置更新，只需调用 `clearWatch(watchId)` 函数，其参数就是 watchPosition() 函数的返回值。

## 跨文档信息通信

现实中存在一些让不同站点的内容能在浏览器内进行交互的需求。跨文档信息通信可以确保 iframe、标签页、窗口间安全地进行跨源通信。

postMessage API为发送消息的标准方式。

    chatFrame.contentWindow.postMessage('Hello world', 'http://www.example.com/');

1. message 事件是一个拥有 data（数据）和 origin（源）属性的 DOM 事件。有了 origin 属性，接收方可以根据可信源列表判断来源是否可靠。

2. Origin（源）由 scheme（protocol协议）、hostname（domain域名）、port（端口号）组成。只有当这3项全匹配，才认为是 Same origin（同源）

3. 判断浏览器是否支持 postMessage API，如下

    window.postMessage==="undefined"

4. 应用程序检测其所在窗口是否为最外层窗口

    (window.top) if (window!==window.top)

5. XMLHttpRequest Level 2 通过 CORS（Cross Origin Resource Sharing）实现了跨源 XMLHttpRequest。跨源 HTTP 请求包括一个 Origin 头部，为服务器提供 HTTP 请求的源信息。头部由浏览器保护，不能被应用程序代码更改。

6. 出于向后兼容的目的，在新版本中，旧的 readyState 属性和 readystatechange 事件得以保留。

7. 使用 progress 进度事件，`e.total` (待发送数据的总量)、`e.loaded` (已发送数据的总量)、`e.lengthComputable` (标志数据总量是否已知)。计算上传的完成率：

```js
xhr.upload.onprogress=function(e) {
  var ratio = e.loaded/e.total;
  notify(ratio + "% uploaded");
};
```

## WebSockets API

传统的HTTP协议是一个单向通信（请求－响应）协议，请求必须先由浏览器发起，服务器才能响应这个请求返回数据给浏览器。

WebSocket是 HTML5 新增的协议，它实现了浏览器和服务器之间的双向通信的通道，这样服务器可以在任意时刻发送消息给浏览器。减少不必要的网络流量，并降低网络延迟。

在此之前，用HTTP协议来实现一些实时应用，大多通过轮询和Comet，后者本质上也是轮询，在没有消息的情况下，让服务器等待一段时间。

Comet连接必须定期发一些ping数据表示连接“正常工作”。

使用轮询（polling）时，浏览器会定期发送 HTTP 请求，并随即接受响应。如果知道消息传递的准确时间间隔，轮询将是一个好办法。由于实时数据往往不可预测，不可避免会产生一些不必要的请求，在低消息率情况下会有很多无用的连接不断地打开和关闭。

使用长轮询（long-polling）时，服务器会在一段时间内将浏览器发送的一个请求保持在打开状态。如果服务器在此期间收到一个通知，就会向客户端发送一个包含消息的响应。如果时间已到还没有收到通知，则发送一个相应消息来终止打开的请求。当信息量很大时，与传统轮询方式相比，长轮询方式并没有实质上的性能改善。

使用流（streaming）解决方案时，浏览器发送一个完整的HTTP请求，但服务器发送并保持一个处于打开状态的响应，该响应持续更新并无限期（或事一段时间内）处于打开状态。每当有消息可发送就会被更新，永远不发出响应完成的信号，这样连接就会一直保持在打开状态以便后续消息的发送。由于流仍是封装在 HTTP 中，其间的防火墙和代理服务器可能会对响应消息进行缓冲，造成消息传递的时延。当检测到缓冲代理服务器时，许多流解决方案就会回退到长轮询方式。

1. WebSocket 接口使用首先新建一个 webSocket 实例，提供连接的对端URL。连接本身是通过 WebSocket 接口定义的 message 事件和 `send()` 函数运作的。`ws://` 和 `wss://` 前缀分别表示 WebSocket 连接和安全的 WebSocket 连接。

2. HTTP 请求和响应报头信息总共包含约871B点额外开销，这些开销中不含任何数据。

3. WebSocket数据有效负载前面的字节标明了帧的长度和类型。文本帧使用UTF-8编码。发送的数据已做掩码（Mask）计算。掩码是 WebSocket 协议一个与众不同的特征。数据有效负载的每个字节都和一个随机掩码做异或（XOR）运算，以确保 WebSocket 传输有别于其他协议。

4. 如果浏览器支持 WebSocket，调用 `window.WebSocket` 就会将 WebSocket 对象返回。

5. WebSocket 编程遵循异步编程模型，打开 socket 后，只需等待事件发生，不需要主动向服务器轮询。连接建立时触发 open 事件，当收到消息时触发 message 事件，当 WebSocket 连接关闭时触发 close 事件。

## 离线 Web 应用

使用 Service Workers 不仅可以缓存访问过的页面，还可以缓存不曾访问过的页面。具体参考 PWA 章节。

## GlobalEventHandlers.onerror

error 事件的处理函数。

+ 当一个资源（如图片、脚本）加载失败时，Event 接口在 initiate 加载资源的元素上触发 error 事件，然后绑定在该元素上的 onerror 函数就被调用。这些错误事件不会冒泡到window。可用来处理，当一个 img 资源加载失败，加载其他图片资源。