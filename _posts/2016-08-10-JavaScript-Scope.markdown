---
title:  "JavaScript Scope"
category: JavaScript
---
Scope is the set of variables, objects, and functions you have access to. 你可以获取的变量、对象和函数的集合称为 scope **作用域**。

JS 的 block 没有作用域，只有 functions 有作用域。

## Global Scope

通过全局作用域创建 Modules/APIs 实现功能复用。

    jQuery('.myClass');

上面的代码表示在全局作用域里使用 jQuery，并作为 jQuery 函数库的命名空间 **namespace**（通常指最高一层作用域）。

## Local Scope

每个定义的函数都有自己的局部作用域，local scope 可以层层嵌套。

Whenever JavaScript executes a function, a 'scope' object is created to hold the local variables created within that function.无论何时执行一个函数，一个scope对象被创建，用于保存那个函数内部创建的局部变量。

<!--more-->

Any locally scoped items are not visible in the global scope - **unless exposed**，局部作用域里的东西对全局作用域不可见，除非对外暴露。

在函数内部以 **var** 关键字声明的变量，就是局部变量。声明在函数外部的变量，就是全局变量。

## Function Scope

All scopes in JavaScript are created with Function Scope **only**，JS中所有作用域只能由**函数作用域**创建。

而不是由 for，while，或者 if，switch 等表达式语句创建。

## Lexical Scope / Closures

在一个函数内声明的函数称为 Inner functions，能够使用 outer 父函数的作用域，这称为**词法作用域**或**闭包**，也叫 Static Scope **静态作用域**。

任何定义在**父作用域**的变量、对象、函数，在作用域链上都是可用的。反之，则不然。

如果一个调用函数所依赖的少数函数对于其他代码没用，建议写在函数内，减少全局函数个数总是好的。

### Scope Chain

任何定义在其他函数里的函数有一个局部作用域 linked to 外部函数。这个 link 叫做 chain **作用域链**。代码里的位置决定了作用域。

当我们访问一个变量的时候，JavaScript 从最里面的作用域沿着作用域链向外部开始查找，直到找到我们想要的那个变量/对象/函数。

### Closure 闭包

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

一个能展现**闭包**是如何起作用的例子，就**是返回一个函数索引**。

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

1. 自调用函数 only runs once，初始化变量 counter 赋值为0
2. 将无名函数返回并赋值给变量 add
3. 变量 add 成为一个可以获取父 scope 中变量 counter 的函数
4. The counter is protected by the scope of the anonymous function（我认为这里指的是父函数）, and can only be changed using the add function

### 其他

在 HTML 中，全局 scope 就是窗口对象，因此 all global variables belong to the window object.

+ 局部变量只可以被定义它的函数使用，可以与全局变量重名。
+ 不使用关键字 **var** 创建的变量, are always global, 即使写在一个函数内部，也自动变为全局变量。
+ 只要你的应用（浏览器窗口或网页）在运行，全局变量就存在。
+ 局部变量在函数调用时创建，在函数执行结束时删除。
+ function argument 函数参数作为局部变量在函数内被使用。

## Changing scope with .call() .apply() 和 .bind()

有时需要改变作用域来进行操作，实现一些目标。看下例：

```js
var links = document.querySelectorAll('nav li');
for (var i = 0; i < links.length; i++) {
  console.log(this); // [object Window]
}
```

因为并没有 invoke 什么或者改变作用域，这里的 this 指的就是默认的全局作用域中拥有这段js的 window 对象。

使用 .call() 和 .apply() 可以把一个作用域传进函数中。<span class="t-blue">改变运行时的 scope</span>

```js
var links = document.querySelectorAll('nav li');
for (var i = 0; i < links.length; i++) {
  (function () {
    console.log(this); // each element in the array
  }).call(links[i]);
}
```

两者的区别在 JS Functions 章节已经讲过.

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

上面的办法改变了作用域，但是写了一个没什么用的函数。使用 `.bind()` 不同于 call 和 apply，不会 invoke 一个函数（即立即执行）。<span class="t-blue">改变定义时的 scope</span>

    nav.addEventListener('click', toggleNav.bind(scope, arg1, arg2), false);

此外，还可以借助**闭包**实现定义时改变上下文。

```js
function A() {
  init: function() {
    this.$element.on('click', this._switchThis(this.ajaxSubmit, this))
  },
  _switchThis: function (fn, obj) {
      return function () {
          fn.apply(obj, arguments)
      }
  },
  ajaxSubmit: function () {}
}
```

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

这里将返回对象赋给 Module，可以被全局作用域使用。Module 作为命名空间，其包含的方法作为公有函数使用。

没有写在 `return` 所含对象中的方法，就变成了私有函数(方法)。

下面举例如何通过返回一个对象，使用公有和私有的方法。

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
