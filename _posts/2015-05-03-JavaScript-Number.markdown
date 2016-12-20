---
title:  "JavaScript Numbers"
category: JavaScript
---
JS只有一种 Number 类型的数，可以带小数写，也可以不用。特别大或特别小大数可以用 scientific (exponent) notation 写。

    var x = 123e5;    // 12300000
    var y = 123e-5;   // 0.00123

## 精度

Integers (numbers without a period or exponent notation) are considered accurate up to 15 digits，**整数可以保证是精确的最多位数是15位**，超出则不精确了。

The maximum number of decimals is 17。**小数最多位数是 17**，因此<span class="t-blue">浮点数相加也不一定准确</span>。

    var x = 0.2 + 0.1;         // x will be 0.30000000000000004
    var x = (0.2 * 10 + 0.1 * 10) / 10;       // x will be 0.3

<!--more-->

## 十六进制

JS默认数字是**十进制**显示。以 `0x` 开头的数字为十六进制显示。

    var x = 0xFF;             // x will be 255

可以使用 `toString(n)` 方法实现 n 进制显示。

```js
var myNumber = 128;
myNumber.toString(16);     // returns 80
myNumber.toString(8);      // returns 200
myNumber.toString(2);      // returns 10000000
```

### Infinity or (-Infinity)

无限大或无限小常量，是JS计算中最大（或最小）可能取的数。比如一个数字常数除以0的结果。

该常量的类型是 number。

```js
typeof Infinity;        // returns "number"
```

### 0

JS 中有两个 0 ：`+0` 和 `-0`。两者输出皆为 0. 他们事实上也相等.

```js
+0 === -0  // true
+0 > -0  // false
+0 < -0  //false
```

使用一个非零的整数除以它们可以用来判断到底是正0，还是负0。

```js
42 / 0   // Infinity
42 / -0  //-Infinity
```

### NaN - Not a Number

当JS评估一个值不是一个number时，结果用 NaN 表示。注意数字除以一个 _non-numeric string_ 非数字式字符串和一个 numeric 字符串的区别。

    var x = 100 / "Apple";  // x will be NaN (Not a Number)
    var x = 100 / "10";     // x will be 10

+ `NaN` 的 type 是 number。
+ NaN 不等于 NaN，不论是 `===` 还是 `==`，结果都是 false。因此如果你想从一个 array 中用原生的 `indexOf()` 找到 NaN**是不行的**。<span class="t-blue">可以通过判断 `x!==x`</span>，该方法比用 isNaN(x) 效率高。
+ 数字和 `NaN` 相加，结果也是 `NaN`。但是字符串和 `NaN` 相加，结果是字符串的 concatenation。
+ `isNaN()` 该全局函数可以用来判断一个值，是否是一个 number（**是否可以转为一个数字**）。

注意一些特殊值：

```js
isNaN('')         // false，Converted to Number is 0
isNaN('0')        // false，Converted to Number is 0
isNaN([])         // false，Converted to Number is 0
isNaN([20])       // false，Converted to Number is 20
isNaN(true)       // false，Converted to Number is 1
isNaN(undefined)  // true
isNaN('NaN')      // true
isNaN(NaN)        // true
isNaN(0 / 0)      // true
isNaN([20,10])    // true
isNaN({})         // true
isNaN(function(){})  // true
```

### Numbers Can be Objects

创建 Number 变量的方法有：

    var x = 123;
    var y = new Number(123);

最好不要用后者，减缓执行速度。且 `x === y` 是 false 的，因为后者的 type 是 object。

最糟的情况是两个变量都用 **new** 创建，因为 <span class="t-blue">JavaScript objects cannot be compared</span>。两者不能进行比较。

## 属性和方法

Number 的一些属性是 JavaScript **Number** 对象的<span class="t-red">静态</span>属性.

JS中**只能被 Number 对象调用**的属性有：`MAX_VALUE`，`MIN_VALUE`，`NEGATIVE_INFINITY`，`POSITIVE_INFINITY`，`NaN`

使用方法如 `Number.MAX_VALUE`

### Converting Variables to Numbers

将变量转为数字的全局方法有：

+ `Number()`， Returns a number, converted from its argument. 注意字符串转数字，看下面的例子。
+ `parseFloat()`， Parses its argument and returns a floating point number
+ `parseInt(string, radix)`， Parses its argument and returns an integer. **Spaces are allowed. Only the first number is returned**，空格是允许的，但是只返回第一个数字。

    + This function determines if the first character in the specified string is a number. If it is, it parses the string until it reaches the end of the number, and returns the number **as a number**, not as a string.
    + Leading and trailing spaces are allowed。第一个数字前和后允许有空格。
    + _radix_, 是一个 (from 2 to 36) 的数字 that represents the numeral system to be used，表示 string 用的是哪一种进制。比如：`parseInt("20",16)`，表示第一个参数是十六进制的，**运算结果**以**十进制**显示，即 `32`。
    + 缺省 _radix_ 参数，看第一个参数。若以 `0x` 开始，则为十六进制，若以 `0` 开始，则为八进制。任何其他 value，都认为是十进制的。

    **注意**：该函数在不同浏览器中表现有差异。比如 `parseInt('09')`，谷歌，IE9+ 等高级浏览器，返回结果为 `9`。09开头，如果按八进制，则无效（八进制一位上取值为0-7）。IE8-的游览器则返回 `0`。屏蔽浏览器差异的解决办法是，指定 radix，即 `parseInt('09',10)`。这样都返回 9

示例：

```js
Number("10");            // returns 10
Number("10 20");         // returns NaN
parseInt("10 20 30");    // returns 10
parseInt("10 years");    // returns 10
parseInt("years 10");    // returns NaN
parseFloat("10.33");     // returns 10.33
parseFloat("10 20 30");  // returns 10
```

### Number 的方法

+ `toString()`， Returns a number as a string，可以把 literals, variables, or expressions 转为字符串输出
+ `toExponential(x)`， Returns a string, with a number rounded and written **using exponential notation**. 参数 x 表示精确到小数的后几位数，取值从 0 到 20，原数小数点后位数不够补0，多则四舍五入. **缺省则保留所有小数点后的数字**。
+ `toFixed(x)`， Returns a string, with a number rounded and written with a specified number of decimals. x **指定小数点后保留几位数**。默认值是 **0** (no digits after the decimal point 四舍五入，表示没有小数部分)
+ `toPrecision(x)`， Returns a string, with a number written with a specified length，按**指定数字长度**，小数部分包括在内，**缺省则原样输出**。位数不够补0，多则四舍五入。注意对小数的处理，看下面的例子。
+ `valueOf()`， Returns a number as a number

示例：

```js
var x = 9.656;
x.toExponential(2);     // returns 9.66e+0
x.toExponential(4);     // returns 9.6560e+0
x.toFixed(2);           // returns 9.66
x.toFixed();            // returns 10
x.toPrecision();        // returns 9.656
x.toPrecision(2);       // returns 9.7
var num = 0.001658853;
var b = num.toPrecision(2); // returns 0.0017
```

所有 number 的方法均不改变原来的变量，返回一个新的值。

<span class="t-blue">In JavaScript, all data types have a <code>valueOf()</code> and a <code>toString()</code> method</span>.
