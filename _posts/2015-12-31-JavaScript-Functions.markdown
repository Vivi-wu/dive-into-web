---
title:  "JavaScript Functions and Scope"
categories: JavaScript
---
JS函数就是一段当被调用时，要执行某个动作的代码。使用函数可以实现代码重用，通过传递不同的参数，产生不一样的结果。

函数可以被视为 value 使用，可以被用在表达式里。

The `typeof` operator in JavaScript returns "**function**" for functions. But, JavaScript functions can best be described as objects. <span style="color:blue;">JS函数最好被描述为对象</span>。

使用 `arguments.length` property 可以返回函数调用是接收到的参数个数。

## Syntax

使用关键字 **function** 后面跟函数名，括号，由逗号分隔开的参数（参数不是必须的），再跟一个大括号。

    function name(parameter1, parameter2, parameter3) {
        code to be executed
    }

Function names can contain letters 字母, digits 数字, underscores 下划线, and dollar signs 美元符号(same rules as variables)。

<!--more-->

### Function Declarations 函数声明

使用上面例子的格式声明函数，函数被声明以后不会立即执行。

Since a function declaration is not an executable statement, it is not common to end it with a semicolon. 因为函数声明不是一个可执行的语句，所以在结尾处不加分号。

### Function Expressions 函数表达式

JS函数可以使用表达式来定义。

    var x = function (a, b) {return a * b};
    var z = x(4, 3);

上面定义的函数是一个 **anonymous function** 无名函数，因为函数表达式存储在一个变量里，所以使用**变量名**来调用。

本例中的函数结尾有分号，因为它作为可执行语句的一部分。

### Function() 构造函数

当然也可以使用函数构造器来创建函数。通常避免使用 new 关键字。

    var myFunction = new Function("a", "b", "return a * b");
    var x = myFunction(4, 3);

## Hoisting

Hoisting 提升 is JavaScript's default behavior of moving declarations to the **top** of the current scope (to the top of the **current script** or the **current function**)。<span style="color:blue;">JS默认行为：把声明放置到当前脚本或当前函数的顶部</span>。

+ In JS, a variable can be used before it has been declared. 变量可以在声明之前被使用。
+ JavaScript only hoists declarations, **not** initializations. 只提升声明，而不是初始化赋值。
+ Hoisting applies to **variable** declarations **and** to **function** declarations。提升适用于<span style="color:red;">变量声明</span>和<span style="color:red;">函数声明</span>。
+ 但是使用函数表达式定义的函数 are **not** hoisted 不能被提升，

最后两点很好地表述了，函数声明和函数表达式的 **不同** ：函数调用可以写在函数声明前（因为声明可以被提升，不会出现 undefined 的错误），但不能早于函数表达式（表达式定义的函数不能被提升）。

下例中，因为变量 y 的声明可以提升到顶部，但是初始化赋值 `=7` 不行，所以 y 的值为 undefined。

    var x = 5; // Initialize x

    elem = document.getElementById("demo"); // Find an element 
    elem.innerHTML = x + " " + y;           // Display x and y

    var y = 7; // Initialize y

<span style="color:blue;">To avoid bugs, always declare all variables at the beginning of every scope</span>.

## Function Parameters and Arguments

关于函数的行参（函数定义里列出的参数名称），实参（函数调用是传递进来的 real 值）一些知识。

+ 函数定义不指定参数的 data type
+ 传递参数时不检查参数 type
+ 不检查传递的参数个数
+ 如果函数接收到的参数个数小于函数声明参数列表里的，the missing values are set to: **undefined**，最好给参数设置一个默认值。
+ 如果接收到的参数个数多于声明参数列表里的，这些参数 can be reached using the `arguments` object（JS函数内置对象，包含一个 array 放置函数调用时传递进来的参数）

    function myFunction(x, y) {
        if (y === undefined) {
            y = 0;
        }
    }

使用函数内置参数对象，可以轻松实现输入值相加等操作。

    x = sumAll(1, 123, 500, 115, 44, 88);
    function sumAll() {
        var i, sum = 0;
        for (i = 0; i < arguments.length; i++) {
            sum += arguments[i];
        }
        return sum;
    }

### 参数传递

通过 **value** 传递的 arguments are **not visible** (reflected) outside the function。函数体内改变这些参数的值，对它们没有影响。

通过 **reference** 传递进来的 object are **visible** (reflected) outside the function.而通过指针传进来的对象，在函数体内的改变 changes the original value。

## Function Invocation 函数调用

1.以 function 形式调用函数：`myFunction(10, 2);`

注意，在JS中有一个 default global object，下面这个函数看起来不属于任何对象，在 HTML 页面中，它属于页面对象，而在浏览器中，页面对象就是浏览器 window，所以这个函数自动变成窗口对象的函数。

    function myFunction(a, b) {
        return a * b;
    }
    window.myFunction(10, 2);    // window.myFunction(10, 2) will also return 20

<span style="color:blue;">Global variables, methods, or functions can easily create name conflicts and bugs in the global object</span>. 全局的变量和函数很容易在全局对象中产生命名冲突和bug。

2.以对象的方法形式调用函数：`myObject.fullName();`

3.在函数前加关键字 new，以构造函数形式调用函数：`var x = new myFunction("John","Doe");`

4.使用 **call()** 和 **apply()** (JS预定义函数)调用函数：

    function myFunction(a, b) {
        return a * b;
    }
    myObject = myFunction.call(myObject, 10, 2);     // Will return 20
    myArray = [10, 2];
    myObject = myFunction.apply(myObject, myArray);

上面的例子中可以看到，`apply()` 方法从数组中获取函数实参，而前者则一一获取实参。

### Self-Invoking Functions

自调用表达式可以自动调用。

Function expressions will execute automatically if the expression is followed by `()`. 在函数表达式后面加 `()`，可以使函数自动执行。

函数声明不能被自调用，必须先用括号括起来，如下，又称为 **anonymous self-invoking function**

    (function () {
        var x = "Hello!!";      // I will invoke myself
    })();

## Function Return 函数返回

当函数遇到 **return** 语句，即停止执行。通常计算一个返回值，给调用者。

## JavaScript Scope

Scope is the set of variables, objects, and functions you have access to. 你可以获取的变量、对象和函数的集合称为 scope。

在函数内部以 **var** 关键字声明的变量，就是局部变量。声明在函数外部的变量，就是全局变量。

在 HTML 中，全局 scope 就是窗口对象，因此 all global variables belong to the window object.

+ 局部变量只可以被定义它的函数使用，可以与全局变量重名。
+ 不使用关键字 **var** 创建的变量, are always global, even if they are created inside a function，即使写在一个函数内部，也自动变为全局变量。
+ 只要你的应用（浏览器窗口或网页）在运行，全局变量就存在。
+ 局部变量在函数调用时创建，在函数执行结束时删除。
+ function argument 函数参数作为局部变量在函数内被使用。

## JavaScript Closures

下面的例子中要实现计数加1的功能，但因为局部变量的生命周期只维持在函数调用期间，所以无论调用多少次 add 函数，结果都是 1.

    function add() {
        var counter = 0;
        counter += 1;
    }
    add();
    add();
    add();
    // the counter should now be 3, but it does not work !

JS 支持 nested functions 内嵌函数，all functions have access to the scope "above" them。所以函数有权获取他们上层的 scope。

A closure is a function having access to the parent scope, even after the parent function has closed。闭包是指一个有权获取父 scope 的函数，即使在父函数已经关闭的情况下。下面的例子使用闭包，解决了计数的问题。

    var add = (function () {
            var counter = 0;
            return function () {return counter += 1;}
        })();
    add();
    add();
    add();
    // the counter is now 3

结合上面提到的自调用解释一下：

1. 自调用函数 only runs once 执行一次，初始化变量 counter 赋值为0.
2. 将无名函数返回并赋值给变量 add
3. 变量 add 成为一个可以获取父 scope 中变量 counter 的函数
4. The counter is protected by the scope of the anonymous function（我认为这里指的是父函数）, and can only be changed using the add function
