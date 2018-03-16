---
title:  "JavaScript Data Types and Type Conversion"
category: JavaScript
---
JS 是一种 weakly-typed 语言。

+ 除了 **primitive values**： string（"John Doe"），numbers（3.14），Boolean（true/false），null，undefined 和 Symbol，所有值都是 objects。
+ 有**2**种不含 value 的类型：undefined，null

<!--more-->

## constructor Property

该性质**返回**所有JS变量的 **constructor 函数**。

```js
"John".constructor         // Returns function String()  { [native code] }
(3.14).constructor         // Returns function Number()  { [native code] }
false.constructor          // Returns function Boolean() { [native code] }
[1,2,3,4].constructor      // Returns function Array()   { [native code] }
{name:'John', age:34}.constructor  // Returns function Object()  { [native code] }
new Date().constructor       // Returns function Date()    { [native code] }
function () {}.constructor   // Returns function Function(){ [native code] }
```

<span class="t-blue">可以用来判断一个变量类型是否是 Array</span>，判断 Date 方法同。

```js
function isArray(myArray) {
  return myArray.constructor.toString().indexOf("Array") > -1;
}
// 用 prototype 类似
function isArray(myArray) {
  return Object.prototype.toString.call(myArray) === '[object Array]'
}
```

### Undefined

    var person;

此时，变量 person 的值是 undefined，typeof 结果也是 undefined。

    person = undefined;

经过上述操作，变量的值设为 undefined，类型 type 也变为 undefined。

### Null

JS中 `null` 表示什么都不是、不存在。<span class="t-blue">与 undefined 不同，`typeof null` 的结果是 `object`</span>。

    null == undefined;  // true
    null === undefined; // false

可以用 null 来**清空**一个 object 变量。当然用 undefined 来清空也是可以的，但是注意结果如前所述是有区别的。

`null` is for **objects**, `undefined` is for **variables**, **properties**, and **methods**.

### Test if an object exists

测试一个对象是否存在，必须如下先检查该对象是否被定义了。

```js
if (typeof myObj !== "undefined" && myObj !== null)
if (myObj !== null && typeof myObj !== "undefined")  // 这样写会 throw error exception，两句的区别见下面
var person = {};
typeof person;       // object
person.valueOf();    // [object Object]
(person !== null);   // true
typeof persons;      // undefined
(persons !== null);  // 浏览器报错，ReferenceError: Can't find variable: persons
```

## Type Conversion

JS 类型转换分为 implicit 和 explicit。开发者通过一些函数进行的转换称为 explicit type coercion。

因为JS变量是 dynamic 类型，可以在不同类型间自动变换，这种转换称为 implicit type coercion。

JS 中类型转换一共有**3种**规则：to string，to number，to Boolean。

注意查看 [Type Conversion Table](http://www.w3schools.com/js/js_type_conversion.asp)

### String conversion

1. explicit： `String(x)`
2. implicit： `123 + '3'`
3. 所有原始类型的值转为 string 的结果 naturally as expect
4. Symbol 只能进行 explicit 转换

注意：在JS输出时，会自动调用 toString() 方法。

```js
String({name:"Fjohn"})  // "[object Object]"
String([1,2,3,4])       // "1,2,3,4"
String(new Date())      // "Fri Mar 16 2018 11:20:16 GMT+0800 (中国标准时间)"
String(123)             // "123"
String(true)            // "true"
String(null)            // "null"
String(undefined)       // "undefined"
```

### Boolean conversion

1. explicit： `Boolean(x)`
2. implicit： 条件判断语句、逻辑运算符表达式(`||` `&&` `!`)

```js
Boolean('')           // false
Boolean(0)            // false
Boolean(-0)           // false
Boolean(NaN)          // false
Boolean(null)         // false
Boolean(undefined)    // false
Boolean(false)        // false
```

不在上面名单里的value都返回 true：`"0"` ，`"false"` ，`[]` ，`{}` ，`function(){}` ，`Symbol()`。

### Numeric conversion

1. explicit： `Number(x)`
2. implicit: 比较操作符、位操作符、数学运算符、单目 `+` 操作符、loose equality `==` 操作符
3. 字符转为数字时，先trim首尾的空格
4. Symbols不能转为 nubmer，报 TypeError
5. Date 转换可以使用 `Number()`, 或者 `getTime()` 函数，得到的是 milliseconds since January 1, 1970, 00:00:00

```js
Number(null)        // 0
Number(undefined)   // NaN
Number(true)        // 1
Number(false)       // 0
Number("true")      // NaN
Number(" 12 ")      // 12
Number("-12.34")    // -12.34
Number("\n")        // 0
Number(" ")         // 0
Number("")          // 0
Number(" 12s ")     // NaN
Number("99 88")     // NaN
```

#### 栗子

两个数字式字符串做比较：

    "2" > "12"  // true，because (alphabetically) 1 is less than 2
    2 < "12"    // true，"12" 转换成数字12进行了比较

为了保证正确的结果，在比较之前，需要把变量转换成合适的类型。

```js
age = Number(age);
if (isNaN(age)) {
    voteable = "Error in input";
} else {
    voteable = (age < 18) ? "Too young" : "Old enough";
}
```

单目运算符 `+`，把一个值转换成 Number 类型。

`-` 减号时，表示负数 reverse the sign.

    var y = "5";      // y is a string
    var x = + y;      // x is a number
    var z = "apple";
    x = +z;           // x is NaN

### Object 的类型转换

对象通过内置 `ToPrimitive(x, preferred type)` 方法先转为 primitive value，然后转为 final type，其中 preferred type 是 **可选的**。

假设 preferred type 为 string，转换基本步骤:

1. 判断 input 是否为 primitive, 如果是，则直接返回
2. Call input.toString(), 结果为 primitive 则返回
3. Call input.valueOf(), 结果为 primitive 则返回
4. 如果上述方法都不返回 primitive，则报 TypeError

如果 preferred type 为数字类型，则执行顺序为（3）——> (2)。

+ 例外：单目 `+` 操作符、loose equality `==` 操作符触发 default conversion mode，这种情况下大部分内置类型**默认**采用 numeric 转换
+ 例外： Date 类型采用 string 转换
+ 例外： _null_ 只能非严格等于 _null_ 或 _undefined_
+ 内置类型没有 `valueOf()` 方法或者调用此方法**返回对象本身**的，则继续进行 string 转换
+ 单目 `+` 操作符优先级**高于**加符运算符
