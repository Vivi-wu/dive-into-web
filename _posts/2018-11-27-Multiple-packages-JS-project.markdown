---
title:  "Multiple packages' JS project"
category: JavaScript
---
本文记录如果实现搭建/管理含多个packages的js项目。

最初的需求是在一个项目里集中管理团队中成员单独写的 Vue.js 插件。了解到 [scoped packages](https://docs.npmjs.com/misc/scope){:target="_blank"} 的概念。

受到 [Vue CLI 3](https://github.com/vuejs/vue-cli/blob/dev/lerna.json){:target="_blank"} 的启发，发现了 [Lerna](https://github.com/lerna/lerna){:target="_blank"} 这个工具。


## 有作用域的包

命名：`@somescope/somepackagename`，不能以 `.` 或 `_` 开头。

作用：奖相关的包集中管理。每一个npm的用户或organization都有自己的 scope。

安装：`npm install @myorg/mypackage`

有作用域的包实际上被安装在了与作用域同名的文件目录下，因此代码中引用如 `require('@myorg/mypackage')`。

+ 发布public的作用域包，只需在初始发布时指定 `--access public`
+ scope 和 registry 是 many-to-one 多对一的关系。

<!--more-->

## Lerna

目标：Splitting up large codebases into separate independently versioned packages for code sharing。

Lerna 构建的项目文件目录结构如下：

```bash
my-lerna-repo/
  package.json
  lerna.json
  packages/
    package-1/
      package.json
    package-2/
      package.json
```

使用 Independent 模式可以指定每个 package 的更新版本，对于一组 component 非常有用。

+ 所有包使用指定依赖的同一个版本
+ 可以保障根目录下的依赖 up-to-date，比如借助自动化工具 GreenKeeper
+ 减少了每个包的依赖安装时间
+ 减少需要的 storage 空间

Note that devDependencies providing "binary" executables that are used by npm scripts still need to be installed directly in each package where they're used.
