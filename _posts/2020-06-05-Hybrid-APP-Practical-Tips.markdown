---
title:  "Hybrid APP 开发实践"
category: JavaScript
---

## 状态栏

背景为透明，字体默认黑色。可通过传参数，让native设置字体颜色。

H5页面如果设置全屏，则需要让头部组件预留出状态栏高度的空隙，

## 页面跳转

浏览器里通过链接打开app或跳转至应用商店app下载页。直接打开deeplink已安装app的打开app，未安装的会报错。

如果是打开 Adjust 链接，则会通过跳转到 Adjust 页面唤起app或跳转至应用商店。Adjust 会收集数据，一般产品想统计多少未安装app的打开链接。