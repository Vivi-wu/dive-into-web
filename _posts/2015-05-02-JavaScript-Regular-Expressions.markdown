---
title:  "JavaScript Regular Expressions"
category: JavaScript
---
一个 Regular Expression (正则表达式)是组成一个 search pattern (搜索模式)的一系列字符，它是一个 object。可用于文本查找和文本替换操作。

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

用于匹配的模式表示字符区间的：

+ `[abc]`, 在方括号之间的任何字符
+ `[^abc]`, 任何**不在**方括号之间的字符
+ `[0-9]`, 在方括号之间的任何数字
+ `[^0-9]`, 任何**不在**方括号之间的数字
+ `(x|y)`, 符合由竖线分开的任何可选项

表示数量的：

+ `n+`, contains at least one, 至少包含一个 n
+ `n*`, contains zero or more occurrences of n, 包含**0个**或**多个** n
+ `n?`, contains zero or one occurrences of n, 包含**0个**或**1个** n
+ `n{X}`, contains a sequence of X n's, 包含X个连续的n
+ `n{X,Y}`, contains a sequence of X to Y n's，包含X到Y个连续的n
+ `n{X,}`, contains a sequence of at least X n's，包含**至少**X个连续的n
+ `n$`, any string with n **at the end** of it
+ `^n`, any string with n **at the beginning** of it
+ `?=n`, any string that **is followed by** a specific string n
+ `?!n`, any string that is **not** followed by a specific string n

还可以使用反斜杠开始的特殊字符。

## RegExp Object

常用的正则表达式对象的方法有： `test()` 和 `exec()`

    /e/.test("The best things in lifr are free!");

不需要把正则表达式对象放在一个变量里，就可以使用 test() 方法。如果搜索字符串中有匹配，返回 _true_， 否则返回 false。

`exec()` 方法在字符串中查找匹配，返回找到的文本，如果没有找到，返回 _null_。
