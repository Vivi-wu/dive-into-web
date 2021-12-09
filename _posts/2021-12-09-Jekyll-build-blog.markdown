---
title:  "Jekyll build blog"
category: Other
---

gh-pages从今年开始推上去的博文都没有自动deploy，github 提示 Unable to build page. Please try again later。

排查：先本地安装 Jekyll 构建一下，看是否是代码问题引起的。

## 升级 Ruby

Mac OS现在内置 ruby，查版本：
ruby -v

```shell
ruby 2.6.3p62 (2019-04-16 revision 67580) [universal.x86_64-darwin19]
```

升级：
brew install ruby

这个过程有点长。安装结束后提示：

```shell
==> ruby
By default, binaries installed by gem will be placed into:
  /usr/local/lib/ruby/gems/3.0.0/bin

You may want to add this to your PATH.

ruby is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have ruby first in your PATH, run:
  echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc

For compilers to find ruby you may need to set:
  export LDFLAGS="-L/usr/local/opt/ruby/lib"
  export CPPFLAGS="-I/usr/local/opt/ruby/include"
```

大概意思是说因为Mac OS已经装了一个版本的 ruby，使用 brew 安装的 ruby 放到了别的目录。运行 ruby -v 可以看到显示还是刚才的版本。

按照提示在shell里运行

```shell
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
```

重新加载 .zshrc 文件 `source ~/.zshrc`。此时查看版本，显示的是新版了

```shell
ruby 3.0.3p157 (2021-11-24 revision 3fb7d2cadc) [x86_64-darwin19]
```

## 安装 Jekyll

官网：https://jekyllrb.com/

运行：
gem install bundler jekyll

报错：

```shell
ERROR:  While executing gem ... (Gem::FilePermissionError)
    You don't have write permissions for the /Library/Ruby/Gems/2.6.0 directory.
```

在 stackoverlfow 上看到解决办法：https://stackoverflow.com/a/68208884/2474841

在终端里运行：
```shell
export GEM_HOME="$HOME/.gem"
```

确保安装后没有报错提示，继续运行 `jekyll new new-dive-into-web`，报错：

```shell
zsh: command not found: jekyll
```

检查 jekyll 是否安装以及版本，`which jekyll`, 提示：

```shell
jekyll not found
```

检查 jekyll 安装到哪里，终端显示

```shell
ls ~/.gem/ruby
// 输出
2.6.0	3.0.0
ls ~/.gem/ruby/2.6.0
// 输出
cache
ls ~/.gem/ruby/3.0.0/bin
// 输出
jekyll
```

接下就是把path写到 .zshrc 里:

```shell
echo 'export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
which jekyll
// 输出
/Users/wuxue/.gem/ruby/3.0.0/bin/jekyll
```

### 使用 Jekyll创建新项目

```shell
jekyll new new-project
cd new-project
bundle exec jekyll serve --trace
```

报错：

```shell
/Users/*/.gem/ruby/3.0.0/gems/jekyll-4.2.1/lib/jekyll/commands/serve/servlet.rb:3:in `require': cannot load such file -- webrick (LoadError)
```

搜了一下，[这里](https://github.com/github/pages-gem/issues/752#issuecomment-764647862)说 Ruby 3.0 不再内置 webrick，安装一下

```shell
bundle add webrick
```

终于可以了！
