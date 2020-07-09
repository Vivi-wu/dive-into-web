---
title:  "Chrome Extension开发"
category: JavaScript
---
扩展程序/插件可以改变用户看到的网页内容，扩展、交互或者改变浏览器自身的行为。

插件的组件就是由web技术开发的：html、css、js。组件可以包含：

+ background 脚本，包含对于插件重要的浏览器 event handler
+ UI元素，应该目的明确、小巧
+ content 脚本，读写当前已加载的页面内容
+ options 页面，允许用户自定义插件（如选择需要的功能）
+ 各种 logic 业务逻辑文件

除了可以直接使用同网页一样的 api，扩展程序也有专门的 api。大部分 Chrome 插件 api 都是异步的。	

页面直接通信：页面通过 `chrome.extension` 方法获取其他页面的 reference，就可以调其他页面的方法，操作DOM。此外还可以通过 message passing 通信。

<!--more-->

注意：默认情况下，扩展程序不在浏览器隐身窗口运行！

那如果页面运行在隐身窗口，扩展程序需要遵守规则，不保存数据。但是可以保存 setting 偏好。

```js
function saveTabData(tab) {
  if (tab.incognito) {
  	// 隐身模式下不做处理
    return;
  } else {
    chrome.storage.local.set({data: tab.url});
  }
}
```

扩展程序的html文件可以通过绝对路径访问：chrome-extension://${ID}/options.html

其中 ID 显示在扩展程序页的插件卡片上。

### demo

[Getting Started Tutorial入门教程](https://developer.chrome.com/extensions/getstarted)

几个点:
+ 在项目目录下创建一个 manifest.json 文件，一切开始
+ 插件管理页：[chrome://extensions](chrome://extensions)，右上角开启 developer mode，工具栏选择“加载已解压扩展程序”，指向项目目录
+ 每次修改 manifest.json 文件，需要在扩展程序页的插件卡片上，点击“reload”；点击“查看视图”的背景页，可以打开devtools
+ 使用 storage api可以让多个组件获取和更新一个value
+ 使用到的 chrome api 都需要注册到 manifest 文件的 permissions 中
+ 在 page_action 的 default_icon 字段设置**浏览器工具条**中该插件的图标，而扩展程序管理页卡片上的图标，则通 icon 字段设置
+ 声明了 page_action，还需要在 logic 文件里告诉浏览器用户何时与指定页面交互。
+ browser_action 与 page_action 的区别是：前者只要安装则在任何 tab 打开的页面都可用（对应图标是彩色的），而后者只在指定页面可用（其余页面图标是置灰的）
+ options_page 字段配置的页面通过点击扩展程序管理页卡片上的 details 进入扩展程序详情，点击扩展程序选项，可在新tab加载配置的页面。
+ activeTab 权限运行插件临时获取 tabs api
