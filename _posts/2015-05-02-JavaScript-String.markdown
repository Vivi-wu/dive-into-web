---
title:  "JavaScript Strings and String Method"
category: JavaScript
---
JS String 用来存储一系列字符，用**单**引号或**双**引号限制起来。

### 反斜杠

使用反斜杠输出特殊字符 **backslash** escape character turns special characters into string characters。

### Strings Can be Objects

创建 String 变量的方法有：

    var x = "John";
    var y = new String("John");

最好不要用后者，减缓执行速度。且 `x === y` 是 false 的，因为后者的 type 是 object。

最糟的情况是两个变量都用 **new** 创建，因为 <span class="t-blue">JavaScript objects cannot be compared</span>。两者无法比较。

前者创建的是 primitive values，没有属性和方法，但是 **in JavaScript, methods and properties are also available to primitive values**.

<!--more-->

## String properties

_length_ property为 String 自带属性。除此之外还有 _constructor_ 和 _prototype_ 两个属性。

## String functions

### Find 查找

+ `indexOf(`searchvalue, start`)`，返回 **index** of (the position of) the **first** occurrence of a specified text in a string，<span class="t-blue">字符串中指定文本第一次出现的位置</span>
+ `lastIndexOf(`searchvalue, start`)`，返回一个字符串中指定文本 **last** occurrence (最后一次出现的位置)，以 start 位置开始，从字符串的后面向前查找。
+ `search(`searchvalue`)`，效果同 `indexOf()`。

    因为 A string will automatically be converted to a regular expression，<span class="t-blue">字符串可以被自动转为一个正则表达式</span>。

    `search()` 的 searchvalue 是一个正则表达式，所以它比 `indexOf()` 有更强大的搜索能力。

1.**0** is the **first** position in a string.

2.如果没有找到指定文本，则返回 `－1`。

3.前两者 _searchvalue_ 是一个**字符串**，_start_ 默认是 0，表示开始查找的位置，该参数是可选的。

### Extract 抽取

+ `slice(`start, end`)`，从 start 位置（包含 start 位的字符），到 end 位置（但**不包含** end 位的字符）截取一段字符放置到新的字符串中。缺省 _end_，则认为一直到 end of the string。位置取值**负数**，表示从末尾开始。
+ `substring(`start, end`)`，同上。但**不接受**负数。如果 _start_ 小于0，则认为从 0 开始。如果 "start" is greater than "end", this method will swap the two arguments **交换**开始和结束位置参数, meaning <span style="background-color:lightblue;">str.substring(1,4) == str.substring(4,1)</span>.
+ `substr(`start, length`)`，同 `slice()`，start 位置可取负值。但此处**第二个参数表示长度**，因此**不能**为负数。

  ```js
  "hello world".substr(-4, 4); // 表示从倒数第四位开始，向后取四位字符，返回"orld"
  ```

    以上三个方法的共同点是缺省第二个参数， the method will slice out the rest of the string。

+ `charAt(`position`)`，返回指定位置上的字符
+ `charCodeAt(`position`)`，返回指定位置上字符的 unicode

**注意**：Accessing a String as an Array is Unsafe！<span class="t-blue">不要使用数组形式接近一个字符串</span>。

### Replace 替换

`replace(`searchvalue, newvalue`)`，第一个参数是 a value, or regular expression。

第二个参数是 new string，也可以是一个函数 function (replacement)，该函数的返回值将替换掉第一个参数匹配到的结果

```js
var str = "Mr Blue has a blue house and a blue car";
var res = str.replace(/blue|house|car/gi, function myFunction(x){return x.toUpperCase();});
```

结果为 Mr BLUE has a BLUE HOUSE and a BLUE CAR.

<span class="t-blue">默认只替换找到的**第一个匹配**</span>。希望全部替换，使用 regular expression 作为搜索项。

### 字符大小写转换

使用 `toUpperCase()`，`toLowerCase()` 方法。

### Concate 拼接

使用 `concat()` 连接两个或多个字符串，效果同使用连接操作符 `+`

    var text = "Hello" + " " + "World!";
    var text = "Hello".concat(" ","World!");

All string methods return a new string. They don't modify the original string. <span class="t-blue">所有字符串的方法将返回一个新的字符串，而**不改变**原始字符串</span>。

### 根据 Unicode 输出对应字符

使用字符串对象的静态方法 `String.fromCharCode(num1, ..., numN) ` ，其中参数是一组序列数字，表示 Unicode 值。该方法返回一个字符串，而不是一个 String 对象。

### Converting a String to an Array 字符串转成数组

使用 `split(`separator, limit`)` 方法，把字符串转为数组。两个参数都是 optional 的。

+ 前者可以是一个字符，也可以是 regular expression
+ 缺省 separator，返回整段字符串（return **an Array with only one item**）
+ 后者表示 split 个数，比如转换的数组包含10个item，但我只想要前3个，则设 _limit_ 为 3

Separate each charater, **including white-space**，按单个字符分割，包括空格。

```js
var str = "How are you doing today?";
var res = str.split("");
```

### Match 匹配

使用方法 `match(`regexp`)`，在字符串中查找，返回一个 **Array**，该返回数组中每一个项目是一个 match。没找到匹配，返回 `null`。
