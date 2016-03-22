---
title:  "Add color to Git branch name (Mac)"
category: Other
---
参考[这里](http://martinfitzpatrick.name/article/add-git-branch-name-to-terminal-prompt-mac/)实践成功。效果如下：

<img src="{{ "/assets/images/GitBranchName_1.png" | prepend: site.baseurl }}" alt="Colorful Git branch name">

<!--more-->

1. 打开 terminal，创建一个名为 .bash_profile 的文件。

    touch ~/.bash_profile

2. 用代码 editor 打开这个文件，并把以下内容复制并粘贴到该文件里。图方便此处选用 linux vi

    <pre><code>
    # Git branch in prompt.
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }
    export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
    </code></pre>

    vi ~/.bash_profile

    command + v

    Esc + :wq

3. 重新加载这个文件

    source ~/.bash_profile

ok, 这样就可以实现上图的效果。如果想要改变颜色，可以参考原文里面对于参数的设置。
