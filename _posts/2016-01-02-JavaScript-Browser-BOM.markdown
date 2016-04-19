---
title:  "JavaScript Browser BOM"
category: JavaScript
---
**B**rowser **O**bject **M**odel, 浏览器对象模型使得JS可以与浏览器对话。

## Window object

所有浏览器都支持窗口对象。全局变量是 window 对象的属性，而全局函数是 window 对象的方法。

甚至 HTML DOM 的 document 对象也是窗口对象的属性。

### Window Size

`window.innerHeight` 和 `window.innerWidth` 这两个属性可用来测量浏览器窗口的尺寸（以 pixel 为单位）。

浏览器窗口（browser viewport）**不包括工具条和滚动条**.

常用的窗口方法：

+ `window.open()`，打开一个新窗口
+ `window.close()`，关闭当前窗口
+ `window.moveTo()`，移动当前窗口
+ `window.resizeTo()`，重新缩放当前窗口

## Window Screen

`window.screen` 对象包含了用户**设备屏幕**的信息。该对象可以缺省 window 前缀。

常见属性有：

+ `screen.width`，以 pixel 为单位，返回用户屏幕的宽度
+ `screen.height`，以 pixel 为单位，返回用户屏幕的高度
+ `screen.availWidth`，以 pixel 为单位，返回用户屏幕减去特性接口（比如窗口任务栏）的有效可用的宽度
+ `screen.availHeight`，以 pixel 为单位，返回用户屏幕减去特性接口（比如窗口任务栏）的有效可用的高度度
+ `screen.colorDepth`，返回屏幕用于显示一种颜色所需要的 bits 个数。所有现代电脑使用 24bits 或 32bits 的硬件用于颜色 resolution
+ `screen.pixelDepth`，返回屏幕 pixel depth，对于现代电脑，color depth 等于 pixel depth。

## Window Location

`window.location` 对象用来对**页面 URL** 进行操作。该对象可以缺省 window 前缀。

常用属性：

+ `location.href`，返回当前页面的 URL
+ `location.hostname`，返回网络主机的域名（www.w3schools.com）
+ `location.pathname`，返回当前页面的路径和文件名（/js/js_window_location.asp）
+ `location.protocol`，返回使用的 web 协议 （http:// or https://）
+ `location.assign(url)`，该方法加载一个新文档

## Window History

`window.history` 对象包含浏览器的**历史纪录**。该对象可以缺省 window 前缀。

为了保护用户隐私，对于 JS 如何获取该对象有一些限制。

常用的方法有：

+ `history.back()`，加载历史纪录列表中前一个 previous URL，与点击浏览器工具条里的 back 按钮效果一样
+ `history.forward`，加载历史纪录列表中后一个 next URL，与点击浏览器工具条里的 forward 按钮效果一样

## Window Navigator

`window.navigator` 对象包含用户**浏览器信息**。该对象可以缺省 window 前缀。

常用属性：

+ `navigator.appName` 和 `navigator.appCodeName` 返回浏览器的名字。
+ `navigator.product`，返回浏览器引擎的名字，如 Mac OS 上的 Chrome 和 Safari 都是 _Gecko_
+ `navigator.appVersion` 和 `navigator.userAgent` 都返回浏览器的版本信息，包含操作系统信息，几乎一样。区别是，后者是浏览器用来向服务器发送消息的 user-agent header。
+ `navigator.platform`，返回浏览器所在的操作系统。如，当前使用的电脑为 MacIntel
+ `navigator.language`，返回浏览器的语言，当前是 zh-CN
+ `navigator.cookieEnabled`，如果 cookie 是允许的，返回 true

**注意**：

1. IE11, Chrome, Firefox, and Safari return _appName_ "Netscape". Chrome, Firefox, IE, Safari, and Opera all return _appCodeName_ "Mozilla".
2. 最好不要使用从 navigator 对象里获取的浏览器版本信息。因为：不同浏览器可以使用相同的名字，导航器数据可以被浏览器主人修改，一些浏览器错误身份验证为了越过网站测试，浏览器不能报告比它晚发行的新操作系统。

## Popup Boxes

JS 有三种弹出框：Alert box，Confirm box，Prompt box

+ `window.alert(text)`，通常用在你想要确认来自用户的信息，用户不得不点击“OK”进入下一步
+ `window.confirm(text)`，用在当你想要用户去检查或者接受什么，用户必须点击“OK”，或者“Cancel”以进入下一步。**该方法有返回值**。当用户点击“OK”时，返回 true。
+ `window.prompt(text, defaultText)`，用在当你想要用户在进入页面之前输入一个值。用户在输入一个值之后，必须点击“OK”，或者“Cancel”以进入下一步。**该方法也有返回值**。当用户点击“OK”时，返回他输入的值，而当点击“Cancel”时，返回 `null`。

**Bonus**: 如果想在 popup box 里显示换行，使用 `\n`。









