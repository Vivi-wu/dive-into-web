---
title:  "HTML5应用开发实践指南"
category: HTML,CSS,JavaScript
---
## JavaScript的力量

推荐阅读《JavaScript语言精粹》（JavaScript, The Good Parts, Douglas Crockford），《JavaScript权威指南》（Javascript: The Definitive Guide, David Flanagan），《高性能JavaScript编程》（High Performance JavaScript, Nicholas C.Zakas），《JavaScript模式》（JavaScript Patterns, Stoyan Stefanov）

因为JS是单线程的，如果函数被阻塞，用户界面就冻结了。所有JS要采用不同于传统语言处理I/O

事件驱动编程。操作异步，先在某个地方创建操作，当外部事件发生后再执行。JS中所有外部的I/O（数据库，调用服务器）都应该是非阻塞的，学习使用闭包和回调至关重要。

在 C 和类似的语言中，函数和数据作用于两个独立的空间。而在JS中，**函数就是数据**，可以用在每一个可以使用数据的地方：函数可以分配给一个变量、作为参数传递、作为函数的返回值，另外还可通过简单的赋值改变函数。

### 闭包

本书中使用 jQuery 编写示例，下面的例子，外层函数将内层函数作为返回值返回。这个例子的结果是把变量 updateElement 的值设为内层 set() 函数。当一个程序调用 updateElement 并传入 CSS 选择器后，updateElement 会返回一个可用来设置**被该选择器选中的HTML元素**的内容的函数。<- <- 有的绕

```js
// 例 2-5
var updateElement = function factory(el) {
  return function set(html) {
    $(el).html(html)
  };
};
updateElement($('body'))('Hello world.')
```

再看一个例子，创建多个在同一空间内的关闭的函数。如果一个函数把多个函数返回到一个对象或数组中，所有这些函数都有机会获得创建函数的内部变量。

    // 例 2-6
    function Ready(){
      var button, tools;
      tools = ['save', 'add', 'delete'];
      console.info($('body'));
      tools.forEach(function(tool){
        console.info(tool);
        var button = $('<button>').text(tool).attr({type: 'button'}).css({position: 'relative'}).appendTo('body');
        button.click(function clickHandler(){
          console.info(tool, button);
          alert('User clicked '+tool);
        })
      })
    }
    $('document').ready(Ready);

## 函数式编程

基本假设：

+ 函数可以在任何能使用其他值的地方使用它
+ 可通过组合简单的函数构建复杂的行为
+ 函数有返回值，多数情况下，对于同样的输入可定函数总是返回相同的值

JS 函数默认不返回值，除非使用 `return` 语句。无返回语句时，函数返回 `undefined`。

可以用简单的函数生成一个函数连，使链中的每个函数都返回 `this`，从而允许调用下一个函数。参考 jQuery 的链式调用。多数jQuery方法返回一个值，使它们能够被链接。

下例选择页面中所有图片，过滤掉宽度小于 300px 的，然后按比例缩放列表中剩下的图片。

    // JavaScript
    var max = 300;
    var scaleImages = (function (maxWidth) {
      return function() {
        $('img').filter(function(){
          return $(this).width() > maxWidth;
        }).each(function(){
          $(this).width(maxWidth);
        });
      };
    })(max);
    // HTML
    <button type="button" onclick="scaleImages()">缩放</button>

### 原型及扩展对象

下面方法通过给 String.prototype 添加方法实现模板插值。一般情况下，最好不要修改调用了方法的对象，但是要返回一个新的对象实例。

    String.prototype.populate = function (params) { // 也可以是有名函数
      var str = this.replace(/\{\w+\}/g, function (match) { // 以第一个匹配作为实参；也可以是有名函数
        var text = params[match.substr(1, match.length-2)]; // 考虑到传入对象中不含关键字，text 为 undefined 的情况
        return text ? text : '';
      });
      return str;
    };

    $(function(){
      $('p').html('Hello {name}'.populate({
        name: "Vivienne"
      }));
    })

### 用原型扩展函数

给 **Function 对象**添加方法，如下例，在函数执行之前添加错误检查，提高代码的健壮性。

注意：书上写的是 `return this.apply(scope, arguments)`，而函数是没有状态的，这里的 `this` 指什么它找不到。

需要在函数外部把执行时的 this （参考JS object章节，当 this 用在函数内，它指拥有这个函数的对象）传进来。

    Function.prototype.createInterceptor = function createInterceptor(fn) { // 也可以是无名函数
      var scope = {};
      var _this = this;    // 运行时，此处的 this 指拥有 createInterceptor() 函数的对象
      return function() {
        if (fn.apply(scope, arguments)) {
          return _this.apply(scope, arguments);    // 因为JS函数本身是对象，此处运行时指 function interceptMe(x){}
        } else {
          return null;
        }
      }
    }

    var interceptMe = function (x) { // 也可以是有名函数
      console.info(x);
      return Math.pow(x, 3);
    };

    var cube = interceptMe.createInterceptor(function(x) {
      return typeof x === 'number';
    });

    cube(3)    // 27
    cube('test')  // null

### 柯里化和对象参数

柯里化（currying）是指将几个参数组合成一个单一对象，作为参数传递给函数。好处是，函数不需要写很长的参数列表，参数顺序不重要，可以建立一套默认值（不必每次指定），允许调用者改变想要修改的任何参数。

没看懂。。。。

### 数组迭代操作

例2-18 和例2-19 比较 `for` 循环和数组的 `forEach()` 方法在给数组中每个元素绑定事件的区别。

这里提一下如何把 jQuery 选择器得到的 jQuery 对象组成的列表（typeof 这个列表得到类型是 object，用 Array.isArray() 检查，结果是 false，但它可以用 for 循环语句遍历）转换成 JS array：借助 jQuery 的 `toArray()` 方法，return the DOM Elements as an Array。

    // HTML
    <ul id="unorderList">
      <li>1</li>
      <li>2</li>
      <li>3</li>
      <li>4</li>
    </ul>
    // JavaScript
    var $li = $('#unorderList li')
    $li.toArray().forEach(function(element){
      $(element).bind('click', function(){
        console.info(element);
      });
    });

## 测试 JavaScript 应用

单元测试，一次测试一个功能。遵循的准则是，对任何特定的函数、方法或接口，如果给定的输入是 x 那么程序应该执行的功能就是 y。每个单元测试理论上只测试一个方法或一小块代码。

集成测试，用于确保整个系统按照之前设计的方案运行良好。比如模拟浏览器中用户点击了一个按钮，然后数据库里的记录是否被更新，从而验证整个系统是否可以协同工作。

JavaScript 中的测试步骤：

1. 设置所需的测试套件
2. 运行要测试的方法
3. 等待一个 Ajax 调用完成
4. 为动作的结果检查 DOM

可用的测试库或工具有：QUnit、Selenium. 作者花了大量篇幅写如何使用 Selenium 测试，真的不是夹杂私货??

