---
title:  "JavaScript Event order"
category: JavaScript
---
本文从 [这篇文章](http://www.quirksmode.org/js/events_order.html) 里翻译主要内容。

## 问题描述

假设有两个元素：element 1 和 element 2，

元素 1 是元素 2 的父元素，两者都绑定了 _onClick_ 事件处理函数，现在用户点击了元素 2，那么问题来了：

该行为在两个元素上都引起了点击事件，那么哪一个元素上的事件处理函数**先执行**？

在探讨上面的问题时，先来看一下模型。

<!--more-->

### Two models

在过去，关于事件执行顺序，Netscape 认为，元素 1 的 event handler 先执行，称为 event **capturing** 事件**捕捉**。

<img src="{{ "/assets/images/capturing.png" | prepend: site.baseurl }}" alt="Event capturing">

Microsoft 认为元素 2 的 event handler 先执行，称为 event **bubbling** 事件**冒泡**。

<img src="{{ "/assets/images/bubbling.png" | prepend: site.baseurl }}" alt="Event bubbling">

W3C 在这个纷争里选择了中立态度，在 W3C 事件模型里，任何事件首**先**被**捕捉**，直到事件到达目标元素，接着**再冒泡**上来。

<img src="{{ "/assets/images/w3c_event_model.png" | prepend: site.baseurl }}" alt="w3c event model">

作为开发人员，可以决定是在捕捉阶段，还是冒泡阶段来注册事件处理函数，通过 `addEventListener()` 方法。

该函数最后一个参数如果为 `true`，表示为 capturing **捕捉阶段注册事件 handler**，若设为 `false`，则表示为 **冒泡阶段注册事件 handler**。

## 区别举例

下面通过举例说明，不同的事件注册函数设置，会有什么不同结果。

情况一：

    element1.addEventListener('click',doSomething2,true)
    element2.addEventListener('click',doSomething,false)

1. click 事件首先开始于 capturing 阶段。事件检查**元素 2**是否有任何祖先元素，在捕捉阶段注册了 event handler。
2. 找到了！**元素 1** 的 `doSomething2()` 被执行。
3. 事件一直向下传递直到到达目标本身，再没有找到任何 handler for 捕捉阶段。接着，事件进入 bubbling 阶段，执行**元素 2** 为冒泡阶段注册的 `doSomething()`
4. 事件再次向上传递，检查目标元素是否有任何祖先元素，在冒泡阶段注册了 event handler。没有！所以没有事都没发生。

情况二：

    element1.addEventListener('click',doSomething2,false)
    element2.addEventListener('click',doSomething,false)

1. click 事件开始于 capturing 阶段。事件检查**元素 2**是否有任何祖先元素，在捕捉阶段为 _onclick_ 注册了 event handler。没有！
2. 事件一直向下传递直到到达目标本身。接着，事件进入 bubbling 阶段，执行**元素 2** 为冒泡阶段注册的 `doSomething()`
3. 事件再次向上传递，检查目标元素是否有任何祖先元素，在冒泡阶段注册了 event handler。
4. 找到了！**元素 1** 的 `doSomething2()` 被执行。

### Compatibility with traditional model

在支持 W3C DOM 的浏览器里，一个传统的事件注册如下：

    element1.onclick = doSomething2;

被**视为**是在 bubbling **冒泡阶段的注册**。

## 使用

Setting **document–wide** event handlers is **necessary** in **drag–and–drop** scripts.

因为任何事件 bubbling 最终会传到 document，把事件 handlers 注册在 document 级别，使得 _onmousemove_, _onmouseup_ 等事件处理函数总是能被执行，不管用户怎样移动鼠标。

### currentTarget

理解<span class="t-blue">在 capturing 和 bubbling 阶段（if any），目标元素 **dose not change** 不变</span>，这一点很重要！

在上面的例子里，目标 _target_ 总是保留一个指向**元素 2** 的 reference.

但是假设：

    element1.onclick = doSomething;
    element2.onclick = doSomething;

用户点击元素 2，函数 `doSomething()` 执行了两次，我们怎么知道当前是哪一个 HTML 元素在处理事件呢？

_target_ / _srcElement_ 都不能给出答案，因为他们都指向元素 2（事件最初的来源）

为了解决这个问题，W3C 添加了 _currentTarget_ 属性。它包含一个**指向当前在处理事件的 HTML 元素**的 reference.

也可以使用关键字 `this`，用法同 _currentTarget_ 。

<ins>不幸的是， Microsoft 事件注册模型中，`this` 关键字不指向 HTML 元素，也不包含类似 currentTarget 的属性</ins>。

### Turning it off

更多的情况下，你是希望关掉所有的 capturing 和 bubbling，为保持函数之间不要互现干扰。

Besides, if your document structure is very complex (lots of nested tables and such) you may save system resources by turning off bubbling. 如果你的文档结构非常复杂，bubbling 花费时间去查找每一个祖先元素。

下面说一下停止冒泡阶段的传递的方法。

IE 8 及以前版本的浏览器：

```js
window.event.cancelBubble = true
```

在 W3C 模型里：

```js
event.stopPropagation()
```

跨浏览器：

```js
function doSomething(e) {
  if (!e) var e = window.event;
  e.cancelBubble = true;  // 在不支持该属性的浏览器里这样做，也没事
  if (e.stopPropagation) e.stopPropagation();
}
```

## Event Loop

事件循环非 JS 独有。所谓的 Event Loop 是负责执行队列中的回调，并且将其压入到函数调用栈中的机制。

其中的调用栈（Call Stack，后入先出）会记录所有的函数调用信息。当我们调用某个函数时，会将其参数与局部变量等压入栈中；在执行完毕后，会弹出栈首的元素。而堆（Heap）则存放了大量的非结构化数据，譬如程序分配的变量与对象。队列（Callback Queue，先入先出）则包含了一系列待处理的信息与相关联的回调函数。

每个 JavaScript 运行时都必须包含一个任务队列。

譬如按钮点击或者 HTTP 请求响应都会作为消息存放在任务队列中；需要注意的是，仅当这些事件的回调函数存在时才会被放入任务队列，否则会被直接忽略。

JavaScript 中的任务分为 MacroTask 与 MicroTask 两种。

+ MacroTask 包含了 setTimeout, setInterval, setImmediate, requestAnimationFrame, I/O, UI rendering 等
+ MicroTask 包含了 process.nextTick, Promises, Object.observe, MutationObserver 等

## Promise

Promise.then 是异步执行的，而创建 Promise 实例 （executor）是同步执行的。

```js
(function test() {
  setTimeout(function() {console.log(4)}, 0);
  new Promise(function executor(resolve) {
    console.log(1);
    for( var i=0 ; i<1000 ; i++ ) {
        i == 999 && console.log(i);
    }
    console.log(2);
  }).then(function() {
    console.log(5);
  });
  console.log(3);
})();

// 执行结果：
// 1
// 2
// 3
// 5
// 4
```

### relatedTarget

只读属性。比如光标失焦事件，此时 ` relatedTarget` 指的是接收到 focus（光标聚焦的） `EventTarget`。对于无法聚焦的元素，该属性返回 null