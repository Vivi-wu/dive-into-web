---
title:  "JavaScript Data Types and Type Conversion"
category: JavaScript
---
为了正确操作一个变量，需要知道它的数据类型。

+ JS中有**5**种可以包含 values 的类型：string, number, boolean, object and function。
+ 有**2**种不含 value 的类型：undefined，null
+ 有**3**种不同类型的 object：Object，Date，Array。所以<span class="blue-text">使用 `typeof` 操作符不能判断出一个变量是否是 Array 或 Date 变量</span>，因为返回结果都是 `object`。

<!--more-->

## constructor Property

该性质**返回**所有JS变量的 **constructor 函数**。

    "John".constructor         // Returns function String()  { [native code] }
    (3.14).constructor         // Returns function Number()  { [native code] }
    false.constructor          // Returns function Boolean() { [native code] }
    [1,2,3,4].constructor      // Returns function Array()   { [native code] }
    {name:'John', age:34}.constructor  // Returns function Object()  { [native code] }
    new Date().constructor       // Returns function Date()    { [native code] }
    function () {}.constructor   // Returns function Function(){ [native code] }

<span class="blue-text">可以用来判断一个变量类型是否是 Array</span>，判断 Date 方法同。

    function isArray(myArray) {
      return myArray.constructor.toString().indexOf("Array") > -1;
    }

### Undefined

    var person;

此时，变量 person 的值是 undefined，typeof 结果也是 undefined。

    person = undefined;

经过上述操作，变量的值设为 undefined，类型 type 也变为 undefined。

### Null

JS中 `null` 表示什么都不是、不存在。<span class="blue-text">与 undefined 不同，`typeof null` 的结果是 `object`</span>。

    null == undefined;  // true
    null === undefined; // false

可以用 null 来**清空**一个 object 变量。当然用 undefined 来清空也是可以的，但是注意结果如前所述是有区别的。

`null` is for **objects**, `undefined` is for **variables**, **properties**, and **methods**.

### test if an object exists

测试一个对象是否存在，必须如下先检查该对象是否被定义了。

    if (typeof myObj !== "undefined" && myObj !== null)
    if (myObj !== null && typeof myObj !== "undefined")  // 这样写会 throw error exception，两句的区别见下面
    var person = {};
    typeof person;       // object
    person.valueOf();    // [object Object]
    (person !== null);   // true
    typeof persons;      // undefined
    (persons !== null);  // 浏览器报错，JS停止执行，没有显示结果。

## Type Conversion

JS从左到右依次评估 expression，操作数据类型不同的变量，左右位置不同，得到的结果可能很不一样。因为JS变量是 dynamic 类型，可以被JS自动变换类型。

注意查看 [Type Conversion Table](http://www.w3schools.com/js/js_type_conversion.asp)

### Automatic String Conversion

注意：在JS输出时，会自动调用 toString() 方法。

    document.getElementById("demo").innerHTML = myVar;

    // if myVar = {name:"Fjohn"}  // toString converts to "[object Object]"
    // if myVar = [1,2,3,4]       // toString converts to "1,2,3,4"
    // if myVar = new Date()      // toString converts to "Fri Jul 18 2014 09:08:55 GMT+0200"
    // if myVar = 123             // toString converts to "123"
    // if myVar = true            // toString converts to "true"
    // if myVar = false           // toString converts to "false"

### Numbers to Strings

使用全局函数 String()，或者Number的 toString() 方法：

    String(x)；
    x.toString()；

x 也可以是常量或者表达式。更多方法参看 Number 章节。

Booleans to Strings，Dates to Strings 方法同上。Date 转为字符串有更多不同的显示方法，参看 Date 章节。

### Strings to Numbers

使用全局函数 Number()，其他方法参考 Number 章节。

    Number("3.14")    // returns 3.14
    Number(" ")       // returns 0 
    Number("")        // returns 0
    Number("99 88")   // returns NaN

When comparing a string with a number, JavaScript will convert the string to a number when doing the comparison. <span class="blue-text">当比较一个字符串和一个数字，JS会自动将字符串转换成一个数字，然后做比较</span>。

An empty string converts to 0. A non-numeric string converts to **NaN** which is always **false**. 空字串转为 0，非数字式字符串转换成 `NaN`, 比较结果为 false

两个数字式字符串做比较：

    "2" > "12"  // true，because (alphabetically) 1 is less than 2
    2 < "12"    // true，"12" 转换成数字12进行了比较

为了保证正确的结果，在比较之前，需要把变量转换成合适的类型。

    age = Number(age);
    if (isNaN(age)) {
        voteable = "Error in input";
    } else {
        voteable = (age < 18) ? "Too young" : "Old enough";
    }

### Unary + Operator

一元操作符 `+`

    var y = "5";      // y is a string
    var x = + y;      // x is a number

如果 y 不是一个可以转为 number 的变量，x 的类型依然会变成 number，但是值为 `NaN`

Boolean to number 就简单来，false 是 _0_，true 是 _1_

Date to Number 可以使用 Number(), 或者 getTime() 函数，得到的是 milliseconds since January 1, 1970, 00:00:00
