---
title:  "Practical Git commands"
category: Other
---
初次下载安装后常用的配置：

    git config --global user.name "Vivienne"
    git config --global user.email vivienne@example.com
    git config --global alias.st status

可在 `～/.gitconfig` 文件里查看 Git 全局配置。

或使用以下命令：

    git config --list

<!--more-->

## Setting up a repository

    git init

创建本地仓库（该命令通常是新项目中你会运行的第一个命令）

This command creates a .git subdirectory in the project root, which contains all of the necessary metadata for the repo, and makes it possible to start recording revisions of the project.
该命令在项目根目录里创建了 `.git` 子目录，使得它可以开始记录项目的版本。

注意：<span class="t-blue">Git will **not** create a master branch until you commit something. 运行此命令后，只有在你提交了一些东西，Git才会创建 master 分支。</span>

随便在目录里添加一个文件，git add them then git commit，此时才真正完成 master 分支的创建。

    git clone

This command copies an existing Git repository. 复制远端仓库到本地。

Cloning automatically creates a remote connection called **origin** pointing back to the original repository.

## Inspecting a repository

    git status

This command displays the state of the working directory and the staging area. List which files are staged, unstaged, and untracked. 该命令显示工作分支和临时集结区域的状态，哪些文件集结了，没有被集结，还是没有被追踪。

    git log
    git log -p <file>
    git log --pretty=oneline

显示当前分支的版本历史，含提交的 hash ID 和提交信息。

## Saving changes

    git diff <filename>

比较当前文件和集结区文件的诧异，也可以不指定文件名，直接运行 `git diff`，这样会显示所有改动文件的诧异。

    git add <filename>

Stage all changes in filename for the next commit. 添加指定文件到暂存区。

    git commit -a

把被修改、被删除的文件从暂存区提交到本地仓库，没有被 git 管理/追踪到的 new file 不会受影响。

    git commit -m "Commit message"

提交暂存区的改动到本地仓库，并附上说明信息。

### 使用指定编辑器来编写 commit 信息

Git 默认会调用你的环境变量 editor 定义的值作为文本编辑器，如果没有定义，则调用 **Vi** 来创建和编辑提交信息。

使用 `core.editor` 改变默认编辑器：

    git config --global core.editor emacs

这样输入 git commit --> enter，会自动打开 emacs 编辑器。

### 隐藏

把 changes 从工作分支上暂时隐藏，一个 stash 实际上就是一个 commit。

Stash 属于本地 Git 仓库，不会通过 push 推到远端。

    git stash

默认地，Git 不会隐藏 untracked 或 ignored 的文件。加 `-u` 可以隐藏 untracked 文件；加 `-a`（`--all`）可把 ignored 文件包含进来。最好给 stash 记录添加描述 `git stash save "message"`。

    git stash list

查看暂存列表

    git stash pop stash@{2}

默认地，re-apply 最新创建的 stash（即 stash@{0} 的记录），然后在 stash 列表中删除该记录。可通过指定 num 暂存操作序号。

    git stash apply

重新应用 changes 到工作分支，并**保留**在 stash 中，这样可以把 stashed 的 changes 应用于多个分支。

    git stash branch <branch_name>

为避免当前分支的 changes 与 stash 的改变在 pop 或 apply 时有冲突，通过上述把 stashed 改变应用到新分支。

    git stash show -p

对比 stash 和当前提交的不同。

    git stash clear

清空 stash 暂存记录。或者删除指定隐藏记录 `git stash drop stash@{1}`。

### Apply已存在的commit到其他分支

先创建一个干净的 开发分支，切换到此分支，运行如下命令，可把其他分支上已存在的 commit 应用到此分支上。

    git cherry-pick <commit>

## Rewriting history

    git commit --amend

This command provide a convenient way to fix up the most recent commit. It lets you combine staged changes with the previous commit instead of committing it as an entirely new snapshot. It can **also** be used to simply edit the previous commit message without changing its snapshot.

该指令提供了一种修补最新提交的简便方法。使你能够把新集结的改变（通过 `git add`）结合到前一个提交中，而不需要创建一个全新的快照来提交。也可以在不改变快照的情况下，单纯用来修改前一个提交的 message。

## Using Branches

通过在分支里开发功能，不仅使同时开发不同功能成为可能，而且保持主 master 分支不会遭到有问题代码的伤害。

    git branch

List all of the branches in your repository. 列出本地仓库中所有分支。

    git branch -r

To view your remote branches, remote branches are prefixed by the remote they belong to. 列出所有远端仓库的分支，分支名由他们所属的 remote 名开始，以区别于本地分支。
The current branch will be highlighted with an asterisk 星号(*). 当前所在分支前以星号标记。

    git branch <branch_name>

Create a new branch called branch_name. 创建一个新分支（停留在当前分支）。

    git checkout -b <new-branch>

Create and check out new-branch. 创建一个新分支，并切换到该分支。

    git branch -d <branch_name>

Delete the specified branch. This is a "safe" operation in that Git prevents you from deleting the branch if it has unmerged changes. 删除指定分支。如果该分支还没有 merge 到当前分支，则提示 error。

此时若要强制删除分支，使用 `-D` 作为参数。

    git push origin --delete <branch_name>

自动删除远端仓库工作分支（代替在 bitbucket 上手动删除）。**注意**：确保该分支代码已上线再删除。

    git checkout <existing-branch>

Check out the specified branch. This makes existing-branch the current branch, and updates the working directory to match. 跳转到已经创建的指定分支上，使得它成为当前工作分支。

    git branch -m <branch_new_name>

Rename the current branch to branch_new_name. 重命名当前分支。

## Syncing

    git remote -v

List the remote connections you have to other repositories. 列出所有与其他远端仓库的链接名，以及它们对应的 url。

不加 `-v` 参数，则只显示 remote name。

    git remote add myOrigin remote_repository_URL

**添加**一个名为 myOrigin 的新的与远端仓库的链接。

    git remote set-url origin remote_repository_URL

**修改**名为 origin 的与远端仓库的链接的 url 值。

    git fetch <remote>

Fetch all of the branches from the repository. This also downloads all of the required commits and files from the other repository. Since fetched content is represented as a remote branch, it has absolutely no effect on your local development work. This makes fetching a safe way to review commits before integrating them with your local repository.  把远端仓库的分支都取下来，取下来的内容也被视为远端分支，所以不会影响你本地开发工作。

与人合作同一个任务时，先运行 `git fetch`命令，把他的分支取下来，然后 `git checkout <分支名>`，在本地创建同名新分支，并跳转过去。

    git pull <remote>

Fetch the specified remote's copy of the **current** branch and immediately merge it into the local copy. This is the same as `git fetch <remote>` followed by `git merge origin/<current-branch>`.

取得指定的在远端的当前分支的副本，然后立刻把它合并到当前工作分支。

    git push <remote> <branch>

Push the specified branch to remote, along with all of the necessary commits and internal objects. This creates a local branch in the destination repository. To prevent you from overwriting commits, Git won't let you push when it results in a non-fast-forward merge in the destination repository. 把指定分支推到远端，通过该指令把本地仓库的提交传到远端仓库。该指令在目的仓库创建一个本地分支，以阻止你重写提交，在远端仓库造成冲突。

### 将一个分支里的更新集成到另一个分支上

有两种方法 `git rebase` 和 `git merge`。

使用到这两个命令的情况比如，你从主分支切出来做 feature，同时其他人提交了新的 commit，并且合并到了 master 分支，而你的功能需要依赖这些提交，

最简单的做法是使用 merge 命令：先更新本地的 master 分支（保持本地主分支最新），然后

    git merge master feature-branch
    // 或者
    git checkout feature-branch
    git merge master
    // 如果有冲突，解决冲突 → save file → `git add` → `git commit`

这样会在 feature 分支创建新的 merge 提交.

+ **优点**是保留/连接两个分支的历史，是 non-destructive 操作。
+ **缺点**是当 master 分支非常活跃时，你的 feature 分支会出现许多 merge 提交，使 feature 分支的提交历史看起来“非线性”，使其他开发人员比较难理解项目的历史。

另一种做法是使用 rebase 命令：把 feature 分支上新的 commit 都在 master 分支上重演一遍。

    git checkout feature
    git rebase master
    // 如果有冲突，解决冲突 → save file → `git add` → `git rebase --continue`

相比起建立新的提交，rebase 是**重写项目历史**（moves the entire feature branch to begin on the top of the master branch）

+ **优点**是使项目历史干净，避免了不必要的 merge commits，得到近乎完美的线性项目历史，可以很方便地使用 `git log` 和 `gitk` 查询各个提交。

    <img src="{{ "/assets/images/feature_to_master.png" | prepend: site.baseurl }}" alt="Rebase feature onto master">

+ **缺点**是如果没有遵从一定的规则（<span class="t-blue">never use git rebase on public branch</span>），重写项目历史会给 collaboration 工作流带来灾难性的问题。

    <img src="{{ "/assets/images/master_to_feature.png" | prepend: site.baseurl }}" alt="Rebase master onto feature">

## Undoing Changes

    git reset --hard <commit>

Move the current branch tip backward to commit and reset both the staging area and the working directory to match. 把当前分支返回到指定 hashID 的提交，暂存区、工作区的内容都会被修改到与提交点完全一致的状态。

    git revert <commit>

用一个新提交来消除一个历史提交所做的任何修改。通常用于修正最近的一个commit。

与 git reset 的区别是，产生新的commit，把 HEAD 向前移动。

在回滚这一操作上看，效果差不多。但是在日后继续merge以前的老版本时有区别。因为git revert是用一次逆向的commit“中和”之前的提交，因此日后合并老的branch时，导致这部分改变不会再次出现，减少冲突。但是git reset是之间把某些commit在某个branch上删除，因而和老的branch再次merge时，这些被回滚的commit应该还会被引入，产生很多冲突。

### 恢复删除的本地分支

用 `-d`  或 `-D` 删除的本地开发分支，可通过以下指令找到已删除分支最后一个 commit 的 hash 标记然后恢复。

    git reflog
    git checkout -b <branch> <SHA-1>

Reference logs, or "reflogs", 记录了分支和其他参考信息在本地仓库更新的时间。

## Git 文件状态

Git 文件状态分为 untracked 和 tracked.

untracked 文件是指新建的尚未被 git 管理起来的文件。

tracked 又分为三种状态：

+ 已修改（ modified ） 表示修改了但没有提交保存；
+ 已暂存（ staged ） 表示把已修改的文件放在下次提交时要保存的清单中；
+ 已提交（ committed ） 表示文件已被安全地保存在本地仓库中了。

### 视图化查看 Commits 插件

**Gitk** 一个基于 Tcl/Tk 的 Git 浏览器（For Unix/Linux），主要用于用户查看仓库的各类信息（更改信息、提交信息、版本信息、图形显示等）

### .gitignore 文件的使用

该文件用来告诉 Git 哪些文件（我们不想 Git to check in GitHub）需要忽略。三种方法：

1. 创建局部 .gitignore 文件：在项目 repository 下创建这个文件，Git 将使用它来决定忽略哪些文件和文件目录**在你做一个 commit 之前**。

    + **这个文件需要被提交到项目仓库里**，这样其他人复制项目时将分享同样的忽略规则。
    + 初学者都会遇到的一个问题：假设你有一个**已经 checked in** 的文件，你突然想要忽略它，<span class="t-blue">Git 将**不会** untrack 这个文件，只是因为你突然把它写进了 .gitignore 文件里。它已经在仓库里里，你 **必须** 先在仓库里删掉这个文件</span>。

          // 记得先 git add，git commit 你想要追踪的其他文件，然后执行：
          git rm -r --cached .
          git add .
          git commit -m "fixed tracking unwanted files"
          // 上述操作将从仓库里删掉所有文件，再按照新的 .gitignore 中的过滤规则，把当前目录所有的文件都加回来

2. 创建全局 .gitignore 文件：这样你电脑上每一个 Git 仓库都会执行文件里的规则。

       git config --global core.excludesfile ~/.gitignore_global

3. 在仓库里明确排除：如果你不想创建 .gitignore 文件与其他人分享，你可以为指定仓库创建规则，指出不需要提交的文件。（使用该技术用于你不希望其他人生成的本地产文件，比如你编辑器产生的文件。）

    使用文本编辑器，打开项目根目录下 **.git/info/exclude** 的文件，你在这里添加的任何规则，将只会在你本地仓库里被忽略。

## Git 代码提交准则

在使用 Git 时应该遵守一个基本原则——使提交记录尽可能简洁详细，看它就像读一本书。要达到这种效果，只需牢记几点：

+ 控制提交粒度；最好控制为一个小 feature 或者一个 bug fix，这样进行恢复等操作时能够将「误伤」减到最低
+ 填好提交信息；用一句简练的话写在第一行，然后空一行，略微详细地阐述该提交所增加或修改的地方
+ 调节推送频率；不要每提交一次就推送一次，多积攒几个提交后一次性推送（可以避免前一个提交后发现代码中还有小错误）。
+ 多衍合少合并。通过衍合进行提交的合并或者信息修改。
