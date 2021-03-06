---
title:  "ECMAScript 6 入门读书笔记"
category: JavaScript
---
[在线电子书及相关讨论地址：](http://es6.ruanyifeng.com/#docs/let)

## let 命令

声明块级变量。

+ `let` 命令只在其所在的代码块(由一对大括号限制起来的区域)内有效。
+ 如果有代码块嵌套，外层代码块使用 `let` 声明的变量，不受内层代码块的影响。
+ 不像 `var`，该命令不引起变量提升（Hoisting）。提前使用未声明的变量，报错。
+ **不允许**使用 `let` 在同一个代码块内**重复声明**同一个变量，会报错 duplicate declaration。
+ 那如果使用 `var` 和 `let` 重复声明同一个变量呢？

    {
      let a = 10;    // a = 10
      var a = 1;     // a = 10
    }
    {
      var a = 1;     // a = undefined
      let a = 10;    // a = 10
    }

<!--more-->

### 块级作用域

块级作用域外部，无法调用块级作用域内部定义的函数。

ES6规定，如果区块中存在 let 和 const 命令，这个区块对这些命令声明的变量，从一开始就形成了封闭作用域。凡是在声明之前就使用这些变量(即使有同名的全局变量存在)，就会报错。

## const 命令

该命令用于声明常量。在声明的块里可见。

其作用范围可以是全局的，也可以是声明块的本地。 

与 var 变量不同，全局常量不会成为窗口对象的属性。 

一个常量的初始化是必需的;也就是说，你必须在它声明的同一个语句中指定它的值。

const 声明为一个值创建了一个只读 reference 引用。

这并不意味着它是 immutable 不可变的，只是变量标识符**不能被重新分配**。 例如，在内容是对象的情况下，对象的内容（例如，其参数）可以被改变。

    const a = [1, 2, 3];
    a.push(102); // [1, 2, 3, 102]
    a[0] = 101;  // [101, 2, 3, 102]
    a = [3];     // Uncaught TypeError: Assignment to constant variable.

+ 变量一旦声明和初始化，其值不可再次改变。
+ 如果只声明，没有赋值初始化，以后也没法重新赋值。
+ 只在声明所在的块级作用域内有效.
+ 该命令声明的常量也是不提升。
+ 受 `var` 、 `let` 命令声明的变量限制，不可重复声明同名常量。
+ 对于 `const` 声明的常量，如果是一个对象，储存的是一个地址，不可变的只是这个地址，但对象本身是可变的，依然可以为其添加新属性。
+ 如果真的想将对象冻结，使用 `Object.freeze` 方法。

### 全局对象的属性

全局对象是最顶层的对象，在浏览器环境指的是 window 对象，在 Node.js 指的是 global 对象。

ES6规定，`var` 命令和 `function` 命令声明的全局变量，依旧是全局对象的属性；`let` 命令、`const` 命令、`class` 命令声明的全局变量，**不属于**全局对象的属性。

## 数组的解构赋值

ES6允许按照一定模式，从数组和对象中提取值，按照对应位置，对变量进行赋值，这被称为解构赋值（Destructuring Assignment）。

+ 其实相当于 array matching，等号左右两边都是数组。
+ 如果等号右边不是数组（不可遍历的结构），会报错。
+ 解构不成功，等号左边的变量在右边没有找到匹配的，变量的值就等于 `undefined`。
+ 不完全解构，即等号左边的模式，只匹配一部分的等号右边的数组。这种情况下，解构依然可以成功.

    let [x, y, ...z] = ['a'];
    x // "a"
    y // undefined
    z // []

###  Fail-Soft Destructuring 带默认值的解构

当等号右边对应位置上的数组成员严格等于 (`===`) undefined，左边数组的默认值是才会生效。

    var [x = 1] = [undefined];
    x // 1
    var [x = 1] = [null];
    x // null

## 对象的解构赋值 Destruction Assignment

对象的解构与数组有一个重要的不同。数组的元素是按次序排列的。对象的属性没有次序，变量必须与属性同名，才能取到正确的值。

    var { bar, foo } = { foo: "aaa", bar: "bbb" };
    foo // "aaa"
    bar // "bbb"

对象的解构赋值的内部机制，是先找到同名属性，然后再赋给对应的变量。<span class="t-blue">真正被赋值的是后者(同名属性的属性值对应的变量)，而不是前者</span>。

    var { foo: baz } = { foo: "aaa", bar: "bbb" };
    baz // "aaa"
    foo // error: foo is not defined

对象的解构也可以指定默认值。

和数组一样，解构也可以用于嵌套结构的对象。

    var obj = {
      p: [
        "Hello",
        { y: "World" }
      ]
    };
    var { p: [x, { y }] } = obj;
    x // "Hello"
    y // "World"


### super

Class之间可以通过 `extends` 关键字实现继承。

`super` 关键字，指代父类的实例（即父类的this对象）。子类没有自己的 this 对象，而是继承父类的this对象，然后对其进行加工。

ES6的继承机制，实质是先创造父类的实例对象 this（所以必须先调用super方法），然后再用子类的构造函数修改 this。

## Arrow functions 箭头函数

当我们使用箭头函数时，函数体内的 **this** 对象，就是定义时所在的对象，而不是使用时的对象。

+ 没有自己的 arguments 对象！！
+ 没有 prototypes
+ 不能被用做 constructor
+ 大于1个入参时，`()` 是必须的
+ 当使用箭头函数缺省 `{}` 时，可省掉 `return` 关键词（这是implicit return）

## Template literals 模板字符串

再不必使用一堆加号来连接大段的字符串、HTML标签和变量了，只需要使用<code>\`</code>把字符串框起来, 通过 `${}` 引用变量。

## 函数参数默认值（Default function parameters）

定义函数时，在形参里直接赋值。

```js
function multiply(a, b = 1) {
  return a * b;
}

// Safari 10以下不支持，可以这样写
function multiply(a, b) {
  b = (typeof b !== 'undefined') ?  b : 1;
  return a * b;
}
```