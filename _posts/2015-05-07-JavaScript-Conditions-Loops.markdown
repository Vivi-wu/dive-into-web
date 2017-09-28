---
title:  "JavaScript Conditions and Loop"
category: JavaScript
---
JS 条件语句，根据不同决定执行不同操作。

## if ... else 语句

### `if` Statements

条件为 true 时，执行一段代码。

### `else` Statements

条件为 false 时，执行一段代码。

### `else if` Statements

如果第一个条件为 false 时，检查新的条件。if (condition1) {...} else if (condition2) {...} else {...}

<!--more-->

## `switch` Statement

语法：

```js
switch(expression) {
    case n:
        // code block
        break;
    case n:
        // code block
        break;
    default:
        // default code block
}
```

注意：

+ expression evaluated once 表达式评估一次
+ 将表达式的值与每一个 case 的值相比较（使用 **strict comparison**，值和类型都要相等），如果找到匹配的 case，就执行相对应的代码
+ 遇到 **break** 关键字，跳出 switch 体，避免执行更多的代码或 case testing
+ **default** 关键字指明，当没有找到匹配的 case 时，要执行的操作
+ 不同 case 可以使用相同的执行 code
+ 如果 default **不是最后一个** case，记得在它的代码后加 **break**

## For Loops 循环

语法：

    for (statement 1; statement 2; statement 3) {
        code block to be executed
    }

+ 语句1在 loop 开始前执行，通常用来**初始化**控制 loop 的变量值。语句2指定循环条件，每次循环前都要判断一下是否满足条件。语句3在每一次循环体内代码执行完之后执行，通常作为变量
+ You can initiate many values in statement 1 (separated by comma)，可以在语句1里初始化多个变量。
+ 语句1可以缺省，把初始化变量放在 for 体上面。
+ 语句2也可以缺省，但是必须在循环体内提供一个 break
+ 语句3也可以缺省，把 increment 放在循环体内

## While Loops 循环

语法：

    while (condition) {
        code block to be executed
    }

只要循环条件满足，就执行代码，所以记得在循环体内写明 increment，

### Do/While Loop

先执行一遍循环体，在 check 循环条件。

    do {
        code block to be executed
    }
    while (condition);

## Break and Continue

区别：

+ **break** statement "**jumps out**" of a loop or a switch. 直接跳出循环体，执行后面的代码
+ **continue** statement "**jumps over**"/ "**skip**" one iteration in the loop. 在一个 for 循环里，遇到 continue 直接跳到 update expression 处（如 `i++`），不会完全终止循环的执行。

### JavaScript Labels

JS标签语法

    labelname:
    statements
    break labelname;
    continue labelname;
