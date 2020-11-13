---
title:  "Markdown, VS Code Tips"
category: Other
---
整理 .markdown 常用语法。

## Git bash

1. 每次在终端里执行与远端交互的 git 命令都提示输入passphrase？

    + 解法一：把 remote url 从ssh改为https
    + 解法二：在generate SSH key 的时候，当终端提示设置 password 跳过就行（因为密码不是必须的）

2. `cat *.txt` Linux 命令：连接文件并将内容打印到标准输出设备上

## Markdown

### 在新 tab 页打开链接

`[]` 里是链接文案，`()` 里是链接地址，`{}` 里是元素属性。

```
[这个插件](https://github.com/bfred-it/iphone-inline-video){:target="_blank"}
```

<!--more-->

## Visual Studio Code

### 快捷键

1. 文件

        Ctrl + P            打开文件
        Ctrl + Shift + N    打开新窗口
        Ctrl + Shift + W    关闭窗口
        Ctrl + K S          保存所有
        Ctrl + K Ctrl + W   关闭所有已打开文件
        Ctrl + K R          在系统资源管理器中显示当前文件

2. 导航

        Ctrl + G             跳转至第几行
        Ctrl + Shift + O     跳转至状态、变量
        Ctrl + Tab
        Alt + ←/→            toggle 编辑组 tab 页
        Ctrl + K Ctrl + ←/→  在编辑组之间移动光标并 focus
        Fn + Shift + F12     显示全部函数引用，在当前文件
        Fn + Home/End        移动光标到行首/尾
        Fn + Ctrl + Home/End 移动光标到文件头/尾
        Ctrl + ↑/↓           滚动浏览，以行为step

3. 显示

        Ctrl + \            编辑器分组
        Ctrl + B            侧边栏 toggle 显示
        Ctrl + Shift + E    打开vscode资源管理器
        Ctrl + K V          在旁边编辑组，打开 markdown 文件预览
        Ctrl + Shift + [    折叠代码块
        Ctrl + Shift + ]    打开代码块

4. 编辑
    
        Ctrl + Shift + L            选中所有“当前选择”的匹配项
        Ctrl + F                    当前文件搜索
        Ctrl + Shift + F            全局搜索
        Fn + F3 / Fn + Shift + F3   查找前/后一个匹配项
        Ctrl + D                    选中下一个匹配项
        Alt + Enter                 全选匹配项，在当前文件搜索后
        Alt + Click                 插入光标
        Ctrl + Alt + ↑/↓            在上/下一行插入光给i他标
        Ctrl + H                    当前文件中替换
        Ctrl + Shift + H            全局替换
        Ctrl + /                    单行注释
        Ctrl + Shift + /            多行注释（自定义的快捷键）
        Ctrl + Enter                在下方插入一行
        Ctrl + Shift + Enter        在上方插入一行
        Ctrl + X                    剪切行（删除并将内容保留在剪贴板）
        Ctrl + Shift + K            删除行
        Ctrl + C                    复制行
        Alt + ↑/↓                   移动行
 
### 在指定目录下的文件中查找

在订单列表目录下的 .vue 文件里查找

    **/sales-order/**/*.vue

### 跳转至函数定义处

Windows 系统按 `Fn + F12`

### Terminal里在当前目录打开 VS Code

    code .

### 切换分支

编辑器左下角显示当前所在的 Git 分支，点击分支名称，窗口上方出现下拉自动补全输入框，实现切换分支。

### 格式化HTML

全选代码片段，鼠标右键“格式化选定的内容”

### 文件比较

在 vscode 里打开需要对比的两个文件。

1. 左侧工具栏 Explorer -》Open Editors
2. 右键点击文件 A，弹出菜单里选择 Select for Compare
3. 右键点击另一文件 B，弹出菜单里选择 Compare with Selected
