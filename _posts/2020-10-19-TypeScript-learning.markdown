---
title:  "TypeScript学习"
category: JavaScript
---
官网[get started](https://www.typescriptlang.org/docs/handbook/typescript-from-scratch.html)

Detecting errors in code without running it is referred to as static checking. Determining what’s an error and what’s not based on the kinds of values being operated on is known as static type checking.

在不运行代码的情况下检测代码中的错误称为**静态检查**。根据要操作的值的类型来确定是什么错误和什么不是错误，称为**静态类型检查**。

总结：TypeScript是静态类型检查器。

+ TS是JS的超集，因此的任何可执行的JS语句都是合法的TS。
+ TS不会改变JS代码的runtime行为/表现，这个是TS的一个foundational promise

有两种语法构建TS的类型：_interface_ 和 _type_。建议使用前者，只在特殊功能使用后者（如：由简单类型组合创建复杂的类型）

## 用法

通过 _interface_ 明确表述一个对象的形状。之后可以在变量声明、函数返回值、函数入参使用它。

```ts
interface User {
  name: string;
  id: number;
}
const user: User = {
  name: "Hayes",
  id: 0,
};
function getAdminUser(): User {
  //...
}
function deleteUser(user: User) {
  // ...
}
```

使用 _typeof_ 检查变量的类型。

	typeof s === "string"
	typeof undefined === "undefined"
	typeof f === "function"
	Array.isArray(a) // 特例

### Unions

使用 unions 类型的常用例子，由枚举的string或number常量描述允许的值。

```ts
type LockStates = "locked" | "unlocked";
type OddNumbersUnderTen = 1 | 3 | 5 | 7 | 9;
```

### Generics

没有 generics 的数组可以保护任何类型的值，拥有 generics 的数组描述了数组项的类型。

也可以使用 generics 定义自己的类型。

```ts
type StringArray = Array<string>;
type ObjectWithNameArray = Array<{ name: string }>;
```

### Structural Type System

TS的核心概念之一是类型检查聚焦在values的shapes/结构。在结构体类型系统里：

+ 如果两个对象拥有相同的 shape，则认为它们是相同的 type
+ shape-matching 结构匹配**只需要对象 field 的子集匹配**
+ 只需要拥有 interface 要求的 shape，无需明确的写 implements，就可以实现一个接口 implement an interface

```ts
interface Point {
  x: number;
  y: number;
}
function printPoint(p: Point) {
  console.log(`${p.x}, ${p.y}`);
}
const point = { x: 12, y: 26 };
printPoint(point); // prints "12, 26"

const rect = { x: 33, y: 3, width: 30, height: 80 };
printPoint(rect); // prints "33, 3"

// classes 和 objects 遵从类型的方式没有区别
class VirtualPoint {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}
const newVPoint = new VirtualPoint(13, 56);
printPoint(newVPoint); // prints "13, 56"
```
