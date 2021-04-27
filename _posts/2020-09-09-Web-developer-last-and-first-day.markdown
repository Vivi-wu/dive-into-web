---
title:  "互联网开发last day和first day"
category: Other
---
今天工作使用了3年半的联想笔记本电脑电源坏了，跟IT申请换了MacBook Air。在公司开发的产品主要面向Windows用户，加上在网易时也是win10开发环境，因此一直使用window系统进行开发和处理工作。

记录一些tips，总会用上的。

<!--more-->

## Last day

平时就养成将工作资料、笔记，放在个人名下的文件目录里。工作邮件区分周报、行政。特殊内容的邮件加星标。

### 代码

如果以后仍可以访问代码仓库，只需将本地开发分支全部 push 到远端仓库；反之，先删除所有 node_modules 文件夹，再将项目代码 copy 到移动硬盘里。

### Chrome书签

如果以后仍通过相同的 Gmail 登录谷歌账号，则只需开启【同步功能】，具体操作看提示。退出账号，删除数据。

### 企业微信文件、图片

找到企业微信本地缓存文件夹，如：WXWork，将整个目录 copy 到移动硬盘

### 邮件

需要备份收藏的邮件转发至私人邮箱。

## First day

## 软件

下载并安装 Chrome、Visual Studio Code、Node.js

Mac新电脑安装 brew

### VS code

在扩展里安装常用扩展插件：ESLint、Git Graph、GitLens、Simple React Snippets、vscode-fileheader

编辑器显示：

- 自动换行 Editor: Word Wrap -》On、Diff Editor: Word Wrap-》On

格式化相关：

- 勾选 Editor: Format On Save、Editor: Format On Type、Files: Trim Trailing Whitespace
- 仅格式化修改的部分 Editor: Format On Save Mode-》modifications
- 取消勾选 Diff Editor: Ignore Trim Whitespace
- 修改缩进为2个空格：Editor: Tab Size -》2

使设置生效，重启编辑器：Code-》Quit Visual Studio Code

给文件头部自动添加注释：Code-》Preferences-〉Settings-》Extensions-〉File header Configuration，将 Author 和 Last modified by 改成自己的邮箱。默认快捷键：control+alt+i

### SSH Key

公司代码库设置里找到添加 SSH Key 的地方，根据提示在本地生成新的 public SSH Key。命名规则：电脑+公司邮箱。

登陆Github个人账户，Settings-》SSH keys根据提示，生成并添加工作电脑的SSH Keys。

### Bash 终端设置

Mac下：终端-》偏好设置-》描述文件-》Pro，左下角点“默认”（相当于保存）。右侧字体选：Menlo Regular 12磅。重新打开终端可生效。

通过 Git 下载本博客。

Git 指令相关，参考博文：

- 高亮分支名，Highlight Git branch name (on Mac)
- 自动补全及配置 alias，Autocomplete Git branch name (on Mac) in Bash
- 设置全局 Git 用户名、邮箱，Practical Git commands

建议：所有终端配置都保存在同一个 bash 文件里。

### Chrome书签

使用相同的 Gmail 登录谷歌账号，打开同步。一键 get 全部收藏页面、账号密码及历史访问记录。

### Sublime Text

shift+command+p，唤起 Package Control，安装完毕后，选择 Package Control：Install Package，等待 loading 可安装包结束，在输入框里安装 Git、TrailingSpaces 插件。

常用扩展插件：Git、MarkdownPreview、TrailingSpaces

## 一些感想

作为程序员，在一家公司所创造的价值到底是什么？回首这几年开发了不少项目（web app/网页），也经历了一些人的工作交接。

看起来做了很多事情，写了很多代码，实际上这些数码编写的东西基本就成为历史了。一些项目后续如果死掉，哪怕是基于特定js库的通用组件，一旦技术栈变更，相应的代码实际上就成了垃圾，再也无人问津。

真正可移植/值得交接的东西才是你的核心竞争力，比如编程思想，业务组件设计，开发经验。
