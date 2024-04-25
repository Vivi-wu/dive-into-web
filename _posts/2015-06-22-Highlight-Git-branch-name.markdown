---
title:  "Highlight Git branch name (on Mac)"
category: Other
---
参考[这里](http://martinfitzpatrick.name/article/add-git-branch-name-to-terminal-prompt-mac/)实践成功。效果如下：

<img src="{{ "/assets/images/GitBranchName_1.png" | prepend: site.baseurl }}" alt="Colorful Git branch name">

<!--more-->

1. 打开 terminal，创建一个名为 .bash_profile 的文件。

        touch ~/.bash_profile

2. 打开这个文件，图方便此处使用 vi 编辑器。

        vi ~/.bash_profile

3. 按快捷键 `i` 进入 insert 编辑模式，复制粘贴以下代码。

        # Git branch in prompt
        parse_git_branch() {
            git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
        }
        export PS1="\u@\h \[\033[33m\]\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

4. 保存并退出文件。 `Esc` + `:wq`

5. 在当前 terminal 重新加载这个文件。

        source ~/.bash_profile

这样就可以实现上图的效果。

PS：通过 `\[\033[33m\]` 给紧跟其后的文本添加颜色。33 表示黄色，32 表示绿色，00 表示默认颜色。

## 新版Mac OS (10.15+ incl. Big Sur 11.0)

默认终端为 zsh，需要重新配置。参考[这里](https://stackoverflow.com/a/58375763)

原理一样，.bash_profile 文件改成 .zsh_profile 文件，代码改成：

```shell
# Git branch in prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
COLOR_DEF='%f'
COLOR_USR='%F{243}'
COLOR_DIR='%F{3}'
COLOR_GIT='%F{39}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n@%M ${COLOR_DIR}%1d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '
```

颜色不喜欢可以看[这里的88/256 Colors-》Foreground（text）](https://misc.flogisoft.com/bash/tip_colors_and_formatting)

关于一些特殊符号的解释，如: %d，看这里[Prompt Expansion](http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html)

关于高亮当前目录`%d`，默认是the whole path。我觉得太长了，仅展示当前工作路径最后一个component（项目文件名）即可，通过在百分号和字母d之间加了一个数字1实现。

## Vim/Vi 编辑器

Vim 的一个核心概念是模态编辑，它有不同的模式，包括：

+ 默认为 normal 模式，用于浏览文件，在文件之间跳转
+ 按 `i` 键进入 insert 模式，用于编辑文件，输入文本
+ 按 `v` 键进入 visual 模式，用于选择文本块；`shift + v` 进入 visual line 模式，用于选择多行；`ctrl + v` 进入 visual block 模式，用于选择矩形块
+ 按 `r` 键进入 replace 模式，用于替换文本
+ 按 `:` 键进入 command 模式，
+ 按 `esc` 退出当前模式，回到 normal 模式

### 常用命令

```sh
:q  # 退出当前文件，或关闭当前窗口
:qa # 退出所有窗口，退出 Vim
:w  # 保存当前文件
:wq # 保存并退出当前文件
:sp # 水平分割窗口，在新窗口里打开当前文件
:vsp # 垂直分割窗口，在新窗口里打开当前文件
```

### normal 模式下

+ 按 `w`，移动鼠标从左到右到下一单词的首字母，按 `e`，移动鼠标到下一个单词的尾字母。
+ 按 `b`，移动鼠标从右到左（反向）到上一单词的首字母。
+ 按 `0`，移动鼠标到行首，按 `$`，移动鼠标到行尾。
+ `ctrl + u` 向上翻页，`ctrl + d` 向下翻页。
+ 查找：`fo` 跳到下一个 `o` 字符，`F` 反向查找（`shift + f + o`，跳到上一个 o 字符）。一个变形： `to` 跳到下一个 o 字符之前。
+ 按 `/Vivi`，查找 `Vivi` 字符串，并将光标移动到第一个匹配处。
+ 按 `o`，在当前行之下打开新行并进入 insert 模式。按 `O`，在当前行之上打开新行并进入 insert 模式。
+ 按 `dw`，删除光标后的单词；按 `de`，删除光标后的内容到词尾。
+ 按 `dd`，删除当前行；按 `cc`，删除当前行并进入 insert 模式。
+ 按 `ce`，删除光标后的内容到词尾，并进入 insert 模式。
+ 按 `x`，删除光标处的字符。
+ 按 `u`，撤销上一步操作。
+ `ctrl + r`，重做上一步操作。
+ 按 `yy`，复制当前行。
+ 按 `p`，粘贴到下一行。按 `shift + p`，粘贴到上一行。
+ 加数字：按 `5 + ↑`，向上移动 5 行，按 `5 + ↓`，向下移动 5 行。
+ 加修饰符：按 `di<`，删除 `<` 和 `>` 之间的内容。类似地，`di[`、`di(`。
+ 加修饰符：按 `da<`，删除 `<` 和 `>` 之间的内容，包括 `<` 和 `>`。
+ 按 `.`，重复上一次命令。适用于将某个编辑所含的输入内容复制到光标处。

### visual 模式下

复制并黏贴一行：

1. 左右上线，移动方向键选择内容，输入 `y` 复制，自动返回 normal 模式
2. 光标移到要粘贴的地方，输入大写 `P`，插入到光标之后

移动光标：

【Insert模式】Shift + 方向键

