---
title:  "JavaScript Syntax"
categories: JavaScript
---
## Statements

在编程语言中，被计算机执行的语句称为 statements。语句按照它们书写的顺序，一条接一条地被执行。

### 分号

JS语句由 **semicolons 分号**分隔开。虽然结尾的分号不是必须的，但是**建议保留**！有分号结尾的JS语句可以被写在同一行里。

### 空格

JS忽略掉多个空格，所以我们可以在代码里添加空格方便阅读。

一个好的实践是：在 _operator_ 操作符 周围加一个空格：

    var x = y + z;

### 换行

避免一行代码过长，w3Schools 建议不超过 _80_ 个字符。如果换行，最好是在一个 _operator_ 操作符之后；

    document.getElementById("demo").innerHTML =
    "Hello world, this is my first js code."

<!--more-->

## Values

JS语法定义了两种类型的值，fixed 固定的值和 variable 变换的值。前者称为 literals 常量，后者成为 variables 变量。

### Literals

+ **Number**，JS只有一种数字常量，使用时可以带小数，也可以没有
+ **String**，字符串，可以用单引号，也可以用双引号限制起来

## Variables

JS变量是用来存储数据值的容器。所有JS变量 must be identified with **unique names**，这个唯一的名字称为 **identifiers** 标志符。

### identifiers 标志符

identifiers are used to name variables (and keywords, and functions, and labels)

+ Names can contain **letters** 字母, **digits** 数字, **underscores** 下划线, and **dollar signs** 美元符号.
+ Names **must begin** with a **letter**, a **$** or an `_` (尽量避免使用 **$**，会跟例如jQuery这样的函数库里的变量冲突)
+ Names are **case sensitive** 大小写敏感 (y and Y are different variables)
+ Reserved words (like [JavaScript keywords](http://www.w3schools.com/js/js_reserved.asp)) cannot be used as names

### 连接多个单词命名方式

通常有三种方式：

+ **Hyphens**: first-name (_JS不允许这种方式_，`-` 被保留作为减法操作符)
+ **Underscore**: first_name
+ **Camel Case**: FirstName

w3schools 使用首字母小写的驼峰式: firstName

### 变量的声明和赋值

在JS中创建一个变量又称为“声明”一个变量。JS中使用 **var** keyword to **declare** variables 声明变量, use **equal sign** (=) 此时等号是赋值符 to **assign values** to variables 给变量赋值.

可以先声明，后赋值，分两步。也可以声明的同时赋值，即初始化变量。

    var today = "Monday";

After the declaration, the variable has no value. (Technically it has the value of **undefined**) **注意**：_声明变量后，变量是没有值的，或者说此时变量值为 undefined_。

你也可以使用 **comma** 逗号分隔，同时声明多个变量。

    var person = "John Doe", carName = "Volvo", price = 200;

当然因为JS忽略多个空格，你可以在逗号后面换行，这样每行一个变量，方便阅读。

## Operators

### 算术操作符：+， -， *， /， %， ++， --

当语句中出现多个操作符，注意操作符优先级[Operator Precedence Values](http://www.w3schools.com/js/js_arithmetic.asp)

**NOTE**：`()` 括号拥有**最高优先级**，写在括号中的表达式会优先于剩下的表达式被计算。

### 赋值操作符：

<table>
  <tbody>
    <tr>
      <th>Operator</th>
      <th>Example</th>
      <th>Same As</th>
    </tr>
    <tr>
      <td>=</td>
      <td>x = y</td>
      <td>x = y</td>
    </tr>
    <tr>
      <td>+=</td>
      <td>x += y</td>
      <td>x = x + y</td>
    </tr>
    <tr>
      <td>-=</td>
      <td>x -= y</td>
      <td>x = x - y</td>
    </tr>
  </tbody>
</table>

还有 `*=` 乘, `/=` 除, `%=` 取余，用法同。

### Concatenation/String operator

加号 `+`，自加 `+=` 都可以作为字符串操作符，用于字符串的连接（相加）。

    txt1 = "What a very ";
    txt1 += "nice day";

If you add a number and a string, the result will be a **string**! <span style="color:blue;">数字和字符串相加，结果将是一个字符串</span>。

### Comparison and Logical Operators

比较和逻辑操作符用于测试 true 还是 false。

比较操作符：`==`， `===` （值和data type都相同）， `!=`， `!==`， `>`_， `<`， `>=`， `<=` 不同type数据之间比较将在JS Type Conversion章节讨论。

逻辑操作符：`&&`（同真则真）， `||`（同假才假）， `!`

条件（三元）操作符：variablename = (condition) `?` value1:value2 满足条件取value1，否则取value2.

### 类型操作符

+ `typeof`，returns a **string** containing the type of the operand，以字符串形式，返回操作数的类型
+ `instanceof`，

## 表达式

由 value，variable 和 operator 结合组成了JS的 expression 表达式。

## Character Set

JS 使用 [Unicode(UTF-8)](http://www.w3schools.com/charsets/ref_html_utf8.asp) character set.
