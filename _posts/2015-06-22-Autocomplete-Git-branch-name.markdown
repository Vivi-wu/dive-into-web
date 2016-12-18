---
title:  "Autocomplete Git branch name (on Mac) in Bash"
category: Other
---
Mac 上用 `Tab` 键不能自动补全 Git 分支名称，每次都要手动输入或者粘贴，很麻烦😔

参考[这里](http://code-worrier.com/blog/autocomplete-git/)实践成功。

<!--more-->

1. 在 Git [源代码包](https://github.com/git/git/blob/master/contrib/completion/git-completion.bash)里有个 git-completion.bash 文件，Terminal 里运行以下代码，实现下载并在本地 home 目录创建同名文件：

        curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

2. 在 ~/.bash_profile 文件里复制粘贴以下代码：

        # Git autocomplete branch name
        if [ -f ~/.git-completion.bash ]; then
          . ~/.git-completion.bash
        fi

4. 保存并退出文件。 `Esc` + `:wq`

5. 在当前 terminal 重新加载这个文件。

        source ~/.bash_profile

这样，就可以像在 ubuntu 一样愉快地提交代码了✌️
