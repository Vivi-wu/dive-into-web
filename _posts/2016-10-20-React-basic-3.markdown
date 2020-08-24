---
title:  "React.js 入门（三）"
category: JavaScript
---
## Forms 表单

`<input>`, `<textarea>` 和 `<select>` 之类的标签，通常保持自己的状态，并根据用户输入更新状态。当一个表单输入元素的 value 由 React state 控制，称之为 controlled component 受控组件。

以下受控组件在各浏览器中表现一致：

`<input type="text">` 或 `<textarea>` 值的改变，覆盖 DOM 内置的 `oninput` 事件处理函数

`<input>` 多选框或单选框 _checked_ 状态的改变

`<option>` _selected_ 状态的改变

<!--more-->

受控组件使用：

```js
<input type="text" value={this.state.value} onChange={this.handleChange} />
<textarea value={this.state.value} onChange={this.handleChange} />
<select value={this.state.value} onChange={this.handleChange}>
  <option value="grapefruit">Grapefruit</option>
  <option value="lime">Lime</option>
  <option value="coconut">Coconut</option>
  <option value="mango">Mango</option>
</select>
```

如果输入组件不含 `value` 属性的称为 uncontrolled component 不受控组件。任何用户输入都直接反应在渲染的元素上。可以像受控组件一样给 onChange 属性绑定处理函数。

因为 `<input type=“file”>` 的 value 只读，所以它是 React 中的一个非受控组件。

当需要处理多个 input 元素时，我们可以给每个元素添加 name 属性，并让处理函数根据 `event.target.name` 的值来选择要更新的状态。

要编写一个非受控组件，而不是为每个状态更新都编写数据处理函数，你可以 使用 ref 来从 DOM 节点中获取表单数据。

## 组件生命周期 Lifecycle

React 提供 **will**（在事件发生前）和 **did**（在事件发生后）方法，即 Lifecycle Methods。

当组件第一次被渲染进 DOM 的时候，被称为“挂载（mount）”。当 DOM 中 组件被删除的时候，在 React 中被称为“卸载（unmount）”。

### Mounting

组件第一次被渲染进 DOM 的时间，称为 mounting。

一个组件的实例被创建和插入 DOM 的过程：

`constructor()`，初始化 state 数据，绑定成员函数的 this 环境。无状态的 React 组件不需要定义构造函数。

`componentWillMount()`，所有可以在这个函数中做的事都可以提前到 constructor 中做。

`render()`，返回 JSX 表示对象。

`componentDidMount()`，调用所有组件的 render 函数之后，组件输出呈现到 DOM 之后调用此函数。只在**浏览器端**调用，因为服务器端渲染不会产生 DOM 树。在这个钩子函数里做 DOM 节点的初始化、执行 ajax call，这样可以使用 setState 更新组件状态

### Updating

一次更新可以由 props 或者 state 的变化引起。当一个组件被重新渲染时，以下方法被调用。

`componentWillReceiveProps()`

`shouldComponentUpdate(nextProp, nextState)`，返回一个布尔值，告知 React 该组件在这次更新中是否需要继续。默认返回 true，即每次更新都要重新渲染。通过定制该函数 可提高性能。

`componentWillUpdate()`

`render()`，同 mounting 过程

`componentDidUpdate()`，无论更新过程发生在 server 端还是 browser 端，都会被调用。正常情况下 server 端只产出 HTML 字符串，不会调用此函数。

### Unmounting

当组件创建的 DOM 被移除时，称为 unmounting

对应方法：

`componentWillUnmount()`，在此函数里写一些清理工作。

## `Refs` and the DOM

```js
class CustomTextInput extends React.Component {
  constructor(props) {
    super(props);
    // Create a ref to store the textInput DOM element
    this.textInput = React.createRef();
  }
  render() {
  // Use the `ref` callback to store a reference to the text input DOM
  // element in an instance field (for example, this.textInput).
    return (
      <input
        type="text"
        ref={this.textInput}
      />
    );
  }
}

focus() {
  // Explicitly focus the text input using the raw DOM API
  // Note: we're accessing "current" to get the DOM node
  this.textInput.current.focus();
}
```

When attaching a ref to a DOM component like `<div />`, you get the DOM node back

看以下代码片段：

```js
render: function() {
  return <TextInput ref={(c) => this._input = c} />;
},
componentDidMount: function() {
  this._input.focus();
}
```

when attaching a `ref` to a composite component like `<TextInput />`, you'll get the **React class instance**. 这样就可以像上例中所示，调用那个组件的 class 定义中对外暴露的方法。

The referenced component will be passed in as a parameter, and the callback function may use the component immediately, or save the reference for future use (or both).
包含 `ref` 的组件将作为 `ref` 所绑定回调函数的参数被使用。

By default, use the Reactive data flow and save refs for use cases that are inherently non-reactive. 默认情况下鼓励使用 React 的数据流（props 和 state）。

## animation

+ You must provide the key attribute for all children of ReactCSSTransitionGroup, even when only rendering a single item. This is how React will determine which children have entered, left, or stayed.
+ You'll notice that animation durations need to be specified in both the CSS and the render method; this tells React when to remove the animation classes from the element and -- if it's leaving -- when to remove the element from the DOM. 自定义 animation 样式时不仅在 css 中要指定时间，在组件的属性上也要指定。

### code spliting

随着app变大，考虑code spliting。比较好的实践是根据路由来拆分代码。

### 官方文档错误

Using Global Variables，Alternatively, you can force the linter to ignore any line by adding  `// eslint-disable-line` after it.
不起作用。应该使用 `// eslint-disable-next-line`
或者在文件最开始处，`/*global fbq, gtag*/` 告诉eslint全局变量名
`

## Thinking in React

当你在创建app时， React是如何使你思考的。

1. Break The UI Into A Component Hierarchy，根据设计图，用方框画划分出组件层级。以“single responsibility principle”单一责任原则，划分组件。UI和数据模型倾向于遵循相同的信息体系结构。
2. Build A Static Version in React，用 React 构建一个静态版。（用已有的数据模型渲染一个不包含交互功能的 UI）通过 _props_ 传递数据，完全不使用 _state_（state只在有交互时使用）。简单例子，自上而下写组件；大型项目，自下而上写，顺便写下test case。
3. Identify The Minimal (but complete) Representation Of UI State，确定 UI 所需**最少**的可变状态。以“Don't Repeat Yourself”原则。以下情况都可以**排除**使用 _state_:

  + 变量通过 props 从父组件传进来
  + 不随时间改变
  + 可以基于当前组件的 state、props 计算得到

4. Identify Where Your State Should Live，鉴定哪个组件拥有这个状态，铭记 React 是单向数据流。对于应用中每一个state，看看哪些组件需要基于它来渲染，找到公共owner组件（在所有组件层级树之上的）
5. Add Inverse Data Flow，支持反向的数据更新，通过 `setState()` 方法。

用以上方式写 React 会比我们习惯的方式多一些typing。但是请 remember that code is read far more than it’s written, and it’s less difficult to read this modular, explicit code.比起写，代码更多地是给人看的。当你开始构建更大的组件库时，你会意识到这种代码模块化和清晰度的重要性。并且随着代码重用程度的加深，你的代码行数也会显著地减少。

React 是 one-way data flow（单选数据流）。

## 实践中遇到的问题

### 输出 HTML tag 而不是 string

Improper use of the innerHTML can open you up to a cross-site scripting (XSS) attack. 而 React 的设计哲学是让制作东西容易且安全。开发人员需要明确指出他们要进行 unsafe 的操作。因此想要输出 HTML tag 时，需要做到两点：

1. 在要改变 innerHTML 属性的元素上添加 `dangerouslySetInnerHTML` 特性，通常给它绑定一个自定义函数，把需要 render 的值传进去.
2. 自定义函数只需要返回一个只包含 `__html` 属性的对象。属性值为传进去的 DOM string. 确保 HTML provided must be well-formed (ie., pass XML validation).

### 动态内容中输出 HTML Entity

通常通过 literal 文本可在 JSX 中直接插入 HTML 实体。

但当使用动态内容展示时，如 `<div>{'First &middot; Second'}</div>`，结果 HTML 实体并不能按预期展示出来。解决方法：

1. 最简单的办法是在 JS 中直接写 Unicode 字符。需要**保证文件按 UTF-8 格式保存**，浏览器也按照 UTF-8 格式显示。
2. 一种更安全的方法是找到**实体对应的 unicode number**，如下：

```js
<div>{'First \u00b7 Second'}</div>
<div>{'First ' + String.fromCharCode(183) + ' Second'}</div>
```

## 2019.9.18
[Getting Started with React - An Overview and Walkthrough Tutorial](https://www.taniarascia.com/getting-started-with-react/)

[用react开发一个井字游戏教程](https://zh-hans.reactjs.org/tutorial/tutorial.html)

在 React 应用中，数据通过 props 的传递，从父组件流向子组件。

在 JavaScript class 中，每次定义其子类的构造函数时，都需要调用 super 方法。因此，在所有含有构造函数的的 React 组件中，构造函数必须以 super(props) 开头。

使用 CodePen 在线编辑器如何正确使用React DevTools？

1. 登录或注册。
2. 点击 “Fork” 按钮。
3. 在“Open this Pen in:”选择 “Debug mode”。
4. 上一步会打开一个新的标签页，此时打开开发者工具就会有一个 React 选项卡，并且在“⚛️ Components”里可以看到干净的组件树。

当需要同时获取多个子组件的数据，或者两个组件之间需要相互通信，需要把子组件的 state 数据提升至其共同的父组件当中保存。

父组件通过 props 将状态数据传递到子组件当中。这样应用当中所有组件的状态数据就能够更方便地同步共享了。

### tips

尽管 this.props 由 React 本身设置的，this.state 有特殊的含义，我们可以向 class 中随意添加**不参与数据流**的额外字段（如，this.timerID）。

props：
1.devTool中对应的 component 默认全部打开
2.因为是js报错可显示对应的Line *
3.没有 v-model 的 trim 等修饰符

子组件 state 没更新是不会触发 render 渲染的。

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
