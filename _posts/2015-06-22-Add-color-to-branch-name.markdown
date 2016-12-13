---
title:  "Highlight Git branch name (Mac)"
category: Other
---
参考[这里](http://martinfitzpatrick.name/article/add-git-branch-name-to-terminal-prompt-mac/)实践成功。效果如下：

<img src="{{ "/assets/images/GitBranchName_1.png" | prepend: site.baseurl }}" alt="Colorful Git branch name">

<!--more-->

1. 打开 terminal，创建一个名为 .bash_profile 的文件（名字随意）。

        touch ~/.bash_profile

2. 打开这个文件，图方便此处使用 vi 编辑器。

        vi ~/.bash_profile

3. 复制粘贴以下代码。

        # Git branch in prompt.
        parse_git_branch() {
            git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
        }
        export PS1="\u@\h \[\033[33m\]\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

4. 保存并退出文件。

        `Esc` + `:wq

5. 在当前 terminal 重新加载这个文件。

        source ~/.bash_profile

这样就可以实现上图的效果。

PS：通过 `\[\033[33m\]` 给紧跟其后的文本添加颜色。33 表示黄色，32 表示绿色，00 表示默认颜色。
