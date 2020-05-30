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

## 组件生命周期

React 提供 **will**（在事件发生前）和 **did**（在事件发生后）方法，即 Lifecycle Methods。

当组件第一次被渲染到 DOM 中的时候，被称为“挂载（mount）”。当 DOM 中 组件被删除的时候，在 React 中被称为“卸载（unmount）”。

### Mounting

组件第一次被渲染进 DOM 的时间，称为 mounting。

一个组件的实例被创建和插入 DOM 的过程：

`constructor()`，初始化 state 数据，绑定成员函数的 this 环境。无状态的 React 组件不需要定义构造函数。

`componentWillMount()`，所有可以在这个函数中做的事都可以提前到 constructor 中做。

`render()`，返回 JSX 表示对象。

`componentDidMount()`，调用所有组件的 render 函数之后，组件输出呈现到DOM之后调用此函数。只在**浏览器端**调用，因为服务器端渲染不会产生 DOM 树。需要 DOM 节点的初始化写在这里。

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