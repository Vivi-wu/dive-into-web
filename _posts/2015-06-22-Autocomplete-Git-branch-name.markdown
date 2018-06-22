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

## 配置 Shell git 命令行 alias

1. 打开 Shell 配置文件

        vi ~/.bashrc

2. 进入 insert 模式，把下面内容复制到文件中（`y` 复制，`p` 在光标后黏贴，`P` 在光标前黏贴）

        alias gs='git status'
        alias gb='git branch'
        alias gc='git commit'
        alias ga='git add'
        alias gd='git diff'
        alias gplm='git pull origin master'
        alias gpom='git push origin master'
        alias gpld='git pull origin develop'
        alias gpod='git push origin develop'
        alias glogp='git log --pretty=format:"%C(yellow)%H %C(green)%ad%C(red)%d %Creset%s %C(blue)[%cn]" --date=short --graph'

3. 保存并退出文件。在当前 terminal 中重新加载该文件
