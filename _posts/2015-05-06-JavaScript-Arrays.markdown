---
title:  "JavaScript Arrays"
category: JavaScript
---
JS数组用于在一个变量名下存储多个具有共性的数值。

    var cars = ["Saab", "Volvo", "BMW"];

+ 数组中空格和换行不重要
+ 最后一个数组项目后没有逗号！
+ 操作数组项目通过 **index number**, Array 索引 **start with 0**

<!--more-->

## Basic

1. 创建数组：

    (1)使用数组常量， `var array-name = [item1, item2, ...];`

    (2)使用 new 关键字， var array-name = new Array(item1, item2, ...);

    通常使用第一种方法，更快更简单，第二种方法可能会产生 unexpected 结果。

        var points = new Array(40, 100);  // Creates an array with two elements (40 and 100)
        var points = new Array(40);       // Creates an array with 40 undefined elements !
        var steps = [ ...Array(4).keys() ].map(ele => ele + 1) // 创建 [1, 2, 3, 4]

2. 获取数组项：`var item = array-name[index];`
3. 改变数组项：`array-name[index] = value;`

## Arrays are Objects

使用 typeof 检查一个 array 返回结果是 object。But, **JavaScript arrays are best described as arrays**. 数组和标准对象的区别如下：

```js
var person = ["John", "Doe", 46];    // person[0] = "John"
var person = {firstName:"John", lastName:"Doe", age:46};    // person.firstName = "John"
```

最好用 _numbered_ 索引而**不是** _named_ 索引来读取数组的元素。If you use a named index, **JavaScript will redefine the array to a standard object**. After that, all array methods and properties will produce incorrect results.

```js
var person = [];
person["firstName"] = "John";
person["lastName"] = "Doe";
var x = person.length;         // person.length will return 0
var y = person[0];             // person[0] will return undefined
```

因为**数组是一种特殊的 object**，同一个数组中的 item 可以是不同的数据类型。

    myArray[0] = Date.now;
    myArray[1] = myFunction;
    myArray[2] = myCars;

### 识别一个变量是 array

1. `Array.isArray(x)`，如果 x 是由 `[]` 或者 `new Array()` 定义的变量，则返回 true。
2. 变量的 `constructor` 属性，在 Data type 章节有提到。
3. 使用 `instanceof` 操作符判断，Syntax 章节有提到。

```js
var fruits = ["Banana", "Orange", "Apple", "Mango"];
fruits instanceof Array;     // returns true
fruits instanceof Object;    // returns true
```

## Array Properties

数组的 _length_ 属性返回数组中元素的个数。该属性值总是比 highest array index 的值多**1**。

    var fruits = ["Banana", "Orange", "Apple", "Mango"];
    fruits[fruits.length] = "Lemon";  // add "Lemon" at the end of fruits
    fruits[10] = "Pear";              // 使用了**大于数组长度**的 index，给数组添加了5个 `undefined` 的空洞。

如果访问不存在的数组 index，则返回 undefined。

## Array Methods

### 查找

JS数组也有 `indexOf()`，`lastIndexOf()` 方法，返回数组中指定 item 的位置，没找到返回 `-1`。

+ `includes(searchElement[, fromIndex])`，该方法检查数组中是否含有某元素，有则返回 true，无则返回 false。比较strings和characters时，是 case-sensitive 的。
+ `find(`callback`)`，接收函数同 every() 方法，返回数组中第一个满足test函数的数组项，没找到返回 `undefined`.

### Convert Arrays to Strings

+ `toString()`，把数组转换成**以逗号为分隔符**、以数组值串联而成的字符串。
+ `join(separator)`，功能同上，但是**可以指定特殊的分隔符**，**默认**分隔符是**逗号**。
+ `valueOf()`，convert an array to a string when a primitive value is expected。该方法是 array 的默认行为，同 `toString()`

栗子：

```js
var fruits = ["Banana", "Orange", "Apple", "Mango"];
fruits.join("");    // 结果是：BananaOrangeAppleMango
fruits.join();      // 结果是：Banana,Orange,Apple,Mango
```

### Convert ArrayLike list to Arrays

```js
var tmpArry = Array.prototype.slice.call(document.querySelectorAll('[type="checkbox"]:checked'))
// 获取页面上所有选中的多选框HTMLElement
```

### Remove elements

返回**被移除的元素**

+ `pop()`，remove the **last element** from an array。
+ `shift()`，remove the **first element** of an array，返回被 removed 的元素，剩下的所有元素自动向前移动一位。。

### Delete elements

因为JS Array 是特殊的 object，因此可以使用操作符 **delete**。（原因见 Object 章节）

    var fruits = ["Banana", "Orange", "Apple", "Mango"];
    delete fruits[0];    // 数组 fruits 中第一个元素将变成 undefined

这样会在数组中产生一些 `undefined` 的空洞，因此删除数组首尾的元素时**最好使用 pop() 或 shift()**。

### Add elements

返回**新数组的长度**

+ `push(`item1, item2, ..., itemX`)`，add a new element **at the end** of an array
+ `unshift(`item1, item2, ..., itemX`)`，add a new element **at the beginning** of an array

以上四种方法都会**改变**原有数组。

### Splicing 剔除

使用 `splice(start[, deleteCount[, item1[, item2[, ...]]]])`，方法可以在数组中指定位置添加新元素。

_start_ 是一个整数，表示第一个新加元素摆放的索引。

_deleteCount_ 从指定位置上（包含指定位置）开始，要删掉的元素个数，如果设为 0 或负值，则表示不删除现有元素；如果**缺省**，或者值大于 (array.length - start)，则删除所有从 start 位置开始（包含 start）剩余的数组项。

item* 表示要添加的新元素，缺省表示不添加新元素。

    fruits.splice(0, 1);    // 效果同 shift()

注意：该方法的**返回**值是**由被删掉的元素组成的新数组**。如果没有删除元素，则返回空数组。

此方法会**改变**原有数组。

### Sorting 排序

使用 `sort([compareFunction])` 对数组进行排序。 如不指定 compare function，则把数组项转为字符串，按照 unicode 顺序比较；

如指定比较函数，入参为（a,b），则根据函数返回值比较：

+ 小于0，把a放到**索引小于**b的位置上
+ 等于0，保持a和b的位置
+ 大于0，把b放到**索引小于**a的位置上

**升序**排列数字数组：

```js
var points = [40, 100, 1, 5, 25, 10];
points.sort(function(a, b){return a-b});
```

**降序**排列数字数组：

```js
var points = [40, 100, 1, 5, 25, 10];
points.sort(function(a, b){return b-a});
```

按中文**拼音首字母** A-Z 排列简单数组：

```js
var people = ['童亚丽', '张子新', '谢丹丹', '陈梦如', '魏秀秀', '陈建'];
people.sort(function(a, b){return a.localeCompare(b, 'zh-CN')});
// 输出结果： ["陈建", "陈梦如", "童亚丽", "魏秀秀", "谢丹丹", "张子新"]

// 对数组项是object的数组排序
arry.sort((a, b) => a.last_name.localeCompare(b.last_name, 'zh-CN'));
```

按**参照数组**顺序输出：

```js
let arrOrder = ['breakfast', 'lunch', 'dinner', 'snacks']
let tmpArr = [{name: 'breakfast'}, {name: 'lunch'}, {name: 'snacks'}, {name: 'dinner'}]
tmpArr = tmpArr.sort((a, b) => {
  return arrOrder.indexOf(a.name) - arrOrder.indexOf(b.name)
})
// 输出结果：[{name: 'breakfast'}, {name: 'lunch'}, {name: 'dinner'}, {name: 'snacks'}]
```

自定义比较函数：

```js
function compare(a, b) {
  if (a is less than b by some ordering criterion) {
    return -1;
  }
  if (a is greater than b by the ordering criterion) {
    return 1;
  }
  // a must be equal to b
  return 0;
}
```

使用 `reverse()` 将升序排列的数组反相（降序）输出。

<span class="t-blue">如果要找出数组中的最大或最小值，可以先对数组进行排序</span>。

此方法会**改变**原有数组。

### Joining 连接

使用 `array1.concat(`array2, ..., arrayX`)` 该方法来连接两个或多个数组，返回值是连接后的数组。

此方法**不改变**原有数组。

### Slicing 取样

使用 `slice(`start, end`)` 返回数组中指定位置的元素所组成的新数组。

_start_ 表示切片开始位置（包含这个位置上的元素），负值表示从数组末端开始（末端第一个元素为 `-1`，依次类推）。

_end_ 是可选的，表示切片结束的位置（**不包括**该位置上的元素）。缺省，或大于array length则表示 extracts through the end of the array。

_start_ 未定义，则从 0 开始；大于 array length 返回 `[]`。

此方法**不改变**原有数组。

## 数组检验

有时我们需要对数组中每个元素进行测试。

+ `every()`，依次检验数组中的元素是否**全部**通过某种测试，全部通过返回 `true`。一旦**遇到不通过的**数组元素，**立即停止检查**剩下的元素，返回 `false`。
+ `some()`，依次检查数组中的元素是否**至少有一个**通过某种测试的，一旦**遇到通过的**数组元素，**立即停止检查**剩下的元素，返回 `true`。全都不通过，返回 `false`。
+ `filter()`，返回由所有**通过某种测试的数组元素**所组成的**新数组**。如果数组项都不满足条件，则返回 `[]`。该方法比 for 循环快；如果使用 predefined 函数将比使用 anonymous 函数更快。
+ `findIndex()`，返回数组中第一个通过test函数的item的**索引**，否则返回 `-1`。

以上方法都是类似的结构：

`array.every(`function(currentValue, index, array), thisValue`)`，其中 index，arr，thisValue 都是可选的。

callback 的3个参数是固定的。比如：

```js
["1", "2"].map(parseInt); // 结果为 [1, NaN]
// parseInt(str, radix)，上面的函数可翻译为以下：
parseInt("1", 0, ["1", "2"]) // 十进制输出 '1'
parseInt("2", 1, ["1", "2"]) // 无法转为number，radix值必须从2到36
```

### 补充

对数组中每一项执行一个操作：

+ `forEach(callback[, thisArg])`，让数组中每一项都执行一次给定的函数操作。特别要注意的是：**没有办法中止或者跳出 forEach 循环，除非抛出一个异常**。如有要中断的必要，不如使用一个简单的 for 循环实现。
+ `map(callback[, thisArg])` ，该方法返回一个由原数组中的**每个元素调用指定方法的返回值**组成的新数组。

    此处 callback 参数同上面的 every() 等函数，多了一个可选的 thisArg 参数，用来指定 callback 函数内 this 的值的对象。

+ `reduce(function(previousValue, currentValue, currentIndex, array), initialValue)`，**从左到右**对数组中每个值进行操作，最终得到一个值。

    initialValue 是可选的。可作为第一次调用时的第一个参数值。

+ `for...of`，数组循环： for (const currentValue of a) { // Do something with currentValue }

```js
例子1：
const array1 = [1, 2, 3, 4];
const reducer = (accumulator, currentValue) => accumulator + currentValue;
// 1 + 2 + 3 + 4
console.log(array1.reduce(reducer));

例子2：
// 将数组项为object的数组，转为以指定属性为key、数组项为value的字典/对象，便于查找操作
let array2 = [{sku_no:'0001',box_name:'xxx'}]
let data = array2.reduce((obj, element) => {
  obj[element.sku_no] = element
  return obj
}, {})
```

#### 通过“索引”批量删除数组中的元素

不经过任何处理直接删除是不行的，因为每删一个元素，数组长度就变了。解决办法如下：

```js
// 对 arryA 待删除 item 的索引组成的 arryB = [5,0,6] 进行“降序排列”，结果如：[6,5,0]
arryB.sort((a, b) => b - a)
arryB.forEach(index => arryA.splice(index, 1))
```

#### 数组去重

`Set` 对象允许我们存储任何数据类型的唯一值，whether primitive values or object references.

```js
// 在 Set 和 Array 之间转换
const mySet = new Set([1, 2, 3, 4]);
console.log(mySet.size); // 4
console.log([...mySet]); // [1, 2, 3, 4]
```
