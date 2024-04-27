---
title:  "构建系统"
category: Other
---
## 构建系统

构建系统是指用来自动化执行编译、链接、打包、测试等一系列操作的软件。你定义规则告诉这些工具如何执行命令、处理依赖关系、向目标文件输出结果。

针对不同目的、不同语言有不同的构建系统，如 Java 的 Maven、JavaScript 的 npm等。

Make 是最古老的构建系统，几乎存在于所有操作系统上。Make 命令将在当前目录里寻找名为 Makefile 的文件，然后根据 Makefile 的规则执行命令。

<!-- more -->
如果 makefil 中涉及的依赖没有发生变化，再次运行 make 命令将不会重新编译，而是直接使用上次编译的结果。即尝试做最少的工作来实现目标。

Makefile 也是一种 DSL（Domain Specific Language）语言。

### Semantic Versioning 语义化版本

版本格式：MAJOR.MINOR.PATCH（主版本号.次版本号.修订号）如：1.0.0

版本号递增规则如下：

+ 主版本号：发布了不兼容的 API 修改。此时增加主版本号，同时将次版本号和修订号都置为0。
+ 次版本号：发布了向下兼容的功能性新增 add。通常增加此版本号，同时设 patch 版本号为0。
+ 修订号：发布了向下兼容的改变，通常是问题的修正 fix。对已安装使用的人来说好像什么也没发生，不会影响他们已用的功能。

许多软件项目试图让版本requirements尽可能得低，这样就会有更多人愿意依赖你的软件。

先行版本号及版本编译元数据，可以加到“主版本号.次版本号.修订号”的后面作为延伸。如：1.0.0-beta

### Lockfile

Lockfile 是指锁定依赖版本的一种机制，其内容主要一系列依赖和它们当前使用的版本。

+ 确保你不会意外更新什么东西
+ 让构建过程更快，只要lockfile中依赖没有更新，就直接使用之前构建安装的依赖（无需下载和安装）
+ 获得 reproducible builds（可重复的构建结果）

## Continuous Integration / CI

持续集成本质上是一种云构建系统。持续集成可以是：

+ 当你push代码到特定分支，自动发布插件库到 npm 仓库
+ 当有人创建pull request时，执行单元测试
+ 每次commit时，检查代码风格
+ code coverage检查

常见的CI platforms有 Github Actions、Jenkins等。还有一个例子就是 Github Pages CI，也是本博客使用的服务。

### Test Suites 测试套件

测试套件是指用来验证软件功能的测试用例集合，通常由不同类型测试组成。

+ Unit tests 单元测试：通常是自给自足的micro test。测试单个模块功能或一个函数的行为是否符合预期。如：测试一个 HTML parser 可以正确解析一个 tag
+ Integration tests 集成测试：测试多个模块或子系统之间的集成情况。如果：测试一个 HTML parser 可以正确解析一个 HTML 文档。
+ Regration tests 回归测试：测试软件的历史版本是否能正常运行。阻止你的程序 regressing to 早期的bugs。
