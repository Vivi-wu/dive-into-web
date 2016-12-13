---
title:  "JavaScript Strict Mode and Best Practices"
category: JavaScript
---
## "use strict";

这不是一条语句，而是一个 literal 表达式，被 ECMAScript 5 之前版本的 JS 忽略。其作用是指令代码需要在严格模式下执行。

使用 strict mode，使得原先可以接受的 “bad syntax” 变成了真正的 error。

### 声明

1. 在 JS 文件最开始的地方声明，则表示所有代码将在严格模式下被执行。
2. 在 function 内部最开始的地方声明，则只有该函数内的代码需要在严格模式下被执行。

<!--more-->

### Not Allowed in Strict Mode

1. 不声明，就使用一个变量或对象。（非严格模式下，这个变量会自动变为全局变量，现在则会报错）
2. 使用 `delete` 操作符删除一个变量或对象、函数
3. 函数中出现重复的**形式参数名**
4. Octal numeric literals 不允许八进制常量
5. 不可以给对象中，属性定义 writable 为 false 的属性赋值
6. 也不可以给 get-only 的属性（比如一个只可以 return 值的函数）赋值
7. 删除一个 undeletable 的属性
8. 保留字 _eval_, _arguments_, _implements_, _interface_, _let_, _package_, _private_, _public_, _protected_, _static_, _yield_ 
9. 不允许使用 `with` 语句

## 最佳实践

### 避免 Global 变量

+ 最少程度地使用全局变量，因为全局变量可以被其他 scripts 重写，相对地，使用局部变量和使用闭包（参考 JS function closure 内容）
+ 函数中所有的局部变量，必须使用 `var` 提前声明
+ 尽管 JS 默认会把所有 declarations 移到顶端 （JS Hoisting），自己在写的时候，在最上面书写所有声明
+ <span class="t-blue">最好在声明变量的时候，就初始化赋值</span>，这样可以提供一目了然的 intended use（intended data type），避免 undefined 值

### 避免使用 `new`

总是将 Number、String or Boolean 类型的变量视为 primitive values，不要使用 `new` 来初始赋值。见下例：

    var x = "John";             
    var y = new String("John");
    (x === y) // is false because x is a string and y is an object.

所有类型变量的初始赋值：

```js
var x1 = {};           // new object
var x2 = "";           // new primitive string
var x3 = 0;            // new primitive number
var x4 = false;        // new primitive boolean
var x5 = [];           // new array object
var x6 = /()/;         // new regexp object
var x7 = function(){}; // new function object
```

### 小心变量类型的自动转换

JS data type 是松散的类型。比如一个数字变量和一个字符串变量相加，加号视为字符串链接操作符，结果变为字符串。

```js
var x = 5 + 7;       // x.valueOf() is 12,  typeof x is a number
var x = 5 + "7";     // x.valueOf() is 57,  typeof x is a string
var x = "5" + 7;     // x.valueOf() is 57,  typeof x is a string
var x = 5 - 7;       // x.valueOf() is -2,  typeof x is a number
var x = 5 - "7";     // x.valueOf() is -2,  typeof x is a number
var x = "5" - 7;     // x.valueOf() is -2,  typeof x is a number
var x = 5 - "x";     // x.valueOf() is NaN, typeof x is a number
var x = "Hello" - "Dolly";    // returns NaN
```

### 使用 === 进行比较

因为 `==` 操作符总是<span class="t-blue">在比较前将操作符两边的变量进行转换</span>（to matching types），所以是不严格的比较。

### 给函数形参设定 default 值

如果调用函数时少传递了一个参数，这个 miss 掉的参数就会被赋值为 undefined，可以向下这样处理：

    function myFunction(x, y) {
        if (y === undefined) {
            y = 0;
        }
    }

ES6允许为函数的参数设置默认值，即直接写在参数定义的后面 `function log(x, y = 'World')`

### 避免使用 `eval()`

该函数用来将 text 作为 JS code 允许其执行。因为它允许任何代码执行，会带来安全问题。

### 减少 loop 里的操作

循环中的每一条语句，包括 for 语句，在每一次循环遍历时都要执行一遍。

```js
var i, l, arr = [];
l = arr.length;
for (i = 0; i < l; i++) {｝
```

把获取数组长度代码放在循环之外，使得循环执行更快。

### 减少 DOM 获取操作和 DOM 大小

保持 HTML DOM 里面的元素数量少而精，可以提高页面加载、渲染速度。

比起其他 JS 语句，获取 HTML DOM 速度慢，如果需要多次获取一个 DOM 元素，最好获取一次，然后作为局部变量来使用。

    obj = document.getElementById("demo");
    obj.innerHTML = "Hello";

### 减少不必要的变量

如果你不打算使用变量来保存数值，不要创建新的变量。

### 推迟 JS 加载

把 JS 文件放在页面底部，让浏览器先加载页面。因为下载脚本时，浏览器不会开始其他的下载了，所有的解析、渲染可能被 blocked。

如果可能，可以在页面加载完之后，通过代码把脚本加进来。

```html
<script>
window.onload = downScripts;

function downScripts() {
    var element = document.createElement("script");
    element.src = "myScript.js";
    document.body.appendChild(element);
}
</script>
```

也可以在 script 标签里添加 `defer="true"`，该特性 specifies that the script should be executed after the page has finished parsing, but it **only works for external scripts**.
