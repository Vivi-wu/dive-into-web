---
title:  "Practical Git commands"
category: Other
---
## Setting up a repository

`git init`

该命令通常是新项目中你会运行的第一个命令。

This command creates a .git subdirectory in the project root, which contains all of the necessary metadata for the repo, and makes it possible to start recording revisions of the project.
该命令在项目根目录里创建了这个子目录。使得它可以开始记录项目的版本。

<span style="background-color:skyblue;">注意：Git will **not** create a master branch until you commit something. 运行此命令后，只有在你提交了一些东西，Git才会创建 master 分支。</span>

Add one or more files to your directory, and git add them to prepare a commit. Then git commit to create your initial commit and master branch. 随便在目录里添加一个文件，添加并提交，此时才真正完成master分支的创建。

<!--more-->

`git clone`

This command copies an existing Git repository. 如果项目已经有人开始做，此时需要把远端的 repository 复制到本地。Cloning automatically creates a remote connection called **origin** pointing back to the original repository.

## Inspecting a repository

`git status`

This command displays the state of the working directory and the staging area. List which files are staged, unstaged, and untracked. 该命令显示工作分支和临时集结区域的状态，哪些文件集结了，没有被集结，还是没有被追踪。

## Saving changes

`git diff <filename>` 

比较当前文件和集结区文件的诧异，也可以不指定文件名，直接运行 `git diff`，这样会显示所有改动文件的诧异。

`git add <filename>`

Stage all changes in filename for the next commit. 为下一个提交/托付集结所有 filename 中的改变。

`git commit -m "Commit message"`

提交改动，并附上相关信息 message。

### 使用emacs来编写 git commit 注释

Git 默认会调用你的环境变量 editor 定义的值作为文本编辑器，如果没有定义，则调用 **Vi** 来创建和编辑提交以及标签信息， 可以使用 `core.editor` 改变默认编辑器：

    git config --global core.editor emacs

这样 git commit 会自动打开 emacs 编辑器，让你来编辑提交信息。

`git stash`

当你正在一个分支做新功能的时候，项目急需你在另一个分支里修改 bug，使用该指令把你当前做的工作（还没有达到 commit 的程度）保存到一个安全的地方，然后等你在其他分支完成任务回来后，再把他们取出来继续做。

`git stash list`

查看暂存列表

`git stash pop stash@{num}`

num 是你希望恢复的暂存操作序号，通过 `git stash list` 列表指令可以查看。缺省 stash@{num} 则恢复 stash 队列中 stash@{0} 的记录。

`git stash clear`

清空 stash 暂存记录。

## Rewriting history

`git commit --amend`

This command provide a convenient way to fix up the most recent commit. It lets you combine staged changes with the previous commit instead of committing it as an entirely new snapshot. It can **also** be used to simply edit the previous commit message without changing its snapshot.

该指令提供了一种修补最新提交的简便方法。使你能够把新集结的改变（通过 `git add`）结合到前一个提交中，而不需要创建一个全新的快照来提交。也可以在不改变快照的情况下，单纯用来修改前一个提交的 message。

`git rebase`

一种好的工作方式是，在把新功能的 commit 推到远端之前，检查一下主分支有没有更新，有的话，把更新合并到这个提交里，并在本地把冲突解决掉，这样别人在远端 code review 时，省掉了许多麻烦。

假设已经运行 `git pull <remote> <本地主分支>`， git checkout `<新功能分支>`，然后分两种情况：

1.新功能还没有推到远端

`git rebase <本地主分支>`

如果有冲突，解决冲突 → save file → `git add` → `git rebase --continue`

2.新功能分支已经推到远端

`git merge <本地主分支>`

如果有冲突，解决冲突 → save file → `git add` → `git commit`

两者的区别就是，前者并不创建新的提交。

## Using Branches

By developing features in branches, it's not only possible to work on both of them in parallel, but it also keeps the main master branch free from questionable code. 通过在分支里开发功能，不仅使同时开发不同功能成为可能，而且保持主 master 分支不会遭到有问题代码的伤害。

`git branch`

List all of the branches in your repository. 列出仓库中所有分支。

The current branch will be highlighted with an asterisk 星号(*). 当前所在分支前以星号标记。

`git branch <branch_name>`

Create a new branch called branch_name. 以任务名称创建一个新分支。

`git branch -d <branch_name>`

Delete the specified branch. This is a "safe" operation in that Git prevents you from deleting the branch if it has unmerged changes.

删除指定分支，如果该分支还没有 merge 到当前分支，则提示 error。此时若要强制删除分支，使用 `-D` 作为参数。

`git branch -m <branch_new_name>`

Rename the current branch to branch_new_name. 当前分支重命名。

`git branch -r`

To view your remote branches, remote branches are prefixed by the remote they belong to.查看你在远端的分支，远端分支由他们所属的 remote 名开始，以区别于本地分支。

`git checkout <existing-branch>`

Check out the specified branch, which should have already been created with git branch. This makes existing-branch the current branch, and updates the working directory to match. 跳转到已经通过 `git branch` 创建的指定分支上，使得它成为当前工作分支。

`git checkout -b <new-branch>`

Create and check out new-branch. 加 `-b` 选项，告诉 Git 先创建，再跳转。

## Syncing

`git remote -v`

List the remote connections you have to other repositories. 列出所有你与其他仓库的远端链接，以及它们对应的 url。

不加 `-v` 参数，则只显示 remote name。

`git remote add myOrigin remote_repository_URL`

添加一个名为 myOrigin 的新的，与远端仓库的链接。

`git remote set-url origin remote_repository_URL`

修改名为 origin 与远端的链接的 url 值。

`git fetch <remote>`

Fetch all of the branches from the repository. This also downloads all of the required commits and files from the other repository. Since fetched content is represented as a remote branch, it has absolutely no effect on your local development work. This makes fetching a safe way to review commits before integrating them with your local repository.

把远端仓库的分支都取下来，取下来的内容也被视为远端分支，所以不会影响你本地开发工作。与人合作同一个任务时，先运行 `git fetch`命令，把他的分支取下来，然后 `git checkout <分支名>`，在本地创建同名新分支，并跳转过去。

`git pull <remote>`

Fetch the specified remote's copy of the **current** branch and immediately merge it into the local copy. This is the same as `git fetch <remote>` followed by `git merge origin/<current-branch>`.

取得指定的在远端的当前分支的副本，然后立刻把它合并到当前副本。

`git push <remote> <branch>`

Push the specified branch to remote, along with all of the necessary commits and internal objects. This creates a local branch in the destination repository. To prevent you from overwriting commits, Git won't let you push when it results in a non-fast-forward merge in the destination repository.

把指定分支推到远端，通过该指令把本地仓库的提交传到远端仓库。该指令在目的仓库创建一个本地分支，以阻止你重写提交，在远端仓库造成冲突。

## Undoing Changes

`git reset --hard <commit>`

Move the current branch tip backward to commit and reset both the staging area and the working directory to match. 把当前分支返回到指定 hashID 的提交，重置暂存/集结区和工作目录。

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
    + 初学者都会遇到的一个问题：假设你有一个**已经 checked in** 的文件，你突然想要忽略它，<span class="blue-text">Git 将**不会** untrack 这个文件，只是因为你突然把它写进了 .gitignore 文件里。它已经在仓库里里，你 **必须** 先在仓库里删掉这个文件</span>。

        // 记得先 git add，git commit 你想要追踪的其他文件，然后执行：
        git rm -r -cached .
        git add .
        git commit -m "fixed tracking unwanted files"
        // 上述操作将从仓库里删掉所有文件，再按照新的 .gitignore 中的规则，把需要的文件都加回来

2. 创建全局 .gitignore 文件：这样你电脑上每一个 Git 仓库都会执行文件里的规则。

    git config --global core.excludesfile ~/.gitignore_global

3. 在仓库里明确排除：如果你不想创建 .gitignore 文件与其他人分享，你可以为指定仓库创建规则，指出不需要提交的文件。（使用该技术用于你不希望其他人生成的本地产文件，比如你编辑器产生的文件。）

    使用文本编辑器，打开项目根目录下 **.git/info/exclude** 的文件，你在这里添加的任何规则，将只会在你本地仓库里被忽略。
