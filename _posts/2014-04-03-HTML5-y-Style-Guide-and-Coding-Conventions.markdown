---
title:  "HTML5 Style Guide and Coding Conventions"
categories: HTML
---
1.element的特性在等号前后的加空格是合法的，如

    <link rel = "stylesheet" href = "styles.css">

但是不写空格更易于阅读，和组织相关的实体。

2.一行代码尽量控制在**80个字符长度**，超出换行

3.使用 **2** 个空格用于行首缩进，不要使用 **TAB**

4.It's not necessary to indent every element，没必要对每一个元素都缩进

5.不要添加不必要的空行 blank line，未来便于阅读，用空行来分开大的或者逻辑相关的代码块

6.关于HTML注释，短的注释写在一行，如：

    <!-- This is a comment -->  

长的注释，分行写，`<!--` 和 `-->` 写在分开的两行，注释文字每行开始缩进2个空格，如：

    <!--
      This is a long comment example. This is a long comment example. This is a long comment example.
      This is a long comment example. This is a long comment example. This is a long comment example.
    -->

<!--more-->

### CSS 书写建议

短的法则写在一行，如：

    p.into {font-family:"Verdana"; font-size:16em;}  

长的写多行，

    body {
      background-color: lightgrey;
      font-family: "Arial Black", Helvetica, sans-serif;
      font-size: 16em;
      color: black;
    }

**注意**：

1. 开大括号与选择器写在同一行
2. 在开大括号前加一个空格
3. 每行开始缩进2个空格
4. 在每个CSS属性和值之间使用冒号，加一个空格
5. 在每一个逗号或分号后加一空格
6. 每个“属性-值”对的末尾加一个分号，包括最后一个
7. **只有当属性值包含空格时，使用双引号**
8. 闭大括号另起一行，不要空格缩进

### 其他

尽量使用小写字母命名文件。
