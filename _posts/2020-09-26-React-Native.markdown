---
title:  "React Native开发"
category: JavaScript
---

1.代码修改完，在simulator模拟器中 cmd + R 刷新，才能看到代码生效
2.模拟器里开启 Remote JS Debugging，在默认浏览器里新开tab（React Native Debugger），在开发者工具里就可以看到 console 输出了
3.使用 xcode 打开 ios 项目，等待扫描项目文件结束（时间长短与项目代码量有关）选择一个模拟器。在 RN 项目根目录下，新建 ios 文件夹，将 ios 项目代码移动到此文件夹中。启动 RN 项目，xcode 中点运行，将自动打开模拟器中的 app
4.使用 simulator 打包编译过一次 app 后，下次可直接打开 simulator。注意：记住打包时所选的系统版本和机型，再次打开 simulator -》File -》Open Simulator-》iOS 14.2 -》iPhone 8
