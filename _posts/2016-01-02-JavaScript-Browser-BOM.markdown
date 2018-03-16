---
title:  "JavaScript Browser BOM"
category: JavaScript
---
**B**rowser **O**bject **M**odel, 浏览器对象模型使得JS可以与浏览器对话。

## Window object

所有浏览器都支持窗口对象。全局变量是 window 对象的属性，而全局函数是 window 对象的方法。

甚至 HTML DOM 的 document 对象也是窗口对象的属性，可以由 `window.document` 来获取。

### Window Size

_window.innerHeight_ 和 _window.innerWidth_ 这两个属性可用来测量浏览器窗口的尺寸（以 pixel 为单位）。

浏览器窗口（browser viewport）**不包括工具条和滚动条**.

<!--more-->

常用的窗口方法：

+ `window.open(strUrl, strWindowName, [strWindowFeatures])`，打开一个新窗口
+ `window.close()`，关闭当前窗口
+ `window.moveTo()`，移动当前窗口
+ `window.resizeTo()`，重新缩放当前窗口

## Window Screen

_window.screen_ 对象包含了用户**设备屏幕**的信息。该对象可以缺省 window 前缀。

常见属性有：

+ _screen.width_，以 pixel 为单位，返回用户屏幕的宽度
+ _screen.height_，以 pixel 为单位，返回用户屏幕的高度
+ _screen.availWidth_，以 pixel 为单位，返回用户屏幕减去特性接口（比如窗口任务栏）的有效可用的宽度
+ _screen.availHeight_，以 pixel 为单位，返回用户屏幕减去特性接口（比如窗口任务栏）的有效可用的高度度
+ _screen.colorDepth_，返回屏幕用于显示一种颜色所需要的 bits 个数。所有现代电脑使用 24bits 或 32bits 的硬件用于颜色 resolution
+ _screen.pixelDepth_，返回屏幕 pixel depth，对于现代电脑，color depth 等于 pixel depth。

## Window Location

_window.location_ 对象用来对**页面 URL** 进行操作。该对象可以缺省 window 前缀。

常用属性和方法：

+ _location.href_，返回当前页面的 URL
+ _location.hostname_，返回网络主机的域名（www.w3schools.com）
+ _location.pathname_，返回当前页面的路径和文件名（/js/js_window_location.asp）
+ _location.protocol_，返回使用的 web 协议 （http:// or https://）
+ `location.assign(url)`，该方法加载一个新文档

## Window History

_window.history_ 对象包含浏览器的**历史纪录**。该对象可以缺省 window 前缀。

为了保护用户隐私，对于 JS 如何获取该对象有一些限制。

常用的方法有：

+ `history.back()`，加载历史纪录列表中前一个 previous URL，与点击浏览器工具条里的 back 按钮效果一样
+ `history.forward()`，加载历史纪录列表中后一个 next URL，与点击浏览器工具条里的 forward 按钮效果一样

## Window Navigator

_window.navigator_ 对象包含用户**浏览器信息**。该对象可以缺省 window 前缀。

常用属性：

+ _navigator.appName_ 和 _navigator.appCodeName_ 返回浏览器的名字。
+ _navigator.product_，返回浏览器引擎的名字，如 Mac OS 上的 Chrome 和 Safari 都是 _Gecko_
+ _navigator.appVersion_ 和 _navigator.userAgent_ 都返回浏览器的版本信息，包含操作系统信息，几乎一样。区别是，后者是浏览器用来向服务器发送消息的 user-agent header。
+ _navigator.platform_，返回浏览器所在的操作系统。如，当前使用的电脑为 MacIntel
+ _navigator.language_，返回浏览器的语言，当前是 zh-CN
+ _navigator.cookieEnabled_，如果 cookie 是允许的，返回 true

**注意**：

1. IE11, Chrome, Firefox, and Safari return _appName_ "Netscape". Chrome, Firefox, IE, Safari, and Opera all return _appCodeName_ "Mozilla".
2. 最好不要使用从 navigator 对象里获取的浏览器版本信息。因为：不同浏览器可以使用相同的名字，导航器数据可以被浏览器主人修改，一些浏览器错误身份验证为了越过网站测试，浏览器不能报告比它晚发行的新操作系统。

## Popup Boxes

JS 有三种弹出框：Alert box，Confirm box，Prompt box

+ `window.alert(text)`，通常用在你想要确认来自用户的信息，用户不得不点击“OK”进入下一步
+ `window.confirm(text)`，用在当你想要用户去检查或者接受什么，用户必须点击“OK”，或者“Cancel”以进入下一步。该方法有返回值。**当用户点击“OK”时，返回 `true`**。
+ `window.prompt(text, defaultText)`，用在当你想要用户在进入页面之前输入一个值。用户在输入一个值之后，必须点击“OK”，或者“Cancel”以进入下一步。该方法也有返回值。**当用户点击“OK”时，返回他 _输入的值_ ，而当点击“Cancel”时，返回 `null`**。

**Bonus**: 如果想在 popup box 里显示换行，使用 `\n`。

## Timing Events

窗口对象允许在特定的时间间隔里执行代码。主要的方法是：

+ `window.setTimeout(function[, delay, param1, param2, ...])`，在等待指定**毫秒数**的时间后执行一个函数，返回值是一个**正整数**的 timeoutID。额外的 parameters 将被传给前面指定的 function。
+ `window.setInterval(function, milliseconds)`，在给定的时间间隔里，重复执行指定的函数。比如每个 1000 毫秒执行一次日期显示时间函数，看起来就像是一个数字时钟。
+ `window.clearTimeout(timeoutID)`，该方法用来停止使用 `setTimeout()` 要执行的函数。
+ `window.clearInterval(timerVariable)`，该方法用来停止使用 `setInterval()` 在执行的函数。使用从 `setInterval()` 函数返回的变量。

### 事件节流 Throttling

一些事件如 mousemove、resize、scroll 是连续的更新，浏览器会尽快触发更新。有时只想要在用户停止连续操作时才更新页面，当你有大量code要响应事件时尤其重要。

事件节流/函数防抖，即对于一系列更新事件只响应一次。使用 generator function 形成闭包可以实现：

```js
// Debounce：throttle-then-act
function throttleEvents(listener, delay) {
    let timeout = null;
    return function() {
        // 2.如果已经有timer则清除并停止执行
        if (timeout) clearTimeout(timeout);
        // 3.设置新的timer，且在倒计时结束时执行真正的事件处理函数
        timeout = setTimeout(listener, delay);
    }
}
// 1.事件发生时设置一个timer，创建延迟
element.addEventListener(eventType, throttleEvents(realListenerFunction, 500))

// Throttling：act-then-throttle
function actThenThrottleEvents(listener, delay) {
  let timeout = null;
  return function() {
    if (!timeout) { // no timer running
      listener.apply(this, arguments) // run the function，传递上下文和参数
      timeout = setTimeout( function() { timeout = null },
        delay); // start a timer that turns itself off when it's done
    }
    //else, do nothing (we're in a throttling stage)
  }
}
```

## JS Cookies

Cookies 是一些数据，在你的电脑里用文本文件里存储网页用户信息。Cookies 的发明是用来解决“如何记住用户信息”的问题。

Cookies 以 name-value 形式存储。（如 username = Viivenne）当浏览器向服务器请求一个网页时，属于那个页面的 cookies 被添加到请求里。

### Create

使用 _document.cookie_ 属性创建、读取、更新、删除（CRUD） cookies

    document.cookie = "username=Vivienne WU";

+ 可以添加一个过期日期（以 UTC 时间格式）<span class="t-blue">默认地，当浏览器关闭时，cookie 被删除</span>

    document.cookie = "username=John Doe; expires=Thu, 18 Dec 2013 12:00:00 UTC";

+ 可以添加一个 path 参数，告诉浏览器 cookie 属于哪一个路径。<span class="t-blue">默认地，cookie 属于当前页面</span>

    document.cookie = "username=John Doe; expires=Thu," +
                      " 18 Dec 2013 12:00:00 UTC; path=/";

使用 _document.cookie_ 多次赋值，旧的 cookie **不会**被覆盖，而是追加到 cookies 里。

### Read

使用 _document.cookie_ 在**一个字符串中**返回**所有** cookie. （比如: cookie1=value; cookie2=value; cookie3=value;）

如果你想要找到指定 cookie 的值，必须使用 JS 查询方法在 cookie 字符串里查找。

### Change/Update

使用 `document.cookie = “key=value”`，key 是要更新的 cookie 名称，value 是新的值。

### Delete

删除方法很简单，只要**将 _expires_ 参数设置为一个已经过去的时间**。不需要指定 cookie 的值。

    document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
