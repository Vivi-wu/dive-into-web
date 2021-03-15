---
title:  "Front End Interview"
category: Other
---
面试知识点总结。

## 模块化

将 JS 分成独立的模块，在需要时引入。注意，模块的功能被引入单一脚本的作用域，它们非全局作用域可见

### CommonJS（Node.js）

### RequireJS（基于AMD模块系统）

### ES的 Modules

现代浏览器原生支持模块功能。在想要导出模块的 item 前加 `export`，通过 `import` 语句在 `{}` 中以逗号分隔引入需要的功能。 

通过以下方式在 html 中引入模块文件。
```html
<script type="module" src="main.js"></script>
```

+ modules 自动使用 strict mode
+ 无需在 `<script>` 上加 _defer_ 属性，加载 modules 是自动 deferred 推迟的
+ 不论有多少个 `<script>` 引用，modules 都只执行一次
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
+ 动态模块加载：返回 Promise 包含一个 module 对象，用法同上
+ 聚合模块：将子模块 export 聚合到共同的父模块，简化代码

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

## 网络

Http协议，h2，https，websocket

### OSI网络分层

https://www.huaweicloud.com/articles/7a131ec5aab5d8e9e178f9c03dc478d1.html

## 算法

https://leetcode-cn.com/problems/count-primes/solution/ji-shu-zhi-shu-by-leetcode-solution/

