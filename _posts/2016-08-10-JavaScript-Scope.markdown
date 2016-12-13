---
title:  "JavaScript Scope"
category: JavaScript
---
Scope is the set of variables, objects, and functions you have access to. 你可以获取的变量、对象和函数的集合称为 scope **作用域**。

当一个函数在 JS 中创建时，该函数可以对其生成环境中任何语法空间的变量进行访问。

## Global Scope

通过全局作用域创建 Modules/APIs 实现功能复用。

    jQuery('.myClass');

上面的代码表示在全局作用域里使用 jQuery，并作为 jQuery 函数库的命名空间 **namespace**（通常指最高一层作用域）。

## Local Scope

每个定义的函数都有自己的局部作用域，local scope 可以层层嵌套。

<!--more-->

Any locally scoped items are not visible in the global scope - **unless exposed**，局部作用域里的东西对全局作用域不可见，除非对外暴露。

在函数内部以 **var** 关键字声明的变量，就是局部变量。声明在函数外部的变量，就是全局变量。

## Function Scope

All scopes in JavaScript are created with Function Scope **only**，JS中所有作用域只能由**函数作用域**创建。

而不是由 for，while，或者 if，switch 等表达式语句创建。

## Lexical Scope / Closures

嵌套在一个函数中的 inner 函数，能够使用 outer 函数的作用域，这称为**词法作用域**或**闭包**，也叫 Static Scope **静态作用域**。

Any variables/objects/functions defined in its parent scope, are available in the scope chain. 任何定义在**父作用域**的变量、对象、函数，在作用域链上都是可用的。反之，则不然。

### Scope Chain

任何定义在其他函数里的函数有一个局部作用域 linked to 外部函数。这个 link 叫做 chain **作用域链**。代码里的位置决定了作用域。

当我们访问一个变量的时候，JavaScript 从最里面的作用域沿着作用域链向外部开始查找，直到找到我们想要的那个变量/对象/函数。

### 闭包实例

下面的例子中要实现计数加1的功能，但因为局部变量的生命周期只维持在函数调用期间，所以无论调用多少次 add 函数，结果都是 1.

```js
function add() {
    var counter = 0;
    counter += 1;
}
add();
add();
add();
// the counter should now be 3, but it does not work !
```

A better example of how the closure side of things works, can be seen when returning a function reference。能展现**闭包**是如何起作用的例子，就**是返回一个函数索引**。

Inside our scope, we can return things so that they’re available in the parent scope。

Simply accessing variables outside of the immediate lexical scope creates a closure. 获取词法作用域外最近的变量形成了闭包。

下面的例子使用闭包，解决了自增计数的问题。

```js
var add = (function () {
    var counter = 0;
    return function () {return counter += 1;}
})();
add();
add();
add();
// the counter is now 3
```

结合上面提到的自调用解释一下：

1. 自调用函数 only runs once，初始化变量 counter 赋值为0.
2. 将无名函数返回并赋值给变量 add
3. 变量 add 成为一个可以获取父 scope 中变量 counter 的函数
4. The counter is protected by the scope of the anonymous function（我认为这里指的是父函数）, and can only be changed using the add function

### 其他

在 HTML 中，全局 scope 就是窗口对象，因此 all global variables belong to the window object.

+ 局部变量只可以被定义它的函数使用，可以与全局变量重名。
+ 不使用关键字 **var** 创建的变量, are always global, even if they are created inside a function，即使写在一个函数内部，也自动变为全局变量。
+ 只要你的应用（浏览器窗口或网页）在运行，全局变量就存在。
+ 局部变量在函数调用时创建，在函数执行结束时删除。
+ function argument 函数参数作为局部变量在函数内被使用。

## Changing scope with .call() .apply() 和 .bind()

有时需要对作用域进行操作实现一些目标。看下例：

```js
var links = document.querySelectorAll('nav li');
for (var i = 0; i < links.length; i++) {
  console.log(this); // [object Window]
}
```

因为并没有 invoke 什么或者改变作用域，这里的 this 指的就是默认的全局作用域中拥有这段js的 window 对象。

使用 .call() 和 .apply() 可以把一个作用域传进函数中。

```js
var links = document.querySelectorAll('nav li');
for (var i = 0; i < links.length; i++) {
  (function () {
    console.log(this); // each element in the array
  }).call(links[i]);
}
```

两者的区别在 JS Functions 章节已经讲过 .call(scope, arg1, arg2, arg3) takes individual arguments, comma separated, whereas .apply(scope, [arg1, arg2]) takes an Array of arguments。

以下两种方法等价。

    myFunction(); // invoke myFunction
    myFunction.call(scope); // invoke myFunction using .call()

### 使用 bind()

绑定事件处理函数时，有时会遇到需要传参数

```js
// works
nav.addEventListener('click', toggleNav, false);

// will invoke the function immediately
nav.addEventListener('click', toggleNav(arg1, arg2), false);

// 解决办法
nav.addEventListener('click', function () {
  toggleNav(arg1, arg2);
}, false);
```

但是上面的办法改变了作用域，还写了一个没什么用的函数。使用 .bind() 不同于 call 和 apply，不会 invoke 一个函数。

    nav.addEventListener('click', toggleNav.bind(scope, arg1, arg2), false);

Note:the scope can be changed if needed

## Private and Public Scope

JS 中没有私有域和共有域的说法，最简单的创建私有域的做法是，把函数写在另一个函数里。（如上面提到，函数创建 scope，将会把内容保持在全局作用域之外）

```js
(function () {
  // private scope inside here
  var myFunction = function () {
    // do some stuff here
  };
})()；
myFunction(); // Uncaught ReferenceError: myFunction is not defined
```

上面我们模拟出了私有作用域的效果，如何实现公有作用域呢？

```js
// define module
var Module = (function () {
  var privateMethod = function () {

  };
  return {
    myMethod: function () {
    },
    publicMethod: function () {
      // has access to `privateMethod`, we can call it:
      // privateMethod();
    }
  };
})();

// call module + methods
Module.myMethod();
Module.publicMethod();
```

这里 Module 被返回可以被全局作用域使用，并且作为命名空间，包含许多方法供我们使用。没有写在 `return` 所含对象中的方法，就变成了私有函数(方法)。

下面举例如何通过返回一个对象，使用公有和私有方法。

```js
var Module = (function () {
  var myModule = {};
  var privateMethod = function () {
  };
  myModule.publicMethod = function () {
  };
  myModule.anotherPublicMethod = function () {
  };
  return myModule; // returns the Object with public methods
})();

// usage
Module.publicMethod();
```

我们可以通过在方法**名字前加下划线**来区分私有方法和公有方法。
