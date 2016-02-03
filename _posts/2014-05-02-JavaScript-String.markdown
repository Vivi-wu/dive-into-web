---
title:  "JavaScript Strings and String Method"
categories: JavaScript
---
JS String 用来存储一系列字符，用**单**引号或**双**引号限制起来。

### 反斜杠

使用反斜杠输出特殊字符 **backslash** escape character turns special characters into string characters。

### Strings Can be Objects

创建 String 变量的方法有：

    var x = "John";
    var y = new String("John");

最好不要用后者，减缓执行速度。且 `x===y` 是 false 的，因为后者的 type 是 object。

最糟的情况是两个变量都用 **new** 创建，因为 <span style="color:blue;">JavaScript objects cannot be compared</span>。两者无法比较。

前者创建的是 primitive values，没有属性和方法，但是 **in JavaScript, methods and properties are also available to primitive values**.

<!--more-->

## String properties

_length_ property为 String 自带属性。除此之外还有 _constructor_ 和 _prototype_ 两个属性。

### Find

+ `indexOf(searchvalue, start)`，返回 **index** of (the position of) the **first** occurrence of a specified text in a string，<span style="color:blue;">字符串中指定文本第一次出现的位置</span>
+ `lastIndexOf(searchvalue, start)`，返回返回一个字符串中指定文本 **last** occurrence 最后一次出现的位置
+ `search(searchvalue)`，效果同 `indexOf()`，因为 A string will automatically be converted to a regular expression，字符串可以被自动转为一个正则表达式。

1.**0** is the **first** position in a string.

2.如果没有找到指定文本，则返回 `－1`。

3.前两者 _searchvalue_ 是一个 string，_start_ 默认是 0，表示开始查找的位置，该参数是可选的。

4.`search()` 的 searchvalue 是一个 regular expressions，比 `indexOf()` 有更强大的搜索能力。

### Extract

+ `slice(start, end)`，从 start 位置（包含 start 位的字符），到 end 位置（但**不包含** end 位的字符）截取一段字符放置到新的字符串中。缺省 _end_，则认为一直到 end of the string。位置取值负数，表示从末尾开始。
+ `substring(start, end)`，同上。但不接受负数。如果 _start_ 小于0，则认为从 0 开始。如果 "start" is greater than "end", this method will **swap** 交换 the two arguments, meaning <span style="background-color:lightblue;">str.substring(1,4) == str.substring(4,1)</span>.
+ `substr(start, length)`，同 `slice()`，但是因为第二个参数是长度，所有不能为负数。

以上三个方法的共同点是缺省第二个参数， the method will slice out the rest of the string。

+ `charAt(position)`，返回指定位置上的字符
+ `charCodeAt(position)`，返回指定位置上字符的 unicode

**注意**：Accessing a String as an Array is Unsafe！不要使用数组形式接近一个字符串。

### Replace

`replace(searchvalue, newvalue)`，第一个参数是 a value, or regular expression，第二个参数也可以是一个函数。

    var str = "Mr Blue has a blue house and a blue car";
    var res = str.replace(/blue|house|car/gi, function myFunction(x){return x.toUpperCase();});

结果为 Mr BLUE has a BLUE HOUSE and a BLUE CAR.

默认情况下，<span style="color:blue;">只替换找到的**第一个匹配**</span>。希望全部替换，使用 regular expression 作为搜索项。

### 字符大小写转换

使用 `toUpperCase()`，`toLowerCase()` 方法。

### Concate

使用 `concat()` 连接两个或多个字符串，效果同使用连接操作符 `+`

    var text = "Hello" + " " + "World!";
    var text = "Hello".concat(" ","World!");

All string methods return a new string. They **don't** modify the original string. <span style="color:blue;">所有字符串的方法将返回一个新的字符串，而不改变原始字符串</span>。

### Converting a String to an Array

使用 `split(separator, limit)` 方法，把字符串转为数组。两个参数都是 optional 的。

+ 前者可以是一个字符，也可以是 regular expression
+ 缺省 separator，返回整段字符串（return **an array with only one item**）
+ 后者表示 split 个数，比如转换的数组包含10个item，但我只想要前3个，则设 _limit_ 为 3

Separate each charater, **including white-space**，按单个字符分割，包括空格。

    var str = "How are you doing today?";
    var res = str.split("");

### Match

使用方法 `match(regexp)`，在字符串中查找，返回一个 **array**，该返回数组中每一个项目是一个 match。没找到匹配，返回 `null`。
