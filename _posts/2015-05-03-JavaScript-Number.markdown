---
title:  "JavaScript Numbers"
category: JavaScript
---
JS的数字是**双精度 64-bit**形式，JS只有一种 Number 类型的数，可以带小数写，也可以不用。

特别大或特别小大数可以用 scientific (exponent) notation 写。

    var x = 123e5;    // 12300000
    var y = 123e-5;   // 0.00123

## 精度

整数可以保证是精确的最多位数是15位**，最大安全整数 9007199254740991，超过最大安全整数的运算是不安全的。

**小数最多位数是 17**。

    var x = 0.2 + 0.1;         // x will be 0.30000000000000004
    var x = (0.2 * 10 + 0.1 * 10) / 10;       // x will be 0.3

<!--more-->

<span class="t-blue">浮点数相加不一定准确</span>，因为计算机中用二进制来存储小数，而大部分小数转成二进制之后都是无限循环的值，因此存在取舍问题，造成精度丢失。

## 进制

JS默认数字是**十进制**显示。以 `0x` 开头的数字为十六进制显示。

    var x = 0xFF;             // x will be 255

可以使用 `toString(n)` 方法实现 n 进制显示。

```js
var myNumber = 128;
myNumber.toString(16);     // returns 80
myNumber.toString(8);      // returns 200
myNumber.toString(2);      // returns 10000000
```

## 特殊值

可以使用 `isFinite()` 方法判断一个值是否为 Infinity, -Infinity 或者 NaN 

### Infinity or (-Infinity)

无限大或无限小常量，是JS计算中最大（或最小）可能取的数。比如一个数字常数除以 0 的结果。


```js
typeof Infinity;        // returns "number"
```

### NaN - Not a Number

产生 NaN 的方式：

1.数学运算结果是 `undefined`或不可表示的值
2.非数字型的值转为 numeric value 时，没有等价的 primitive numeric 值表示

注意：数字除以一个 _non-numeric string_ 非数字式字符串和一个 numeric 字符串的区别。

    var x = 100 / "Apple";  // x will be NaN (Not a Number)
    var x = 100 / "10";     // x will be 10

+ `NaN` 的 type 是 number
+ `isNaN(value)` 可以理解为：当 value 被强制转为一个numeric value时，是一个IEEE-754'非数字'的值
+ 如果 `isNaN(x)` 返回 true, 则 x 作为操作数的所有算數表达式、数学运算讲返回 `NaN`
+ 判断一个 variable 是否为 `NaN` 更可靠的方式:

    var isNaN = function(value) {
        var n = Number(value);
        return n !== n;
    }
+ 等号操作符无法判断一个值是否为 `NaN`。因此如果你想从一个 array 中用原生的 `indexOf()` 找到 NaN **是不行的**。

    NaN == NaN  // return false
    NaN === NaN // return false
    [NaN, 'test'].indexOf(NaN)  // return -1
+ 数字和 `NaN` 相加，结果也是 `NaN`。但是字符串和 `NaN` 相加，结果是字符串的 concatenation。

注意一些特殊值：

```js
isNaN(undefined)  // true
isNaN(NaN)        // true
isNaN({})         // true
isNaN(function(){})  // true

isNaN(true)       // false，Converted to Number is 1
isNaN(null)       // false, Converted to Number is 0
isNaN(0)          // false
isNaN(0 / 0)      // false

isNaN('0')        // false，Converted to Number is 0
isNaN('')         // false，Converted to Number is 0
isNaN(' ')        // false，Converted to Number is 0
isNaN('NaN')      // true

isNaN([])         // false，Converted to Number is 0
isNaN([20])       // false，Converted to Number is 20
isNaN([20,10])    // true

isNaN(new Date())                // false，Converted to current date/time in milliseconds
isNaN(new Date().toString())     // true
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

## 属性和方法

Number 的一些属性是 JavaScript **Number** 对象的<span class="t-red">静态</span>属性.

JS中**只能被 Number 对象调用**的属性有：`MAX_VALUE`，`MIN_VALUE`，`NEGATIVE_INFINITY`，`POSITIVE_INFINITY`，`NaN`

使用方法如 `Number.MAX_VALUE`

### Numbers Can be Objects

创建 Number 变量的方法有：

    var x = 123;
    var y = new Number(123);

最好不要用后者，减缓执行速度。且 `x === y` 是 false 的，因为后者的 type 是 object。

最糟的情况是两个变量都用 **new** 创建，因为 <span class="t-blue">JavaScript objects cannot be compared</span>。两者不能进行比较。

### Converting Variables to Numbers

将变量转为数字的全局方法有：

+ `Number()`， Returns a number, converted from its argument. 当参数无法转为数字时，返回 `NaN`
+ `parseInt(string, radix)`，返回指定进制的整数部分。空格是允许的，但是只返回第一个数字。

    + This function determines if the first character in the specified string is a number. If it is, it parses the string until it reaches the end of the number, and returns the number **as a number**, not as a string.
    + 数字前和后允许有空格。
    + _radix_ 指的是 string 的数学进制，是一个 **(from 2 to 36) 的数字**，。比如：`parseInt("20", 16)`，表示第一个参数是十六进制的，**运算结果**以**十进制**显示，即 `32`。
    + 如果 _radix_ 是 `undefined`、 `0` 或缺省，则看第一个参数：若以 `0x` 开始，则为十六进制；以 `0` 开始，则为八进制。任何其他 value，都认为是十进制的。
    + parseInt should not be used as a substitute for Math.floor()

    **注意**：该函数在不同浏览器中表现有差异。比如 `parseInt('09')`，谷歌，IE9+ 等高级浏览器，返回结果为 `9`。09开头，如果按八进制，则无效（八进制一位上取值为0-7）。IE8-的游览器则返回 `0`。屏蔽浏览器差异的解决办法是，指定 radix，即 `parseInt('09',10)`。这样都返回 9

+ `parseFloat(string)`，永远返回 10 进制的浮点数字。遇到第一个无法转成number的字符时返回 NaN
+ 单目运算符 `+`，不同于上面2个方法（parseInt、parseFloat 解析字符串直到遇到一个相对于指定数字格式无效的字符），只要value里包含无效字符，就返回 NaN

示例：

```js
Number("10");            // returns 10
Number("10 20");         // returns NaN
Number('12.00');         // 12
Number('0x11');          // 17
Number('0b11');          // 3
Number('0o11');          // 9
parseInt("10 20 30");    // returns 10
parseInt("10 years");    // returns 10
parseInt("years 10");    // returns NaN
parseFloat("10.33");     // returns 10.33
parseFloat("10 20 30");  // returns 10
```

### Number 的方法

+ `toString()`，可以把 literals, variables, or expressions 转为字符串输出
+ `toLocaleString()`，转成本地数字显示格式。如 35000 -> "35,000"
+ `toExponential(x)`，Returns a string, with a number rounded and written **using exponential notation**. 参数 x 表示精确到小数的后几位数，取值从 0 到 20，原数小数点后位数不够补0，多则四舍五入. **缺省则保留所有小数点后的数字**。
+ `toFixed(x)`，Returns a string, with a number rounded and written with a specified number of decimals. x **指定小数点后保留几位数**。默认值是 **0** (no digits after the decimal point 表示没有小数部分，多则四舍五入)
+ 注意：对浮点数使用 toFixed 方法结果不可知。Floating point numbers cannot represent all decimals precisely in binary
+ `toPrecision(x)`，Returns a string, with a number written with a specified length，按**指定数字长度**，小数部分包括在内，**缺省则原样输出**。位数不够补0，多则四舍五入。注意对小数的处理，看下面的例子。
+ `valueOf()`， Returns a number as a number

示例：

```js
var x = 9.656;
x.toExponential(2);     // returns 9.66e+0
x.toExponential(4);     // returns 9.6560e+0
x.toFixed(2);           // returns 9.66
x.toFixed();            // returns 10
2.34.toFixed(1);        // Returns '2.3'
2.35.toFixed(1);        // Returns '2.4'. Note it rounds up
2.55.toFixed(1);        // Returns '2.5'. Note it rounds down
x.toPrecision();        // returns 9.656
x.toPrecision(2);       // returns 9.7
var num = 0.001658853;
var b = num.toPrecision(2); // returns 0.0017
```

所有 number 的方法均**不改变 original 变量的值**，返回一个新的值。
