---
title:  "Charles抓包"
category: Other
---
Charles 是 Mac 上常用的抓包工具。

安装tips：

1. 官网下载最新版本
2. 本地安装-》打开软件-》窗口工具条 Help -》显示 Register Charles
3. 通过[在线破解工具](https://zzzmode.com/mytools/charles/)下载对应版本的 charles.jar 文件
4. 访达-》应用程序-》Charles右键-》显示包内容-》Contents-》Java，替换此目录下的 charles.jar 文件
5. 关闭 Charles，重新打开，窗口工具条 Help -》显示 Registered to <填写的注册人名>
6. 窗口工具条 Proxy-》macOS Proxy，开启权限

<!--more-->

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

Some systems are hard coded to not use proxies for localhost traffic.官方文档说一些系统硬编码默认对localhost不使用proxy

因此 localhost 下的请求不会出现在 Charles 里，macOS上的解决方法如下：

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

### iOS app https 抓包

1. 【Charles】菜单栏：Help -》Local IP Address
2. 【iPhone】设置-》无线局域网-》选择与电脑相同的 wifi，点问号图标-》拉到下方，点击“配置代理”-》手动-》输入 ip，端口写 8888
3. 【Charles】菜单栏：Help -》SSL Proxying-》Install Charles Root Certificate on a Mobile Device or Remote Browser
4. Charles 弹出框里点 ok
5. 【iPhone】浏览器地址栏输入 chls.pro/ssl -》完成证书下载
6. 【iPhone】通用-》VPN与设备管理-》点击刚下载的配置描述文件-》安装-》回到“关于本机”-》证书信任设置-》在“针对根证书启用完全信任”里，开启信任

完成上述操作，无需重启Charles，已经可以抓取https请求了。


