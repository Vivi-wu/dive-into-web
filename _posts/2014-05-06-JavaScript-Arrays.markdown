---
title:  "JavaScript Arrays"
categories: JavaScript
---
JS数组用于在一个变量名下存储多个具有共性的数值。

    var cars = ["Saab", "Volvo", "BMW"];

+ 数组中空格和换行不重要
+ 最后一个数组项目后没有逗号！
+ 操作数组项目通过 **index number**, Array indexes **start with 0**

## Basic

_创建数组_：

1.使用数组常量， var array-name = [item1, item2, ...];

2.使用 new 关键字， var array-name = new Array(item1, item2, ...);

通常使用第一种方法，更快更简单，第二种方法可能会产生 unexpected 结果。

    var points = new Array(40, 100);  // Creates an array with two elements (40 and 100)
    var points = new Array(40);       // Creates an array with 40 undefined elements !

_读取数组项_：var item = array-name[index];

_改变数组项_：array-name[index] = value;

<!--more-->

## Arrays are Objects

使用 typeof 检查一个 array 返回结果是 object。But, **JavaScript arrays are best described as arrays**. 数组和标准对象的区别如下：

    var person = ["John", "Doe", 46];    // person[0] = "John"
    var person = {firstName:"John", lastName:"Doe", age:46};    // person.firstName = "John"

最好用 _numbered indexes_ 而**不是** _named indexes_ 读取数组的元素。If you use a named index, **JavaScript will redefine the array to a standard object**. After that, all array methods and properties will produce incorrect results.

    var person = [];
    person["firstName"] = "John";
    person["lastName"] = "Doe";
    var x = person.length;         // person.length will return 0
    var y = person[0];             // person[0] will return undefined

因为**数组是一种特殊的 object**，we can have variables of different types in the same Array 同一个数组中可以有不同数据类型的变量。

    myArray[0] = Date.now;
    myArray[1] = myFunction;
    myArray[2] = myCars;

### 识别一个变量是 array

1.`Array.isArray(x)`，x为要测试的变量。注意：旧的浏览器可能不支持

2.变量的 `constructor` 属性，在 Data type 章节有提到。

3.使用 `instanceof` 操作符判断，Syntax 章节有提到。

    var fruits = ["Banana", "Orange", "Apple", "Mango"];
    fruits instanceof Array     // returns true

## Array Properties

数组的 _length_ 属性返回数组中元素的个数。该属性值总是比 highest array index 的值多**1**。

    var fruits = ["Banana", "Orange", "Apple", "Mango"];
    fruits[fruits.length] = "Lemon";    // add "Lemon" at the end of fruits
    fruits[10] = "Lemon";

注意上面第二个添加语句，因为使用了比数组长度更大的 index，所以会给数组添加 undefined 空洞。

## Array Methods

### Convert Arrays to Strings

+ `toString()`，把数组转换成**以逗号为分隔符**、以数组值串联而成的字符串。
+ `join(separator)`，功能同上，但是**可以指定特殊的分隔符**，**默认**分隔符是**逗号**
+ `valueOf()`，convert an array to a string when a primitive value is expected。该方法是 array 的默认行为，同 `toString()`

关于 `array.join()` 的用法：

    var fruits = ["Banana", "Orange", "Apple", "Mango"];
    fruits.join("");    // 结果是：BananaOrangeAppleMango
    fruits.join();      // 结果是：Banana,Orange,Apple,Mango

可以看到不指定分隔符，和分隔符为空字符串是有区别的。

### Remove elements

+ `pop()`，remove the **last element** from an array，返回值是被 pop 出来的元素。
+ `shift()`，remove the **first element** of an array，然后剩下的所有元素自动向前移动一位。返回值就是被 shift 出来的元素。

### Delet elements

因为JS array 是特殊的对象，所有可以使用操作符 **delete**。（原因见 Object 章节）

    var fruits = ["Banana", "Orange", "Apple", "Mango"];
    delete fruits[0];    // 数组 fruits 中第一个元素将变成 undefined

这样会在数组中产生一些 undefined 的空洞，最好使用 pop() or shift()

### Add elements

+ `push(item1, item2, ..., itemX)`，add a new element **at the end** of an array，返回值是新数组的长度。
+ `unshift(item1, item2, ..., itemX)`，add a new element **at the beginning** of an array，返回值是新数组的长度。

以上四种方法都要改变数组的长度。

### Splicing

使用 `splice(intex, howmany, item1, ..., itemX)`，方法可以在数组中指定位置添加新元素。

_intex_ 是一个整数，表示第一个新元素要放的位置。_howmany_ 从指定位置上（包含指定位置）开始，要删掉的元素个数，如果设为 0，则表示不删除现有元素。后面的 item 表示要添加的新元素，缺省表示不添加新元素。

    fruits.splice(0, 1);    // 效果同 shift()

注意：该方法的返回值是**包含被删掉的元素的新数组**。

### Sorting

使用 `sort()` 方法将数组元素按照 字符升序 alphabetically 排序。使用 `reverse()` 将升序排列的数组反相（降序）输出。这两种方法都用在数组值是 string 都情况下。不适用于数字排序，因为 “25” 大于 “100”，“2” 大于 “1”。

升序排列数字数组：

    var points = [40, 100, 1, 5, 25, 10];
    points.sort(function(a, b){return a-b});
    points.sort(function(a, b){return a>b});    // 两种方法结果一样

降序排列数字数组：

    var points = [40, 100, 1, 5, 25, 10];
    points.sort(function(a, b){return b-a});
    points.sort(function(a, b){return b>a});    // 两种方法结果一样

这样如果要找出数组中的最大或最小值，首先要对数组进行排序。

### Joining array

使用 `array1.concat(array2, ..., arrayX)` 该方法来连接两个或多个数组，不改变现有的数组，返回值是连接后的数组。

### Slicing an array

使用 `slice(start, end)` 方法返回数组中指定元素作为新的数组对象。不改变原有数组。

_start_ 表示切片开始位置（包含这个位置上的元素），负值表示从数组末端开始（末端第一个元素为 `-1`，依次类推）。_end_ 是可选的，表示切片结束的位置（但是**不包括**该位置上的元素），缺省表示 to the end of the array。
