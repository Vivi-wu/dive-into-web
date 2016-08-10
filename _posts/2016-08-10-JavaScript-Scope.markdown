---
title:  "JavaScript Scope"
category: JavaScript
---

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
