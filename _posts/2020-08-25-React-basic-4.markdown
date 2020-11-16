---
title:  "React.js 入门（四）"
category: JavaScript
---
## Thinking in React

当你在创建app时， React是如何使你思考的。

1. Break The UI Into A Component Hierarchy，根据设计图，用方框画划分出组件层级。以“single responsibility principle”**单一责任**原则，划分组件。UI和数据模型倾向于遵循相同的信息体系结构。
2. Build A Static Version in React，用 React 构建一个静态版。（用已有的数据模型渲染一个不包含交互功能的 UI）通过 _props_ 传递数据，完全不使用 _state_（state 仅保留用于交互）。简单例子，自上而下写组件；大型项目，自下而上写，顺便写下test case。
3. Identify The Minimal (but complete) Representation Of UI State，确定 UI 所需**最少**的可变状态。以**Don't Repeat Yourself**原则。以下情况可以**排除**使用 _state_:

  + 通过 props 从父组件传进来
  + 不随时间改变
  + 可以基于当前组件其他 state 或 props 计算得到

4. Identify Where Your State Should Live，鉴定哪个组件应该拥有这个状态，铭记 React 是单向数据流。对于应用中每一个 state，看看哪些组件需要基于它来渲染，找到公共 owner（在所有需要这个 state 的组件层级树之上）组件，如果没找到合适的组件，单独创建一个新的来 hold 这个状态
5. Add Inverse Data Flow，最后通过 `setState()` 方法，支持反向的数据流动

用以上方式写 React 会比我们习惯的方式多一些 typing。但是请 remember that code is read far more than it’s written, and it’s less difficult to read this modular, explicit code。

比起写，代码更多地是给人看的。当你开始构建更大的组件库时，你会意识到这种代码模块化和清晰度的重要性。并且随着代码重用程度的加深，你的代码行数也会显著地减少。

React 是 one-way data flow（单向数据流）。

## Redux

什么时候需要用Redux：

+ 跨多层组件共享状态/数据，不好追踪，还会引起性能问题，每一个数据变动引起所有子组件重新渲染。
+ 通过 hot reload 提升开发效率。

**不建议**使用inline style，除非需要在render time动态添加计算的样式。

file structure：一个项目中文件层级嵌套不要超过3-4层。

Virtual DOM：更多的是一种模式，而不是一种特定的技术。在 React 的话术里，经常与 React elements 相关，它们是代表UI的对象。

[Redux vs. MobX](https://blog.logrocket.com/redux-vs-mobx/)

Redux:
+ 单一 store（一个巨大的 JSON 对象）
+ store中的state不可变
+ 通过action触发改变
+ 通过reducers更新状态

MobX：
+ 可以有多个 store（许多应用设计有至少2个sote，一个为当前应用设计的UI store，一个可复用的领域状态）
+ 无需进一步交互的任何可从state推导出的东西，都是推导
+ action是可以改变state的一段代码
+ state改变时，所有推导自动更新

popularity: Redux
learning curve：Mobx（Redux - Flux architecture and functional programming concepts；MobX - object-oriented programming，writing less code）
data structure：MobX（Redux：纯JS对象存储state，需手动跟踪变化，更难维护大型状态；MobX使用可观察数据，通过隐式订阅自动跟踪更改）
代码量：MobX（Redux 本质上是显式的，必须对许多功能进行显式编码。MobX相比代码量少，易于学习和设置）
Developer community：Redux（从github start数、npm周下载量）
scalability： Redux（纯函数易扩展、测试）

如果您希望快速起步并以更少的代码构建简单的应用程序，那么选 MobX。

Redux 是 pure 的，function(state, action) => newState
MobX 中状态是可变的，是 impure 的。难以测试和维护，不总是返回可预测的输出。
