---
title:  "JavaScript模块化"
category: JavaScript
---
## ES Modules

ES6 模块是一种在JavaScript中定义和导出可重用代码的标准化方法。

+ 使用 `import` 和 `export` 关键字来定义和导出代码。
+ 可以在应用程序中按需加载。
+ 提供了一种在应用程序中管理依赖项的方式，使代码更易维护和扩展。

<!--more-->

注意，模块的功能被引入单一脚本的作用域，它们非全局作用域可见。

## 语法

现代浏览器原生支持模块功能。一个.js文件即一个 module。

在一个文件中，可以有多个 export、import，但只能有一个 `export default`。

通过 `export` 方式导出，在 `import` 导入时，要加 `{}` 且以逗号分隔引入需要的功能。`export default` 导出则不需要。

export default向外暴露的成员，可以使用任意变量来接收。

```js
// app.js
export function myLogger(msg) {
  console.log('myLogger:', msg);
}
export class MyClass {
  constructor() {
    ...
  }
}
// MyDefaultExport.js
export default function myFunction() {
  ...
}

// main.js
import { myLogger, MyClass } from 'app.js';
import MyDefaultComponent from './MyDefaultExport';

const MyComponent = () => {};
export default MyComponent;
```

## 实例

通过以下方式在 html 中引入模块文件。
```html
<script type="module" src="main.js"></script>
```

+ top-level作用域独立同样适用于 `<script type="module">`
+ modules 自动使用 strict mode
+ 无需在 `<script>` 上加 _defer_ 属性，modules 执行是自动 deferred 推迟的。（即不 block HTML processing，与其他资源同时加载，在整个 page is loaded 后，根据 script 标签书写顺序执行
+ Module 代码只 executed 一次，Exports 也只创建一次 shared between importers.实践：在第一个 import 处 configure 模块（设置属性），在其他 imports 处共享此设置。
+ top-level 模块代码常用于初始化、创建内部数据结构
+ 每个 module 只能有一个 default 导出

```js
// square.js
export default randomSquare;
// main.js
import randomSquare from './square.js ';
// 等价于
import {default as randomSquare} from './square.js';
```

+ 可使用 `as` 关键词在 export 和 import 环节 rename 模块功能，避免命名冲突
+ 也可以通过创建 module 对象，抓取导入模块里所有 exports（使他们成为 module 对象的成员），相当于给定模块命名空间

```js
import * as Circle from './modules/circle.js';
import * as Square from './modules/square.js';

Circle.draw()
Circle.reportArea()
Square.draw()
Square.reportArea()
```

+ 此外还可以使用 class 来避免命名冲突，如果已经使用了 object-oriented 风格来书写模块代码
+ 聚合模块：将子模块 export 聚合到共同的父模块，简化代码
+ 动态模块加载：返回 Promise 包含一个 module 对象，用法同上

```js
import('./modules/myModule.js')
  .then((module) => {
    // Do something with the module.
  });
```

+ 顶层 await，让模块变成一个异步函数，代码在被父模块使用前 evaluated，而不 block 同级模块的加载

```js
// fetch request
const colors = fetch('../data/colors.json')
	.then(response => response.json());

export default await colors;
```

+ 模块内部 `this` 是 undefined


## CommonJS（Node.js）

## RequireJS（基于AMD模块系统）

RequireJS 是一个非常小巧的JavaScript模块载入框架（防止js加载阻塞页面渲染），是AMD规范最好的实现者之一，同时可以和其他的框架协同工作。
