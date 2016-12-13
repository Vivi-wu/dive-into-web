---
title:  "JavaScript Syntax"
category: JavaScript
---
## Statements

在编程语言中，被计算机执行的语句称为 statements。语句按照它们书写的顺序，一条接一条地被执行。

### 空格

JS忽略掉多个空格，所以我们可以在代码里添加空格方便阅读。

一个好的实践是：在 _operator_ 操作符 周围加一个空格：

    var x = y + z;

### 换行

避免一行代码过长，w3Schools 建议不超过 _80_ 个字符。语句换行，最好是在一个 _operator_ 操作符之后；

    document.getElementById("demo").innerHTML =
    "Hello world, this is my first js code."

<!--more-->

直接在字符串中 break 语句，是**不能**实现换行的，而且会引起 SyntaxError。如果一定要在字符串中断行，使用 **backslash** 反斜杠 `\`，如下：

    document.getElementById("demo").innerHTML = "Hello world, this \
    is my first js code."

有五种符号可以出现在一个语句的开头，也可作为一个完整语句的扩展。这意味着**不是**所有的情况下 line break 换行可以取代语句之间的 semicolon 分号。

这种种符号是：

+ open parenthesis 开圆括号 `(`
+ open square brace 开方括号`[`
+ slash 斜杠 `/`
+ plus 加号 `+`
+ minus 减号 `-`

    a = b + c
    (d + e).print()
    a = b + c(d + e).print()  // 上面两个语句会变成这样一个语句，不会有分号的自动插入

比较麻烦的斜杠符号，不仅可以作为正则表达式的开头，还可以作为除法操作符。下面这种情况实践中还是较少出现的，

    var i,s
    s="here is a string"
    i=0
    /[a-z]/g.exec(s)  // 这一行会被认为是上一行的延续，即 i=0/[a-z]/g.exec(s)

## 分号

这里 [JavaScript Semicolon Insertion Everything you need to know](http://inimino.org/~inimino/blog/javascript_semicolons) 详细全面地解释了 JavaScript automatic semicolon insertion。

### 在哪里可以写分号？

在 ECMAScript 规范中给出的正式语言的语法中，分号可以出现在任何一种 statement 结尾。

可以在 `var` 变量声明语句，表达式语句 (such as "4+4;" or "f();"), `continue`, `return`, `break`, `throw` 和 `debugger` 语句的结尾处。

一个分号本身就是一个**空语句**，在 JS 中是合法的语句。比如 `;;;` 是一个合法的 JS 程序，它解析了三个空语句，运行了三次 doing nothing.

分号出现在 for ( Expression ; Expression ; Expression ) 循环语句中。

### 哪里可以缺省分号？

以下给出了三种语句截止不需分号的基本规则和两种例外：

1. 在 closing brace 闭括号之前。
2. 在一个 program 结尾处。
3. 当下一个 token 符号不能通过其他方式被解析，且在语法中的某些地方，如果出现一个 line break，它无条件地终止该语句。
4. 例外1，分号 never inserted 在 for loop 头部 for ( Expression ; Expression ; Expression )
5. 例外2，分号 never inserted if it would be parsed as an empty statement.

    ```js
    for (node=getNode();
     node.parent;
     node=node.parent) ; // 该 for 循环执行读取节点的父节点，直到遇到一个没有父节点的节点，所有操作在 for 循环的头部进行。
    // 尽管不需要循环体，但 for 循环语法需要一个语句，因此使用了 `;` 空语句。
    ```

    上面例子中三个分号都在行尾，但是都不可缺少。原因见 4 & 5

6. Semicolons are **not optional** between statements appearing on the same line. 写在同一行语句之间的分号，是不可缺省的。

    ```js
    42; "hello!" // valid
    42\n"hello!" // valid，“\n” 代表一个实际的换行
    42 "hello!"  // no valid，whitespace 空格不能触发分号插入
    if(x){y()}   // "y()" 语句表达式可用分号结尾，但因为后面跟着闭合大括号，分号是可选的。
    ```

7. 当JS遇到不完整的语句时，会读取下一行，试着完成这个语句。

    ```js
    function myFunction(a) {
        var
        power = 10;
        return a * power;
    }
    ```

### Restricted productions

受限输出是指在那里，换行不能出现在特定的位置。如果出现了，它将会阻止程序按期望的方式解析，从而解析成了别的结果。

语法中有**五种**受限输出：

+ postfix 后缀式操作符 `++` `--`
+ `continue`
+ `break`，其中 return 和 break 语句可以使用可行的标识符，用来对 labeled loop 操作。如果是这种情况，标识符 **must** 写在同一行。
+ `return`，因为返回语句是受限输出，方便程序员写一个空的 return statement，而不会不小心返回了下一行语句的值。
+ `throw`

  ```js
  var i=1;
  i
  ++; // parse error
  i
  ++
  j  // parses as "i; ++j", 因为前置自增\减 不是受限输出。
  return {
    i:i, j:j}
  return (
    {i:i, j:j})
  return {i:i
         ,j:j}  // return 语句在表达式之间可以包含换行
  throw
    new MyComplexError(a, b, c, more, args);   // parse error
  // 不同于返回、中断、继续语句，throw 语句后的表达式不是可选的，so the above will not parse at all.
  throw new MyComplexError(a, b, c, more, args);  // correct
  throw new MyComplexError(
      a, b, c, more, args);                       // also correct
  // Any variation with 'new' and 'throw' on the same line is correct.
  ```

在上面五种受限输出的情况，换行导致的错误在实践中很少遇到，除了把返回值放在 return 符号的下一行。尤其是当返回值是一个大的对象、数组或者多行的字符串。

```js
return obj.method('abc')
      .method('xyz')
      .method('pqr')
return "a long string\n"
     + "continued across\n"
     + "several lines"
totalArea = rect_a.height * rect_a.width
          + rect_b.height * rect_b.width
          + circ.radius * circ.radius * Math.PI
```

规则只考虑跟随行的第一个符号，如果这个符号可以被解析成语句的一部分，则认为这个语句是被延续的 **is continued**。

如果跟随行的第一个符号不能扩展语句，则认为新的语句开始了。A semicolon is inserted.

There is no reason to be concerned about browser compatibility in regard to semicolon insertion: all browsers implement the same rules and they are the rules given by the spec and explained above. 所有的浏览器实行着相同的规则，这些规则是由 spec 给出的，如上面所解释的。关于分号插入，没有理由担心浏览器兼容性问题。

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
+ Reserved words (like [JavaScript keywords](http://www.w3schools.com/js/js_reserved.asp)) 保留字不能用来作为变量名。

### 连接多个单词命名方式

通常有三种方式：

+ **Hyphens**: first-name (_JS不允许这种方式_，`-` 被保留作为减法操作符)
+ **Underscore**: first_name
+ **Camel Case**: FirstName

w3schools 使用首字母小写的驼峰式: firstName

### 变量的声明和赋值

在JS中创建一个变量又称为“声明”一个变量。JS中使用 **var** keyword to **declare** variables 声明变量, use **equal sign `=`**, 此时等号是赋值符, to **assign values** to variables 给变量赋值.

After the declaration, the variable has no value. (Technically it has the value of **undefined**) **注意**：_声明变量后，变量是没有值的，或者说此时变量值为 undefined_。

可以先声明，后赋值，分两步。也可以声明的同时赋值，即初始化变量。

    var today = "Monday";

An assignment always returns the value of the assignment. <span class="t-blue">赋值语句返回的值，就是被赋予的值</span>。

    var x = 0;
    if (x = 10)

这里 if 判断的条件为 true。因为赋值语句 `x＝10` 的返回值是 10，只要是 real 的值，都是 true 的。

你也可以使用 **comma** 逗号分隔，同时声明多个变量。

    var person = "John Doe", carName = "Volvo", price = 200;

当然因为JS忽略多个空格，你可以在逗号后面换行，这样每行一个变量，方便阅读。

## Operators

### 算术操作符：+， -， *， /， %， ++， --

当语句中出现多个操作符，注意操作符优先级 [Operator Precedence Values](http://www.w3schools.com/js/js_arithmetic.asp)

**NOTE**：`()` 括号拥有**最高优先级**，写在括号中的表达式会优先于剩下的表达式被计算。

### 赋值操作符：

<table>
  <thead>
    <tr>
      <th>Operator</th>
      <th>Example</th>
      <th>Same As</th>
    </tr>
  </thead>
  <tbody>
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

If you add a number and a string, the result will be a <strong>string</strong>! <span class="t-blue">数字和字符串相加，结果将是一个字符串</span>。

### Comparison and Logical Operators

比较和逻辑操作符用于测试 true 还是 false。

+ 比较操作符：`==`， `===`（值 和 data type 都要相同）， `!=`， `!==`（值 或 data type 不相同）， `>`， `<`， `>=` (greater than or equal to)， `<=`。 不同 type 数据之间比较将在 JS Type Conversion 章节讨论。
+ 逻辑操作符：`&&`（同真则真）， `||`（同假才假）， `!`
+ 条件（三元）操作符：variablename = (condition) `?` value1:value2 满足条件取 value1，否则取 value2.
+ 位操作符：`&` 逻辑与，`|` 逻辑或，`~` 逻辑非，`^` 逻辑异或，`<<` 左移几位，`>>` 右移几位. 作用于 32-bit numbers，result is converted back to a JavaScript number

在逻辑运算中，如果第一个操作数满足结果条件，第二个操作数就不会被评估。

巧用逻辑操作符，可以缩短代码。如下：

```js
let add = key => !data[key] && (data[key] = rand()) || data[key];
// 等价的一般写法
add = key => {
   // If the value is not yet set...
   if (!data[key]) {
      // set it!
      data[key] = rand();
   }
   // Always, do return the value
   return data[key];
};
```

### 类型操作符

+ `typeof`，returns a **string** containing the type of the operand，以字符串形式，返回操作数的类型
+ `instanceof`，returns **true** if an object is created by a given constructor，返回布尔值为 true，如果**一个对象**是由指定的 constructor 构造的。可用来识别 Array 和 Date，后面还会提到。

### `in` 操作符

判断指定的属性是否在某个对象中。

```js
// Arrays
var cars = ["Saab", "Volvo", "BMW"];
"Saab" in cars          // Returns false (specify the index number instead of value)
0 in cars               // Returns true
1 in cars               // Returns true
4 in cars               // Returns false (does not exist)
"length" in cars        // Returns true  (length is an Array property)

// Objects
var person = {firstName:"John", lastName:"Doe", age:50};
"firstName" in person   // Returns true
"age" in person         // Returns true

// Predefined objects
"PI" in Math            // Returns true
"NaN" in Number         // Returns true
"length" in String      // Returns true
```

## 表达式

由 value，variable 和 operator 结合组成了JS的 expression 表达式。

## Character Set

JS 使用 [Unicode(UTF-8)](http://www.w3schools.com/charsets/ref_html_utf8.asp) character set.
