---
title:  "JavaScript Regular Expressions"
category: JavaScript
---
一个 Regular Expression (**正则表达式**)是组成一个 search pattern (搜索模式/规则)的一系列字符，它是一个**对象**，可用于文本的查找和替换操作。

## 语法

由 pattern 和 modifier(s) 组成。

    /pattern/modifiers;

经常使用到正则表达式的就是字符串方法 `search()` 和 `replace()`。

<!--more-->

### Modifiers

作为修饰语，可以单独使用，也可以多个组合起来使用。

+ `i`, 表示 case-insensitive (大小写不敏感)的匹配，使用 _ignoreCase_ 属性检查是否设置了该修饰符
+ `g`, 全局搜索，找出所有匹配项（而不是在找到第一个匹配时，就停止查找），使用 _global_ 属性检查是否设置了该修饰符
+ `m`, 执行多行匹配，使用 _multiline_ 属性检查是否设置了该修饰符

### Patterns

表示字符区间的：

+ `[abc]`, 匹配在方括号之间的任意一个字符，如匹配一个标点符号：`[.?!]`，任何一个英文元音字母：`[aeiou]`
+ `[^abc]`, 匹配任何一个**不在**方括号内的字符
+ `[0-9]`, 在方括号之间的任何一个数字
+ `[^0-9]`, 任何**不在**方括号之间的一个数字
+ `x|y`, 又称**分枝条件**，指的是有几种规则，如果满足其中任意一种由竖线分隔开的规则，都应该当成匹配。

    注意 x 和 y 条件的顺序很重要！因为匹配分枝条件时，会从左到右地测试每个条件，如果满足了某个分枝的话，就不会去再管其它分支的条件了。

表示数量的：

+ `n+`, contains at least one, **至少**包含**一个** n
+ `n*`, contains zero or more occurrences of n, 包含 **0 个**或**多个** n，贪婪匹配（匹配**尽可能多**的字符）
+ `n?`, contains zero or one occurrences of n, 包含 **0 个**或 **1 个** n，懒惰匹配（匹配**尽可能少**的字符）
+ `n{X}`, contains a sequence of X n's, 必须连续匹配 X 个 n
+ `n{X,Y}`, contains a sequence of X to Y n's，包含 **X 到 Y 个连续的** n，不少于 X 个，不多于 Y 个
+ `n{X,}`, contains a sequence of at least X n's，重复匹配 X 次或更多次
+ `n$`, any string with n at the end of it，n 在**结尾**处
+ `^n`, any string with n at the beginning of it，匹配输入开始位置的 n。如果多行匹配标志开启，则也匹配换行符后紧跟的位置
+ `?=n`, any string that is followed by a specific string n，**后面跟着** n
+ `?!n`, any string that is not followed by a specific string n，后面**不**跟着 n

上面都是针对单个字符的重复匹配，如果要多个字符，就需要使用 `(x)`，用小括号来指定子表达式(也叫做**分组**)，然后就可以指定这个子表达式的重复次数，或进行其它操作。

字符转义：

有时需要查找元字符本身，比如 `.`，`*`，要使用反斜杠 `\` 来消除这些字符的特殊意义。查找反斜杠本身，也要使用反斜杠，如：`\\`。

## RegExp Object

创建正则表达式对象：**字面量**和**构造函数**。

```js
/ab+c/i;
new RegExp('ab+c', 'i');
new RegExp(/ab+c/, 'i');
```

当正则表达式保持为常量时使用字面量。

当事先不知道什么模式，从另一个来源获取，如：用户输入，这些情况都可以使用构造函数。

常用的正则对象的方法有： `test()` 和 `exec()`

    /e/.test("The best things in lifr are free!");

不需要把正则表达式对象放在一个变量里，就可以使用 test() 方法。如果搜索字符串中有匹配，返回 _true_， 否则返回 false。

`exec()` 方法在字符串中查找匹配，**返回找到的文本**，如果没有找到，返回 _null_。

## 实践

[这里](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Regular_Expressions) 有具体的正则表达式 reference。

推荐这篇[(正则表达式30分钟入门教程)](http://www.cnblogs.com/deerchao/archive/2006/08/24/zhengzhe30fengzhongjiaocheng.html)，简单易懂。

### 元字符

正则表达式的特殊代码，称为 metacharacter 元字符。

1. `\b`，代表单词的分界处（它不匹配单词分隔字符，如空格、标点或者换行，它只**匹配一个位置**），单词的开头或结尾。
2. `.`（小数点），匹配除了换行符（\n）之外的任何单个字符。
3. `*`，表示数量。前边的内容可以连续重复使用任意次以使整个表达式得到匹配。
4. `\d`，匹配一个数字。
5. `\w`，匹配一个单字字符（字母、数字或下划线）
6. `\s`，匹配任意空白符，包括空格，制表符(Tab)，换行符和换页符

### 反义

用于查找不属于某个简单定义的字符类的字符。

+ `\D`，匹配任意非数字的字符
+ `\W`，匹配任意不是字母、数字或下划线的字符
+ `\S`，匹配任意不是空白符的字符
+ `\B`，匹配不是单词开头或结束的位置

### 后向引用/捕获

使用小括号指定一个子表达式后，匹配这个子表达式的文本（即此分组捕获的内容）可以在表达式或其它程序中作进一步的处理。

默认情况下，每个分组会自动拥有一个组号，规则是：从左向右，以分组的左括号为标志，第一个出现的分组的组号为1，第二个为2，以此类推。

**后向引用**用于重复搜索前面某个分组匹配的文本。例如，`\1` 代表分组1匹配的文本

### 零宽断言

用于查找某个内容（但不包括这些内容）之前或之后的东西，就像 `\b`, `^` 等只**匹配一个位置**，并不消费任何字符。

<table style="width:100%">
  <thead>
    <tr>
      <th>分类</th><th style="width:200px;">代码/语法</th><th>说明</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="3">捕获</td>
      <td><code>(exp)</code></td>
      <td>匹配exp,并捕获文本到默认命名的组里</td>
    </tr>
    <tr>
      <td><code>(?&lt;name&gt;exp)</code></td>
      <td>匹配exp,并捕获文本到名称为name的组里，也可以写成<code>(?'name'exp)</code></td>
    </tr>
    <tr>
      <td><code>(?:exp)</code></td>
      <td>匹配exp,但不捕获匹配的文本，也不给此分组分配组号</td>
    </tr>
    <tr>
      <td rowspan="2">零宽断言</td>
      <td><code>(?=exp)</code></td>
      <td>匹配exp前面的位置</td>
    </tr>
    <tr>
      <td><code>(?!exp)</code></td>
      <td>匹配后面跟的不是exp的位置</td>
    </tr>
  </tbody>
</table>
