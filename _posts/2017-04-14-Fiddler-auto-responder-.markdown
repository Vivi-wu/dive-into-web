---
title:  "使用 Telerik Fiddler 让本地开发飞起"
category: Other
---
Telerik Fiddler 主要用在 Windows 系统下，官方也有 mac os 版，但是貌似不好用，下载下来的还是exe

之前wy同事推荐，第一次知道前后端分离本地开发还有这种操作。

最常用的就是 Fiddler 的 AutoResponder，代理api请求，指定请求链接与本地文件的映射关系，自定义响应的值，测试各种case，简直神器。

对于普通请求，响应为 JSON 文件，这样用用足够，一旦 request header 有个性化设置，单纯地返回 JSON 文件就不能满足需求了。

## 自定义 response header


