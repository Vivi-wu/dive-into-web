---
title:  "命令行工具及Shell语句tips"
category: Other
---
在Windows系统 git-bash 终端命令行工具里，实用Windows资源管理器打开当前文件夹/目录

```bash
start .
```

[一个比较全的windows用户命令行汇总](http://johnatten.com/2012/09/08/basic-git-command-line-reference-for-windows-users/)

## 执行 shell 文件

使用 *.sh 文件，在命令行终端里运行 ./*.sh

Mac 下提示“permission denied”，解决：

[在 Mac 上的“终端”中使文件可执行](https://support.apple.com/zh-cn/guide/terminal/apdd100908f-06b3-4e63-8a87-32e71241bab4/mac)

```sh
chmod 755 文件名.sh
```

<!--more-->

## 输出日期时间

```sh
echo "今天是`date`"

TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

echo "自定义日期时间输出 $TIMESTAMP"
```

## 从 iconfont.cn 下载字体文件到当前目录下

```sh
curl -v --cookie "cna=mTNtFEok3SkCAdy/utIDGBNM;EGG_SESS_ICONFONT=U8AXvqwdm-42-umGXGwgKq_Emj2wuVCkA87TjZ3dn6xm2T4whio3sIKoy4kjkuBSusLMQ-0MhcjWBE1FwhfGmHa4MwEHgW7pCbfU0Hhk3uY-kuveEaSWqxlut4MQVPKIeSSVMupL3DmRr12ReN1T2N42hwjutmR7MXZUdpP2MKhd3KnGyvF-m5v25bLDdQ4_6v4TEkYINuWDnZUYFvmlUU-zLA2yUIJnAXT1l7IE6mcwan95FbClOMPyq5OP_nLNdLq-J16YgAVR8l_XWPWku2xnCXnPkd2OVoNrV95rv73IlDKsd_jGq1DwbQh1GHEAFg-J13jkl9xYuXnDON2qtwxPaBoMdLeDStDkAQT1ly_MA9-ylpzcuaBBc8SBqIrtrsFn7mjsYel-sv8NGpTKIqMp47AoAkoBGaUxHrycjQM-9OnQJQK7ADr3sXbwGmeNQc3c1GH-hFm3cJS4UYAvf5nOBVJUf2Ap-GpV7uV8JUAIPM45cQThrxB1QTzpDhHu1Ngd8xuwG3Y6jKQawTJMY4H817sRld6_0sW4pcEDleYsp66BMA2eW61q0nfu2j2oCsVl4UAztS9xo0ePXrirAITDPm_xR9iu-pjGVb-ewjhyoWpjEK2YT0vVE6hBUbtiCgwKCn99mik6CCUt5-ZXc3C_wAitmL1AWZ5FB3ASWkBDQpAROHMsXpIb-Ryn_iCmcmh54XopgVw1NuB7Z0P0136Ur9NUGnYkgZ6RRl7yAECTMVr8kUFmPteLcr3-hgbvzTeD1IqiBIUhHnLtG0dJDF0bEErb5rgrj5GwDPPU2k6QwzirhH9hnqxIHOLYDc35or5svYSdRhaMtH7ScBvOuRsOAYQsXI1SzRNcnwPI22tmzS4k3twc5CJZety0bVln5JsnWeUNJ1chcJ8kaWCssuLMkG538LgwrOF8eUhpOGNELgipd28XNcKMd3VCAjKRdz301BNqCfilPPnAJiRITJmQ0EFnQS90TZMvmuaXrMWXirfIYa5MxdrYrO_kOcXWGkFJHvU1nTHjptxmwUGGWjr-47eE5-d5P0l_OcsG5k5wEX9bASRI8R7-MDxwpen1b0nYSDCpjERlZ-HoJijpsw==;trace=AQAAAKHxKXcbeQoAg19EZSNDhCJwSspr;ctoken=AkUxJUxFFHzd3gQ7fGGvWiSY;u=835843;u.sig=m5P7qa1Gc4S42xqNJtLhyDkgl2gyhmUJgrUEdkVhFAg;isg=BIGB_fAau04Xqdd6y9_noZfKkM2brvWg4aPV3OPWJAiXyqGcK_zfcK7LqD6MQo3Y" https://www.iconfont.cn/api/project/download.zip\?spm\=a313x.7781069.1998910419.d7543c303\&pid\=1969599\&ctoken\=AkUxJUxFFHzd3gQ7fGGvWiSY --output download.zip
```

### 解压文件

```sh
unzip download.zip
```

### 删除以指定字符开头的文件

```sh
rm -rf icon*
```

### copy 文件到指定目标并 rename

```sh
cp font_*/*.js ../public/font/iconfont_v1.js
```

### curl 常用参数

不设置请求method则默认为 get。

```sh
curl -H 'custom-header:值' -b ‘_ga=cookie1;_gid=cookie2’ http://www.example.com
```

设置请求头，并带上 cookie

### 查找 Node 进程 pid

虽然可以通过代码输出 `console.log(process.pid)`, 但是以下可以不侵入代码，通过端口号在终端里定位进程。

```sh
lsof -i:3011
```

### 监控进程内存使用情况

Mac终端：

```sh
top -pid 7272
```