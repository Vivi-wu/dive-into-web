---
title:  "React H5开发实践"
category: JavaScript
---
最近响应公司大前端统一技术栈的号召，新项目都是基于 React 开发。时隔几年很庆幸框架引入了 Hooks，在掌握了基本概念后，使用 Hooks 开发敲代码飞起。

## HOOK

动机：React 需要为**共享状态逻辑**提供更好的原生途径。

使用 Hook 从组件中提取状态逻辑，使得这些逻辑可以**单独测试**并**复用**。将组件中相互关联的部分拆分成更小的函数（比如设置订阅或请求数据）

问题表现： class 中生命周期函数经常包含不相关的逻辑。如：获取数据，事件侦听、消除。相互关联且需要对照修改的代码被拆分在不同的钩子函数里，而完全不相关的代码却在同一个方法中组合在一起。如此很容易产生 bug，并且导致逻辑不一致。

忘记正确地处理 componentDidUpdate 是 React 应用中常见的 bug 来源。

在多数情况下，不可能将组件拆分为更小的粒度，因为状态逻辑无处不在。这也是很多人将 React 与**状态管理库结合使用**的原因之一。

Class的问题： 事件处理绑定 `this`，代码冗余繁琐。使用 class 组件会无意中鼓励开发者使用一些让打包工具的优化措施无效的方案，不好压缩，让热重载不可信。

为了解决这些问题，Hook 使你**在非 class 的情况下**，即函数组件里，也可以使用更多的 React 特性。

从概念上讲，React 组件一直更像是函数。而 Hook 则拥抱了函数。

建议：先在新的不复杂的组件中尝试使用 Hook，并确保团队中的每一位成员都能适应。

### State Hook

`useState()` 是 React 内置的 Hook，使我们能在函数组件里保持 React 局部 state。

它返回一对值：**当前**状态和一个让你**更新**它的函数。

一般来说，在函数退出后变量就会“消失”，而 Hook 中 state 变量会被 React 保留（在重新渲染之间记住当前的值，并提供最新的值给我们的函数）。

state hook 唯一的入参是**初始**state，值的类型不必是 object。

一个组件内可以多次使用 state hook 来声明多个 state 变量。

state 变量可以存储 object 和 array，所以我们仍然能将相关的数据分为一组。state 更新总是 replace 而不是 merge

### Effect Hook

在 React 组件中执行数据获取、订阅或者从 React 组件里手动修改 DOM，这些操作我们称之为“（副）作用 side effects”。

多数情况下，我们希望在组件加载和更新时执行同样的操作，这就导致使用 class 编写的组件在上述两个钩子函数里要写重复的代码/调用相同的函数。

通过 `useEffect` 我们可以在函数组件里实现 class 组件 `componentDidMount `、`componentDidUpdate` 相同的功能，即由 React 保证 **每次渲染**（包括**第一次渲染**）DOM 之后调用“副作用”函数。

Hook 拥抱了 JavaScript 的闭包机制，我们传递给 useEffect 的函数就是我们的 effect。因为 hook 在函数作用域内，因此在 effect 中可以直接访问组件内部的 state 变量（或其他 props）。

```js
useEffect(() => {
  document.title = `You clicked ${count} times`;
});
```

每次re-render，我们 schedule a different effect 代替前一个，每一个 effect 都属于一个特殊的 render。

使用多个 effect 来分离关注点/不相关的逻辑，React 将按照 effect 声明的顺序**依次调用**组件中的每一个 effect。 

#### 无需 cleanup 的 effect

一些在 DOM 更新后运行的代码，如网络请求、手动 DOM 修改等，在执行后就可以被忘掉，我们称之为不需要清理的 effect。

使用 useEffect 调度的 effect 不会阻塞浏览器更新屏幕。大部分 effect 不需要同步进行，少数情况如“测量布局”，可以单独使用 useLayoutEffect

#### 需要 cleanup 的 effect

比如订阅外部资源，这些需要清理，否则将引起内存泄露。

每个 effect 通过**返回一个函数**来指定 React 在组件销毁时如何清除副作用。返回的函数的命名非必须。

React 在执行下一个 effect 之前对上一个 effect 进行清除。这种默认行为避免了 class 组件里经常由于缺失 update 逻辑导致的bug。

#### 性能优化

每次渲染后都执行清理或者执行 effect 可能会导致性能问题。通过以数组形式向 useEffect 传入第二个可选的参数，告诉 React 在 re-render 时，如果某个值没有变化，跳过 effect 的执行。

如果数组中有多个元素，即使只有一个元素发生变化，React 也会执行 effect。

```js
useEffect(() => {
  document.title = `You clicked ${count} times`;
}, [count]); // 仅在 count 更改时更新
```
如果你要使用此优化方式，需确保数组中包含了所有组件作用域中会随时间变化并且在 effect 中使用的变量.

如果希望只运行和清理一个 effect 一次，可以传入空数组([]). 告诉 React 这个 effect 不依赖任何 props 或 state 的值，注意：这样做 effect 内部的 props 或 state 的值将**永远是初始值**。

### 自定义 Hook

Hook 是一种复用状态逻辑的方式，每次调用都有一个完全独立的 state，因此可以在单个组件中多次调用同一个自定义 Hook。（那side effect不是会重复调用吗？？）

好处：不会在 tree 上添加更多的组件。目前项目里还没有用到自定义 hook。

约定：如果函数的名字以 “use” 开头并调用其他 Hook，这就是一个自定义 Hook。这种命名约定也方便 linter 插件在使用 Hook 代码里查找 bug

### 使用规则

1. 只能在 React 函数组件或者自定义的 Hook 中调用 Hook
2. **不要**在循环、条件判断或者子函数中调用 Hook。想要有条件地执行一个 effect，可以将判断放到 Hook 的内部
3. 按照代码的用途分离
4. 如果新的 state 需要通过使用先前的 state 计算得出，将箭头函数传递给 setState。该函数接收先前的 state，并返回一个更新后的值。

用class写，如果有使用timer，很容易忘记在unmounted函数里面clear计时器

## 引入图片

除了在文件顶部使用 import 方式作为变量引入，还可以直接在组件上通过 require 引入

```js
<img rc={require('image/product.png')} alt='prodcut' />
```

## 路由

react-router-dom 的 Hooks 中的 `useHistory` 只能用在函数式组件里.

使用底层 `<Router>` 最常见的情况是将自定义历史记录与状态管理库（如Redux或Mobx）进行同步。但是 React Router 并不是一定要根状态管理库一起使用，它仅用于深度集成 history。

## Context

这个感觉实现了部分状态管理工具的功能。

技术方案到底写什么——技术方案就是写你计划如何实现需求中的功能。拿这个评论项目来说，发布功能如何实现？要调用什么接口，输入输出时什么？要不要考虑 xss 攻击？再如点赞，是先执行动画再调用接口，还是先调用接口再执行动画？还有，你的代码如何拆解，分几个模块，有哪些核心的方法。
