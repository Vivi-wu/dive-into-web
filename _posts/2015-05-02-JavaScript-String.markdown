---
title:  "JavaScript Strings"
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

前者创建的是 primitive values，但是 in JavaScript, methods and properties are **also available** to primitive values.

<!--more-->

## String properties

_length_ 是 String 自带属性。除此之外还有 _constructor_ 和 _prototype_ 两个属性。

## String functions

### Find 查找
+ `indexOf(`searchvalue, start`)`，返回 **index** of (the position of) the **first** occurrence（第一次出现的位置） of a specified text in a string。
+ `lastIndexOf(`searchvalue, start`)`，返回一个字符串中指定文本 **last** occurrence (最后一次出现的位置)，以 start 位置开始，从字符串的后面向前查找。
+ `search(`searchvalue`)`，效果同 `indexOf()`。

    因为<span class="t-blue">字符串可以被自动转成一个正则表达式</span>。

    `search()` 的 searchvalue 是一个正则表达式，所以它比 `indexOf()` 有更强大的搜索能力。

1.字符串开始位置的索引为 0.
2.如果没有找到指定文本，则返回 `－1`。
3.前两者 _searchvalue_ 是一个**字符串**，_start_ 默认是 0，表示开始查找的位置，该参数是可选的。

+ `includes(searchString[, fromIndex])`，用来判断一个字符串里是否含有**另一个字符串**，有则返回 true，无则返回 false。默认从 0 索引开始查。

### Extract 抽取

+ `slice(`start, end`)`，从 start 位置（包含 start 位的字符），到 end 位置（但**不包含** end 位的字符）截取一段字符放置到新的字符串中。缺省 _end_，则认为一直到 end of the string。位置取值**负数**，表示从末尾开始。
+ `substring(`start, end`)`，同上。但**不接受**负数。如果 _start_ 小于0，则认为从 0 开始。如果 "start" is greater than "end", this method will swap the two arguments **交换**开始和结束位置参数, meaning <span style="background-color:lightblue;">str.substring(1,4) == str.substring(4,1)</span>.
+ `substr(`start, length`)`，同 `slice()`，start 位置可取负值。但此处**第二个参数表示长度**，因此**不能**为负数。

  ```js
  "hello world".substr(-4, 4); // 表示从倒数第四位开始，向后取四位字符，返回"orld"
  ```

    以上三个方法的共同点是缺省第二个参数，the method will slice out the rest of the string。

+ `charAt(`position`)`，返回指定位置上的字符
+ `charCodeAt(`position`)`，返回指定位置上字符的 UTF-16 代码单元值的数字；如果索引超出范围，则返回 NaN

**注意**：Accessing a String as an Array is Unsafe！<span class="t-blue">不要使用数组形式接近一个字符串</span>。

### Replace 替换

`replace(`regexp|substr, newSubstr|function`)`
，返回**一个新字符串**，其中第一个匹配项（或全部匹配项）被替换为 newvalue，不改变原 string。

```js
var str = "Mr Blue has a blue house and a blue car";
var res = str.replace(/blue|house|car/gi, function myFunction(x){return x.toUpperCase();});
```

结果为 Mr BLUE has a BLUE HOUSE and a BLUE CAR.

<span class="t-blue">默认只替换找到的**第一个匹配**</span>。希望全部替换，使用 regular expression 作为搜索项。

没找到 match 则返回原 string。

### 字符大小写转换

使用 `toUpperCase()`，`toLowerCase()` 方法。

### Concate 拼接

使用 `concat()` 连接两个或多个字符串，效果同使用连接操作符 `+`。

    var text = "Hello" + " " + "World!";
    var text = "Hello".concat(" ","World!");

<span class="t-blue">所有字符串的方法将返回一个新的字符串，而**不改变** original 字符串</span>。

### 根据 Unicode 输出对应字符

使用字符串对象的静态方法 `String.fromCharCode(num1, ..., numN) ` ，其中参数是一组序列数字，表示 Unicode 值。该方法返回一个字符串，而不是一个 String 对象。

### Converting a String to an Array 字符串转成数组

使用 `split(`separator, limit`)` 方法，把字符串转为数组。两个参数都是 optional 的。

+ 前者可以是一个字符，也可以是 regular expression
+ **缺省** separator，返回 **an Array with only one item** 整段字符串
+ 后者表示 split 个数，比如转换的数组包含10个item，但我只想要前3个，则设 _limit_ 为 3

按单个字符分割, **including white-space** 包括空格，如下：

```js
var str = "How are you doing today?";
var res = str.split("");
```

### Match 匹配

使用 `match(`regexp`)` 方法查找指定字符。如果 regexp 包含 `g` 标识，则方法返回 **all matched** 子字符串组成的数组；没有匹配项，返回 `null`。

如果 regexp **不含** g 标识，则返回由第一个匹配项、它在字符串里的索引、原始字符串，组成的数组。

下例将银行卡号以4个数字为一组展示：

```js
"1005100510051005227".match(/.{1,4}/)
// ["1005", index: 0, input: "1005100510051005227"]
"1005100510051005227".match(/.{1,4}/g)
// ["1005", "1005", "1005", "1005", "227"]
```

### trim 去空格

使用方法 `trim()`，删除字符串首尾的空格. 返回一个新的字符串。
Whitespace in this context is all the whitespace characters (space, tab, no-break space, etc.) and all the line terminator characters (LF, CR, etc.

### localeCompare 排序

判断两个字符串在 sort 顺序中的先后位置。

```js
referenceStr.localeCompare(compareString[, locales[, options]])
```
返回**负数**表示，reference string 在 compare string 前面；**正数**表示reference string排在后面；**0**表示相等。
