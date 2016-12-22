---
title:  "Pro HTML5 Programming 读书笔记"
category: Other
---
## Canvas API

1. 用 Canvas 绘制出的对象不属于页面 DOM 结构或者任何命名空间

2. 写在 Canvas 开闭标签之间的内容会作为替代内容，在浏览器不支持 Canvas 的时候显示出来，除了文本，还可以使用图片。

3. 可以使用 CSS 为 Canvas 元素添加边框、设置内边距及外边距。一些 CSS 属性可以被 Canvas 内的元素继承。为 Canvas 上下文设置属性要遵循 CSS 语法。

4. 使用 Canvas 编程，首先调用 canvas 对象的 `getContext()` 方法，传入希望使用的 canvas 类型。如传入 _2d_，获取一个二维上下文。如果希望在支持 WebGL 的浏览器中创建 3D 绘图上下文，则使用关键字 _webgl_。

5. canvas 中所有的操作都是通过 context 对象来完成的。所有涉及视觉输出效果的功能都只能通过 context 对象而不是画布对象来使用。

<!--more-->

6. 很多对上下文的操作不会立刻反映到页面上，如 `beginPath`、`moveTo`、`lineTo`，只有对路径应用绘制 `stroke` 或填充 `fill` 方法时，结果才会显示出来。

7. 关于可重用代码一条重要建议：一般绘制都应从原点（坐标系的 0,0 点）开始，应用变换（缩放、平移、旋转等）

    基本步骤：首先，保存当前绘图状态 `context.save()`，然后根据需要移动绘图上下文 `context.translate(x, y)`，接着以原点为起点进行绘制等操作，最后，恢复原有绘图状态 `context.restore()`。

8. 绘制线条常见函数：

    + beginPath()，不论绘制何种图形，这是第一个调用到函数，通知 canvas 要开始绘制新图形了，canvas 以此来计算图形的内部和外部范围，以便完成后续的描边和填充
    + moveTo(x, y)，将当前位置移动到新的目标坐标(x, y)，不绘制
    + lineTo(x, y)，将当前位置移动到新的目标坐标(x, y)，并且在两个坐标之间画一条直线
    + closePath()，该函数行为同lineTo，不过是以路径的起始坐标为目标坐标。

9. context 属性 _lineJoin_，用来修改当前形状中线段的连接方式，如设为 `round`，让拐角变得更圆滑。属性 _lineCap_ 可以来指定线段末端的样式。

10. context 的 `fill()` 函数可以让 canvas 对当前图形中所有的闭合路径内部的像素点进行填充。

11. 描边与填充，如设路径宽度为4px，这个宽度是**沿路径线居中对齐**的。填充则是把路径轮廓内部所有像素全部填充，因此**会覆盖描边路径的一半**。如果希望看到完整的描边路径，可以先填充后描边 `stroke()`。

    + `strokeRect()` 作用是基于给出的位置和坐标画出矩形的轮廓。
    + `fillRect()` 就是填充矩形区域。
    + `clearRect()` 作用是清除矩形区域内所有的内容并将它恢复到初始状态，即透明色。

12. 如何绘制曲线：先使用 `moveTo(x, y)` 函数设置起点，然后使用比如 `quadraticCurveTo(x1, y1, x2, y2)` 之类的函数，第一组代表控制点 control point（调整控制点的位置，可以改变曲线的曲率），第二组是曲线的终点（类似还有 `bezierCurveTo`、`arcTo` 等）通过多种控制点（如半径、角度等）让曲线更具可塑性。

13. 在 canvas 中加入图片，必须等图片完全加载后才可以对其操作，因此**对图片的操作需写在图片对象的 onload 函数里**。

14. context 的画图函数 `drawImage()`，使用前查一下它的所有参数，根据实际需要来设定。

15. 使用渐变三个步骤：

    1.创建渐变对象，如线性渐变，`createLinearGradient(x1, y1, x2, y2)`，设置起点和终点。放射性渐变，`createRadialGradient(x0, y0, r0, x1, y1, r1)`，渐变会在两个圆中间的区域出现为渐变对象设置颜色，指明过渡方式。
    2.在渐变对象上使用 `addColorStop(偏移量，颜色)` 函数。偏移量是一个 _0.0_ 到 _1.0_ 之间的数值，代表沿着渐变线渐变的距离有多远
    3.在 context 上为填充样式或描边样式设置渐变

16. 在描边和填充的时候，还可以使用 `createPattern(image，‘repeat’)`函数实现图片平铺。将该函数返回值赋给 `strokeStyle` 或 `fillStyle` 属性。

17. 特别需要注意的是，缩放（scale）和旋转（rotate）等变换操作都是**针对原点**进行的。如果对一个不在原点的图形进行旋转变换，那么 rotate 变换函数会将图形绕着原点旋转，而不是原地旋转。类似的，如果进行缩放操作时，没有将图形放在合适的坐标上（通常先 save 上下文，然后 translate 原点坐标到何时的位置），那么所有路径的坐标都会被同时缩放，新的坐标可能会全部超出canvas范围。

18. 文本绘制由两个函数 `fillText(text, x, y, maxwidth)` 和 `strokeText(text, x, y, maxwidth)`，（x，y）是第一个字左上角顶点的坐标，最后一个参数是可选的，用来限制字体大小，将文本强制收缩到指定尺寸。设定maxwidth参数以后，可以指定文本的对齐方式，通过上下文 _textAlign_ 属性，如居中对齐 center.

19. 此外 context 还有 `measureText()` 函数，度量指定文本的实际显示宽度。

20. Canvas API 允许开发人员直接访问 canvas 底层像素数据，一方面以数值数组形式获取像素数据，另一方面可以修改数组的值以将其应用于 canvas 上。

    + `getImageData(x，y，width，height)`，返回被x、y、width和height四个参数框定的矩形区域内的canvas上的像素。返回对象包含三个属性，每行、列有多少个像素，一个一维数组，存有获取的每个像素的RGBA值。
    + `putImageData(imagedata, dx, dy)`，通过数学方式修改数组中的像素值，然后使用此函数来更新canvas上的显示
    + `createImageData(sw, sy)`，创建一组图像数据并绑定在canvas对象上

21. `canvas.toDaraUrl()` 能够通过编程来获取canvas上当前呈现的数据，以文本格式存在，这种格式是一种标准的数据表示方法，浏览器能将其解析成图像。

    将 canvas 的内容转为 dataURL 格式以后，可以作为页面中 image 元素的源，(img.src = canvasDataURL)，或者用在 CSS 样式中。

22. 因为可以直接操纵像素数据，为了安全考虑，origin-clean canvas 概念应运而生。如果 canvas 中的图片并非来自包含它的页面所在的域，页面中的脚本将不能取得其中的数据。`getImageData` 函数被调用的时候，如果 canvas 中的图像来自其他域，就会抛出安全异常。只要不获取显示着其他域中图片的 canvas 的数据，可以显示远程图片。

23. 许多浏览器提供 requestAnimationFrame 函数来替代经典的 setTimeout和setInterval 来实现页面更新（这两个函数即便页面在后台运行，仍然会持续更新，这样在用户看不到页面的情况下运行脚本，会让用户觉得你的web应用非常浪费手机电量）。requestAnimationFrame 函数以一个回调函数为参数，由浏览器决定以何种频度调用动画帧。在后台运行的页面，其调用度会降低，浏览器可能会剪掉对提供给 requestAnimationFrame 函数调用的元素的渲染，以优化绘图资源。

注意：如果你的图像显示**需要显著的交互行为**，可以考虑使用 SVG 代替。

## SVG （Scalable Vector Graphic）

在栅格图形中，图像由一组二维像素网格表示。Canvas 2d API 就是一款栅格图形API。PNG 和 JPEG 是两种栅格图形的格式。

在矢量图形中，图像由数学描述的几何形状表示。SVG 是一种矢量格式。HTML5 引入了内联 SVG，因此 SVG 元素可以直接出现在 HTML 标记中。

1. 在 Canvas 元素上绘制文本，字符会以像素方式固定在上面，文本成为图像的一部分，除非重新绘制 Canvas 绘图区域，否则无法改变文本内容。而 SVG 绘制的文本（text 元素中的文本）是鼠标可选的，也可以被搜索引擎获取。Canvas 则做不到。

2. SVG是用来创建视觉结构的语言，同 HTML 一样，它支持脚本操作和添加样式。

3. 放大、旋转或用其他手段变换SVG内容的时候，渲染程序会立即重绘所有构成图像的线条。因此缩放 SVG 不会导致其质量下降。因为 SVG 文档在呈现时会**保留构成它的矢量信息**。而像素图形在图像完成绘制后便丢失了构成图像的路径和图形（基本信息）。

4. SVG 绘制形状对象时，是按照对象在文档中出现的顺序进行的。

5. `<g>`元素代表“组”。可用于将多个元素结合起来，使它们作为一个整体进行变换或链接。

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

2. 源由协议（scheme）、主机（host）、端口（port）组成。源的概念中不考虑路径。

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

WebSockets是全双工实时浏览器通信，减少不必要的网络流量并降低网络延迟。目前实时 Web 应用的实现方式，大部分是围绕轮询和其他服务器端推送技术展开的。

使用轮询（polling）时，浏览器会定期发送 HTTP 请求，并随即接受响应。如果知道消息传递的准确时间间隔，轮询将是一个好办法。由于实时数据往往不可预测，不可避免会产生一些不必要的请求，在低消息率情况下会有很多无用的连接不断地打开和关闭。

使用长轮询（long-polling）时，服务器会在一段时间内将浏览器发送的一个请求保持在打开状态。如果服务器在此期间收到一个通知，就会向客户端发送一个包含消息的响应。如果时间已到还没有收到通知，则发送一个相应消息来终止打开的请求。当信息量很大时，与传统轮询方式相比，长轮询方式并没有实质上的性能改善。

使用流（streaming）解决方案时，浏览器发送一个完整的HTTP请求，但服务器发送并保持一个处于打开状态的响应，该响应持续更新并无限期（或事一段时间内）处于打开状态。每当有消息可发送就会被更新，永远不发出响应完成的信号，这样连接就会一直保持在打开状态以便后续消息的发送。由于流仍是封装在 HTTP 中，其间的防火墙和代理服务器可能会对响应消息进行缓冲，造成消息传递的时延。当检测到缓冲代理服务器时，许多流解决方案就会回退到长轮询方式。

1. WebSocket 接口使用首先新建一个 webSocket 实例，提供连接的对端URL。连接本身是通过 WebSocket 接口定义的 message 事件和 `send()` 函数运作的。`ws://` 和 `wss://` 前缀分别表示 WebSocket 连接和安全的 WebSocket 连接。

2. HTTP 请求和响应报头信息总共包含约871B点额外开销，这些开销中不含任何数据。

3. WebSocket数据有效负载前面的字节标明了帧的长度和类型。文本帧使用UTF-8编码。发送的数据已做掩码（Mask）计算。掩码是 WebSocket 协议一个与众不同的特征。数据有效负载的每个字节都和一个随机掩码做异或（XOR）运算，以确保 WebSocket 传输有别于其他协议。

4. 如果浏览器支持 WebSocket，调用 `window.WebSocket` 就会将 WebSocket 对象返回。

5. WebSocket 编程遵循异步编程模型，打开 socket 后，只需等待事件发生，不需要主动向服务器轮询。连接建立时触发 open 事件，当收到消息时触发 message 事件，当 WebSocket 连接关闭时触发 close 事件。

## 离线 Web 应用

随着完全依赖于浏览器的设备出现，Web 应用程序在不稳定的网络状态下还能够持续工作就变得更加重要。

借助应用缓存，不仅可以缓存访问过的页面，还可以缓存不曾访问过的页面。

1. 检测浏览器是否支持离线Web应用API：

    if (window.applicationCache)

2. 需要在 HTML 元素中设置的 _manifest_ 特性，提供缓存清单文件，指明哪些资源需要存储在缓存中。

3. 通过 _navigator.onLine_ 检测是否处于离线状态。当其值为 `false` 时，不管浏览器是否真正联网，应用程序都不会尝试进行网络连接。

4. manifest 文件的 MIME 类型是 text/cache-manifest，文件的写法是先写 `CACHE MANIFEST`，然后换行，每行单列资源文件。注释内容必须写在以 `＃` 开头的注释行中。文本编码格式必须是 UTF-8。

5. `FALLBACK` 关键字部分，提供了获取不到缓存资源时的备选资源路径。

    比如，`/app/ajax/*  default.html`。当无法获取 /app/ajax/* 时，所有对 /app/ajax/ 及其子路径的请求都会转发给 default.html 文件来处理）

6. `NETWORK` 关键字部分，指明了哪些资源始终从网路上获取。

7. _window.applicationCache.status_ 代表了缓存的状态，一种有6种状态: 对应 0-5 个数值型属性。IDLE（空闲）是带有缓存清单的应用程序的典型状态。如果缓存曾经有效，但现在 manifests 文件丢失，则缓存进入 OBSOLETE（过期）状态。

8. 调用 `update()` 方法，会请求浏览器更新缓存。包括检查新版本的 manifest 文件并下载必要的新资源。如果没有缓存或者缓存已过期，则会抛出错误。

9. 处于联机模式时修改了服务器上的 about 页面，在浏览器中重新加载该页面可能看到的还是旧页面。原因是浏览器始终从应用缓存中加载页面，在那之后，浏览器只会检查 manifest 文件是否被更新过。因此**必须同时修改 manifest 文件**（必须修改字节，即文件内容发生变化）。常见的改动方法是在文件的顶部添加版本注释。

10. 应用缓存进程开启，浏览器开始下载在应用缓存 manifest 文件中引用的文件（这一过程发生在页面加载完成后，其对页面响应性的影响甚微）。