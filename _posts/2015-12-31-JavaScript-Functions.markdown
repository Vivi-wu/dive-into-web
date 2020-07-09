---
title:  "JavaScript Functions"
category: JavaScript
---
The `typeof` operator in JavaScript returns "**function**" for functions. But, <span class="t-blue">JS函数最好被描述为对象</span>。

使用 `arguments.length` property 可以返回函数调用时，**接收到的实际参数个数**。

## 函数语句 Syntax

使用关键字 **function** 后面跟函数名，括号，由逗号分隔开的参数（参数不是必须的），再跟一个大括号。

    function name(parameter1, parameter2, parameter3) {
        code to be executed
    }

Function names can contain letters 字母, digits 数字, underscores 下划线, and dollar signs 美元符号(same rules as variables)。

<!--more-->

### Function Declarations 函数声明

使用**函数语句**声明函数，函数被声明以后不会立即执行。

Since a function declaration is not an executable statement, it is not common to end it with a semicolon. 因为函数声明不是一个可执行的语句，所以在结尾处不加分号。

### Function Expressions 函数表达式

JS函数可以使用表达式来定义。

    var x = function (a, b) {return a * b};
    var z = x(4, 3);

上面定义的函数是一个 **anonymous function** 无名函数，因为函数表达式存储在一个变量里，所以使用**变量名**来调用。

本例中的函数结尾有分号，因为它作为可执行语句的一部分。

### 两种创建 JS 函数的区别

前者在闭包的开始被创建（JS不会等待条件语句执行后再决定是否创建函数，尽管浏览器允许把函数放在if里面），因此想有条件地定义函数时，不能使用函数语句。

函数表达式在程序执行到这一点时创建，可以有条件地定义一个函数。下面讲JS提升也解释了原因。

### Function() 构造函数

当然也可以使用函数构造器来创建函数。通常避免使用 new 关键字。

    var myFunction = new Function("a", "b", "return a * b");
    var x = myFunction(4, 3);

## Hoisting

Hoisting 提升 is JavaScript's default behavior of moving declarations to the **top** of the current scope (to the top of the **current script** or the **current function**)。<span class="t-blue">JS默认行为：把声明放置到当前脚本或当前函数的顶部</span>。

+ In JS, a variable can be used before it has been declared. 变量可以在声明之前被使用。
+ JavaScript only hoists declarations, **not** initializations. 只提升声明，而不是初始化赋值。
+ Hoisting applies to **variable** declarations **and** to **function** declarations。提升适用于<span style="color:red;">变量声明</span>和<span style="color:red;">函数声明</span>。
+ 使用函数表达式定义的函数 are **not** hoisted 不能被提升，

最后两点很好地表述了，函数声明和函数表达式的 **不同** ：函数调用可以写在函数声明前（因为声明可以被提升，不会出现 undefined 的错误），但不能早于函数表达式（表达式定义的函数不能被提升）。

下例中，因为变量 y 的声明可以提升到顶部，但是初始化赋值 `=7` 不行，所以 y 的值为 undefined。

```js
var x = 5; // Initialize x

elem = document.getElementById("demo"); // Find an element
elem.innerHTML = x + " " + y;           // Display x and y

var y = 7; // Initialize y
```

<span class="t-blue">To avoid bugs, always declare all variables at the beginning of every scope</span>.

## Function Parameters and Arguments

函数可以有 0 或多个参数。

关于函数的行参（函数定义里列出的参数名称），实参（函数调用是传递进来的 real 值）一些知识。

+ 函数定义不指定参数的 data type
+ 传递参数时不检查参数 type
+ 不检查传递的参数个数
+ 如果接收到的参数个数**少于**函数声明参数列表，the missing values are set to: **undefined**，最好给参数设置一个默认值。(参看 JavaScript Strict Mode 章节)
+ 如果接收到的参数个数**多于**声明参数列表里，这些参数 can be reached using the `arguments` object（JS函数内置对象，包含一个 array 放置函数调用时传递进来的参数）

使用函数**内置参数对象** `arguments`，可以轻松实现输入值相加等操作。

```js
function sumAll() {
  var i, sum = 0;
  for (i = 0; i < arguments.length; i++) {
    sum += arguments[i];
  }
  return sum;
}
x = sumAll(1, 123, 500, 115, 44, 88); // 871
```

可以使用 `...variable` 剩余参数运算符简化代码。

```js
function avg(...args) {
  var sum = 0;
  for (let value of args) {
    sum += value;
  }
  return sum / args.length;
}
avg(2, 3, 4, 5); // 3.5
```

rest parameter operator 更常作为 `avg(firstValue, ...args)`，该变量中包含调用函数的所有未捕获参数的列表。

### 参数传递

通过 **value** 传递的 arguments are **not visible** (reflected) outside the function。函数体内改变这些参数的值，对它们没有影响。

通过 **reference** 传递进来的 object are **visible** (reflected) outside the function.而通过指针传进来的对象，在函数体内的改变 changes the original value。

## Function Invocation 函数调用

1. 以 function 形式调用函数：`myFunction(10, 2);`

    注意: 在JS中有一个 default global object，下面这个函数看起来不属于任何对象，在 HTML 页面中，它属于页面对象，而在浏览器中，页面对象就是浏览器 window，所以这个函数自动变成窗口对象的函数。

    ```js
    function myFunction(a, b) {
      return a * b;
    }
    myFunction(10, 2);  // window.myFunction(10, 2) will also return 20
    ```
    <span class="t-blue">Global variables, methods, or functions can easily create name conflicts and bugs in the global object</span>. 全局的变量和函数很容易在全局对象中产生命名冲突和bug。

2. 以对象的方法形式调用函数：`myObject.fullName();`
3. 在函数前加关键字 new，以构造函数形式调用函数：`var x = new myFunction("John","Doe");`
4. 使用 **call()** 和 **apply()** (JS预定义函数)调用函数：

    ```js
    function myFunction(a, b) {
      return a * b;
    }
    var myResult = myFunction.call(null, 10, 2);     // myResult return 20
    var myArray = [10, 2];
    var myResult2 = myFunction.apply(null, myArray);  // myResult2 return 20
    ```

 .call(scope, arg1, arg2, arg3) takes individual arguments（一一获取实参）, whereas .apply(scope, [arg1, arg2]) takes an Array of arguments 从数组中获取函数实参。

### Self-Invoking Functions

自调用表达式可以自动调用。

Function expressions will execute automatically if the expression is followed by `()`. 在函数表达式后面加 `()`，可以使函数自动执行。

函数声明不能被自调用，必须先用括号括起来，如下，又称为 **anonymous self-invoking function**。好像普遍称为 Immediately Invoked Function Expressions。

```js
(function () {
    var x = "Hello!!";      // I will invoke myself
})();
(function (a, b) {
    // a == 'hello'
    // b == 'world'
})('hello', 'world');
```

通过函数表达式给无名函数加 name，让内部可以循环调用。通过闭包，让name只在函数作用域内可用，这样代码更可读，对debugger友好。
```js
var charsInBody = (function counter(elm) {
  if (elm.nodeType == 3) { // TEXT_NODE
    return elm.nodeValue.length;
  }
  var count = 0;
  for (var i = 0, child; child = elm.childNodes[i]; i++) {
    count += counter(child);
  }
  return count;
})(document.body);
```

## Function Return 函数返回

函数遇到 **return** 语句，立刻停止执行。通常计算一个返回值，给调用者。

如果函数内没有 return 语句，或写为空返回（不指定 return 值），则函数返回 undefined
