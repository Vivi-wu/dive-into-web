---
title:  "JavaScript Objects"
category: JavaScript
---
在JS中，除了 **primitive values**（string "John Doe"，numbers 3.14，true，false，null and undefined），所有值都是 objects。

JS对象是可以包含多个值的变量。这些值以 `name:value` 对的形式、**逗号**为分隔符（最后一个值后面没有逗号）。

## 创建对象

1.Using an Object Literal，最简单的方法

同数组一样，空格和换行不重要。

    var person = {firstName:"John", lastName:"Doe", age:50};
    var person = {
        firstName:"John",
        lastName:"Doe",
        age:50
    };

<!--more-->

2.Using the JavaScript Keyword **new**

    var person = new Object();
    person.firstName = "John";
    person.lastName = "Doe";
    person.age = 50;

以上两种方法做的都是一样的事，为了简单、易读和执行速度，选用第一种方法。

3.Using an **Object Constructor**

有时我们希望使用 **an object type** 一种对象类型，创建多个对象。这时可以使用一个构造函数来创建相同类型的对象。

    function person(first, last, age, eye) {
        this.firstName = first;
        this.lastName = last;
        this.age = age;
    }
    var myFather = new person("John", "Doe", 50);
    var myMother = new person("Sally", "Rally", 48);

### _this_ keyword

JS中被称为 this 的东西 is the object that "owns" the JavaScript code。

+ when used in a **function**, is the object that "owns" the function.
+ when used in an **object**, is the object itself.
+ when used in an **object constructor**, is only a substitute 替代 for the new object. The value of `this` will become the new object when the constructor is used to create an object. 构造函数里的 this 没有值，当函数被用来创建新的对象时，this 的值就是新的对象。

我们还可以在 HTML 元素的 event 事件绑定里使用 _this_，指的是触发事件的对象。（JS Event Order 章节有提到）

    <h1 onclick="this.innerHTML='Ooops!'">Click on this text!</h1>
    <h1 onclick="changeTest(this)">Click on this text!</h1>


### JavaScript Objects are Mutable

JS对象是易变的，由 reference 获取，而不是 value。

    var person = {firstName:"John", lastName:"Doe", age:50, eyeColor:"blue"}
    var x = person;
    x.age = 10;           // This will change both x.age and person.age

x is **not a copy** of person. It **is** person. Both x and person points to the **same** object。因为它们都指向同一个对象。

## JavaScript Object properties

JS对象是一系列无序属性的集合。

这些 name:value 称为 **properties** 属性。

**获取对象的属性有两种方法**：`objectName.propertyName` 或者 `objectName["propertyName"]`

后者也可以使用 expression 表达式：`objectName[expression]`，只要表达式被评估是属性的 name。

+ add 属性，对已经存在的对象，用获取属性的方法，给这个属性赋值即可。
+ delete 属性，使用关键字 **delete**。

      delete person.age;   // or delete person["age"];

该操作不仅删掉了属性的值，也删掉了属性本身。

The delete operator is **designed** to be used on **object properties**. <span class="blue-text">It has no effect on variables or functions. 删除操作符专为对象属性设计，对于变量和函数没有效果</span>。

The delete keyword does **not** delete inherited properties, but if you delete a prototype property, it will affect all objects inherited from the prototype. 删除操作符不会删掉所继承的父类属性，但是如果你删掉了一个 prototype 属性，它会影响所有继承这个原型的对象。

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

注意：不用改变标准JS对象的原型。
