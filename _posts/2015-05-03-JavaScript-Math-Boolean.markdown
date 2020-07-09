---
title:  "JavaScript Math and Boolean"
category: JavaScript
---
## Math Object

`Math` 是JS内置对象，提供高级数学函数和常量。 Math对象不是一个 constructor，不可以/不需要使用 new 关键字来创建。

### Math functions

+ `Math.random()`，返回一个［0，1）之间的随机数，always lower than 1
+ `Math.min(n1, n2, n3, ..., nX)`，返回参数中的**最小值**。缺省参数返回 `Infinity`。如果有一个或多个参数不是 number，则返回 _NaN_
+ `Math.max(n1, n2, n3, ..., nX)`，返回参数中的**最大值**。缺省参数返回 `-Infinity`。如果有一个或多个参数不是 number，则返回 _NaN_
+ `Math.round(x)`，四舍五入，返回最接近参数 x 的整数
+ `Math.ceil(x)`，四舍五入，返回**向上**最接近参数 x 的整数
+ `Math.floor(x)`，四舍五入，返回**向下**最接近参数 x 的整数
+ `Math.pow(x, n)`，返回 x 的 n 次幂
+ `Math.abs(x)`，返回数字 x 的绝对值

<!--more-->

示例：

```js
Math.round(4.7);            // returns 5
Math.ceil(4.7);             // returns 5
Math.floor(4.7);            // returns 4
```

完整的 JS [Math对象的方法](http://www.w3schools.com/jsref/jsref_obj_math.asp)

### Math Constants

`Math.E` 自然对数函数的底数，又称 Euler's 欧拉数 (approx. 2.718)

`Math.PI`  (approx. 3.14)

`Math.SQRT2` square root of 2 (2的平方根 approx. 1.414)

`Math.SQRT1_2` square root of 1/2 (approx. 0.707)

`Math.LN2` natural log of 2 (以e为底2的对数 approx. 0.693)

`Math.LN10` (approx. 2.302)

`Math.LOG2E` base-2 log of E (以2为底E的对数 approx. 1.442)

`Math.LOG10E` (approx. 0.434)

## Booleans

JS的布尔类型数据只有两个值：**true** 或者 **false**。

### 判断一个表达式、一个值的真假

以下三个方法相同：

```js
Boolean(10 > 9);
(10 > 9);
10 > 9;
```

表达式的布尔值是 JS comparison、condition 的基础。
