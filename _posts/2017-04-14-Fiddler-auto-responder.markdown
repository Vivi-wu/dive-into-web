---
title:  "使用 Telerik Fiddler 让本地开发飞起"
category: Other
---
Telerik Fiddler 主要用在 Windows 系统下，官方也有 mac os 版，但是貌似不好用，下载下来的还是exe

之前wy同事推荐，第一次知道前后端分离本地开发还有这种操作。

最常用的就是 Fiddler 的 AutoResponder，代理api请求，指定请求链接与本地文件的映射关系，自定义响应的值，测试各种case，简直神器。

对于普通请求，响应为 JSON 文件，这样用用足够，一旦 request header 有个性化设置，单纯地返回 JSON 文件就不能满足需求了。

<!--more-->

## 自定义 response header

根据官方 reference，下面列出通过自定义响应文件的 response header，实现个性化请求本地代理的方法：

1. 发送api请求（如，在页面上点击按钮提交表单）
2. 在 Fiddler 窗口左侧请求列表中找到对应的记录，“右键”点击 ——> Save ——> Response ——> Entire Response ——> 另存为 filename.txt 文件
3. 用代码 editor 打开这个文件，删掉第一行 `HTTP/1.1 200 OK` 后面的 **with automaticheaders**
4. 在 `Content-Type` 这行下面添加自定义 header，与响应体内容保留1行间隔，比如：

    X-Resource-Count: 15

5. 回到 Fiddler 窗口，鼠标左键把请求记录从左侧窗口拖动到右侧 AutoResponder 表格里（自动生成一条新的 match rule）。然后选中这个规则，在表格下方规则配置输入框里，点击小箭头，选择“Find a file ...”。添加刚才编辑的文件。

### 拦截跨域请求

当请求对网路域名有要求时，尽管 Fiddler 返回了响应文件，但依然出现 js 报错，原因是 XMLHttpRequest 对象读取跨域响应失败。

解决办法是在保存的完整响应 filename.txt 文件里，追加 response header：

    Access-Control-Allow-Origin: *

### 要求 header 加 Authorization

在保存的完整响应 filename.txt 文件里，追加以下内容：

    Access-Control-Allow-Crendentials: true
    Access-Control-Allow-Headers: Access-Control-Allow-Headers, Authorization

### 读取响应体实际的 content-length

通常修改响应参数值后，实际响应内容的长度与响应头部 Content-length 设置的值不相等。

当实际长少于设定的值时，请求收到响应但页面上无反应（response.data不完整）；当实际长度超出设定的值时，ajax 请求永远不结束。

因此，我们需要对 Content-length 进行修正：

1. 在 Fiddler 窗口左侧请求列表中找到对应的记录，“左键”双击
2. 在右边出现的 tab 中，选择“Transformer”，可以看到 `Response Body: XXX bytes`。 XXX 即为实际响应内容的长度

## 抓取 iOS app 请求

1. 打开 Fiddler，Tools ——> Options ——> HTTPS，如图勾选：

<img src="{{ "/assets/images/fiddler_https_setting.png" | prepend: site.baseurl }}" alt="Configure Fiddler to decrypt HTTPS traffic">

在 Connections 一栏中可查看 Fiddler 端口号。

配置完后重启 Fiddler。

可在 PC 上打开浏览器输入谷歌地址，验证是否能抓取 HTTPS 请求。

2. 打开 iPhone，设置——>无线网（与PC必须链接相同的wifi），往下滑找到 HTTP 代理，选“手动”，填入PC的ip地址以及Fiddler的端口号。
3. 打开 Safari 浏览器，输入 HTTP 代理地址（PC的ip地址+Fiddler端口号），点"FiddlerRoot certificate"安装证书。
4. 使用完毕，记得关闭手机端的 HTTP 代理，以免 iPhone 上不了网。

https://blog.csdn.net/weixin_39465984/article/details/77186122

## Charles

Mac 上常用的抓包工具。

安装tips：

1. 官网下载最新版本
2. 本地安装-》打开软件-》窗口工具条 Help -》显示 Register Charles
3. 通过[在线破解工具](https://zzzmode.com/mytools/charles/)下载对应版本的 charles.jar 文件
4. 访达-》应用程序-》Charles右键-》显示包内容-》Contents-》Java，替换此目录下的 charles.jar 文件
5. 关闭 Charles，重新打开，窗口工具条 Help -》显示 Registered to <填写的注册人名>
6. 窗口工具条 Proxy-》macOS Proxy，开启权限

注意要严格按上面的顺序执行操作。（2021.5.25，作者更新了，只需要输入在线生成的register码即可。）

### 代理 Simulator 中的 https 请求

开发RN项目像代理请求到本地mock文件，Tools-》Map Local-》Enable Map Local-》Add，添加 Location（稍微有点烦，一般填写协议、host、path即可）。

配置完发现http请求可以正常代理，https 的请求就是不行。有人提示移动端测试时针对 https 请求，需要在手机端安装证书。谷歌找到一篇文章，跟着操作成功了。

[How to Set Up Charles Proxy for an iOS Simulator](https://www.detroitlabs.com/blog/2018/05/01/how-to-set-up-charles-proxy-for-an-ios-simulator/)

记录下：

1. 【Charles】菜单栏：Help -》SSL Proxying -》Install Charles Root Certificate in iOS Simulators.
2. 【Simulator】菜单栏：Device -》Restart
3. 【Charles】菜单栏：Proxy -》macOS Proxy
4. 【Charles】菜单栏：Proxy -》SSL Proxying Settings -》SSL Proxying 栏里勾选 Enable SSL Proxying -》Include 表格点 Add，在 Host 输入泛域名如 *.example.com
5. 重启 Charles
6. 确保 Charles 里点了 Start Recording，如果还是有问题，排查下 simulator 的证书是否最新

### localhost 抓包

Charles 会默认忽略掉 localhost 下的请求，macOS上的解决方法如下：

```shell
sudo vi /etc/hosts
```
在 hosts 文件加上: 127.0.0.1 localhost.charlesproxy.com

本地项目浏览地址 localhost:3000 改成 localhost.charlesproxy.com:3000 即可

### 抓取 https 请求

Charles 抓取 https 请求时默认显示 unknown。解决：

1. 【Charles】菜单栏：Help -》SSL Proxying-》Install Charles Root Certificate
2. 双击“Charles Proxy CA...” -》信任 -》使用此证书时：始终信任
3. 【Charles】菜单栏：Proxy -》macOS Proxy（确保勾选），Proxy Settings弹窗里采用默认设置
4. 【Charles】菜单栏：Proxy -》SSL Proxying Settings -》SSL Proxying 栏里勾选 Enable SSL Proxying -》Include 表格点 Add -》*.*（添加所有域名）-》点 OK
