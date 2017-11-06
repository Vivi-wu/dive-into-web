---
title:  "JavaScript Objects"
category: JavaScript
---
在JS中，除了 **primitive values**（string "John Doe"，numbers 3.14，true，false，null and undefined），所有值都是 objects。

因此 <span class="t-blue">all data types have a `valueOf()` 和 `toString()` 方法</span>.

JS对象是可以包含多个值的变量。这些值以 `name:value` 对的形式、**逗号**为分隔符（最后一个值后面没有逗号）。

## 创建对象

1.Using an Object Literal，最简单的方法

同数组一样，空格和换行不重要。

```js
var person = {firstName:"John", lastName:"Doe", age:50};
var person = {
    firstName:"John",
    lastName:"Doe",
    age:50
};
```

<!--more-->

2.Using the JavaScript Keyword **new**

    var person = new Object();
    person.firstName = "John";
    person.lastName = "Doe";
    person.age = 50;

以上两种方法做的都是一样的事，为了简单、易读和执行速度，选用第一种方法。

3.Using an **Object Constructor**

有时我们希望使用 **an object type**，创建多个对象。这时可以使用一个构造函数来创建相同类型的对象。

```js
function person(first, last, age) {
    this.firstName = first;
    this.lastName = last;
    this.age = age;
}
var myFather = new person("John", "Doe", 50);
var myMother = new person("Sally", "Rally", 48);
```

### new 关键字

参看[这里](https://zhuanlan.zhihu.com/p/23987456)解释得简单易懂。

```js
function A (arg) {
    var tmp = {};  // 1.创建临时空对象
    tmp.prototype = A.prototype  // 2.把构造函数的原型赋给临时对象的原型
    tmp.arg = arg
    return tmp  // 3.返回这个临时对象
}
A.prototype = {
    prop: propvalue,
    func: function(){}
}
```

构造函数 A 可以简写成：

    function A (arg) {this.arg = arg} // this 指向临时对象，与下面解释关键字this用法的观点一致

`new A('参数')` 中的 new 所做的事情就是上面数字标记注释的三个步骤。

### _this_ keyword

JS中被称为 this 的东西就是<span class="t-blue explain" title="the object that &quot;owns&quot; the JavaScript code">拥有 JS 代码的对象</span>。

默认情况下，this 指的是全局对象 `window`。

+ when used in a **function**, 指的是拥有这个函数的对象。
+ when used in an **object**, 就是对象本身。
+ when used in an **object constructor**, is only a substitute 替代 for the new object. 构造函数里的 this 本没有值，<span class="explain" title="The value of this will become the new object when the constructor is used to create an object.">当函数被用来创建新的对象时，this 的值变为新对象</span>。
+ 还可以在 HTML 元素事件绑定里使用 _this_，指的是触发事件的 HTML DOM element。（JS Event Order 章节有提到）

### JavaScript Objects are Mutable

JS对象是易变的，由 reference 获取，而不是 value。

    var person = {firstName:"John", lastName:"Doe", age:50, eyeColor:"blue"}
    var x = person;
    x.age = 10;           // This will change both x.age and person.age

x is **not a copy** of person. It **is** person. Both x and person points to the **same** object。因为它们都指向同一个对象。

## JavaScript Object properties

JS对象是一系列无序属性的集合。

这些 name:value 称为 **properties** 属性。

**获取**对象的**属性**有两种方法：`objectName.propertyName` 或者 `objectName["propertyName"]`。

后者也可以使用 expression 表达式：`objectName[expression]`，只要表达式被评估是属性的 name。

如果对象中**不含**要找的属性，则返回 `undefined`。

+ **添加**属性，对已经存在的对象，用获取属性的方法给这个属性赋值即可。
+ **删除**属性，使用关键字 **delete**。

      delete person.age;   // or delete person["age"];

该操作<span class="t-red">不仅删掉了属性的值，也删掉了属性本身</span>。

### delete 操作符

The `delete` operator is **designed** to be used on **object properties**.

关于返回值：

1. 删除成功返回 true，失败返回 false。在 `"use strict";` 模式下不能删除的情况 raise _SyntaxError_。
2. 删除一个对象里**不存在的属性**，并没有什么效果，也<span class="t-red">返回 true</span>。
3. 只对自己的属性有效，删除不会影响该对象原型链上的同名属性。
4. 任何**通过 `var` 声明**的属性，不能被从 global 作用域或一个函数的 local 作用域里删除：

    + 不通过 `var` 声明的属性可以被删除
    + 全局作用域不能删除函数
    + 作为一个对象的函数可以被删除

5. 使用 `let` 或 `const` 声明的属性**不能**被删除（from the scope within which they were defined）。
6. 不可配置的属性不能被删除。包括，内置对象 `Math`, `Array`, `Object`，以及通过 `Object.defineProperty(...,...,{configurable: false})` 方法创建的不可配置属性。`delete` 删除没有什么效果，返回 false。

## JavaScript Object methods

JS对象要执行的操作，存放在 properties 里作为 **function definition** 函数定义。

+ 创建对象的方法：`methodName : function() { code lines }`
+ 获取对象的方法：`objectName.methodName()`
+ 给 existing 对象添加新方法：`objectName.methodName ＝ function() { code lines };`

The methodName property will execute (as a function) when it is invoked with `()`. 在后面加括号，这个属性将作为一个函数来执行。

如果不加后面的 `()`，则返回 function definition 函数定义。

## JavaScript Object Prototypes

使用 an object constructor function 对象构造函数，创建对象的原型。如上面的例子中，构造函数就是 person 对象的原型。

All JavaScript objects inherit the properties and methods from their prototype. 所有JS对象从它们的原型，继承属性和方法。

用 new 关键字创建的对象，继承该类对象的原型，如 new Date()，继承 `Date.prototype`。

The `Object.prototype` is on the top of the prototype chain. 所有对象都继承 Object.prototype

Prototype properties can have prototype values (default values) 原型的属性可以有默认值。

### 给对象添加属性或方法

+ add new properties (or methods) to an existing object. 给现存的对象添加属性或方法，很简单，上面有讲。
+ add new properties (or methods) to all existing objects of a given type.
+ add new properties (or methods) to an object prototype.

后两种情况可以使用（1）直接把新的属性或方法写在构造函数里。（2）使用 _prototype_ 属性。

    person.prototype.nationality = "English";
    person.prototype.name = function() {
        return this.firstName + " " + this.lastName;
    };

注意：最好不要改变标准JS对象的原型。若创建新属性，首先确认原型里不存在。

### for...in 语句

以 arbitrary order （任意顺序）遍历对象的属性。对于每一个 distinct 不同的属性，该语句都可以被执行。

用法：

    for (variable in object) {...
        // 在一趟遍历中每一个不同的属性名称被赋值给 _variable_
    }

### 操作‘对象属性’可用的方法

1. `Object.getOwnPropertyNames(obj)` 和 `Object.keys(obj)`，两者返回 obj 对象中由所有属性的名称（string）所组成的数组。注意：两者 IE9 以下都不支持。
2. `obj.hasOwnProperty(prop)`，该方法返回 boolean 值，表示 obj 对象中是否含有指定的属性。

## 对象的复制

1.使用 `Object.assign(target, ...sources)` 方法返回 target 对象，只复制源对象 property 的值。

+ 如果 source 属性值是指向某对象（内嵌子对象）的 reference，将只复制 reference 的值（即，此方法**不能做到深度复制**，源对象中的子对象属性值变化，会同时改变复制对象中同名子对象的同名属性值）
+ 按**从左到右**的顺序依次复制和重写属性值（最右边的 override 前面所有）
+ 不复制 non-enumerable、在原型链上的属性
+ 遇到 exception 时中断 copying 任务（如遇到 read-only 的属性时，throw exception）

2.使用 `JSON.parse(JSON.stringify(sourceObj))` 可以做到**深度复制**。缺点是任何不符合 JSON 规范的值都将丢失：

+ 不能复制属性值为 function 的 属性
+ 不能复制属性值为 _undefined_ 的属性（值为 _null_ 可以）
+ 属性值为 JS Date 对象的复制结果变为 ISO 标准日期格式（YYYY-MM-DDTHH:mm:ss.sssZ）的字符串
