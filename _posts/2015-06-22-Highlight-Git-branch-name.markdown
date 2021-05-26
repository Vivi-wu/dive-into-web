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
