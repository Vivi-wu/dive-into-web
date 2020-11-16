---
title:  "React.js 入门（三）"
category: JavaScript
---
## Forms 表单

HTML 表单元素（如 `<input>`、`<textarea>`、`<select>`）通常维护自己的状态并根据用户输入进行更新。表单提交默认行为的刷新页面，但大多数情况下我们希望通过JS处理数据提交。在 React 里通过受控组件实现。

当一个表单输入元素的 value 由 React state 控制，称之为 controlled component。

以下受控组件的使用非常相似：

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

<!--more-->

以下受控组件在各浏览器中表现一致：

`<input type="text">` 或 `<textarea>` 值的改变，覆盖 DOM 内置的 `oninput` 事件处理函数

`<input>` 多选框或单选框 _checked_ 状态的改变

`<option>` _selected_ 状态的改变

当需要处理多个 input 元素时，我们可以给每个元素添加 name 属性，并让处理函数根据 `event.target.name` 的值来选择要更新的状态。

要编写一个非受控组件，而不是为每个状态更新都编写数据处理函数，你可以 使用 ref 来从 DOM 节点中获取表单数据。

注意：如果设置了 `value` 值，input 框仍然可以编辑，很可能是你不小心把 value 设为了 undefined 或者 null

### 非受控组件

如果输入组件不含 `value` 属性的称为 uncontrolled component 不受控组件。可以像受控组件一样给 onChange 属性绑定处理函数。

`<input type="file">` 的 value 是只读的，所以它是 React 中的一个非受控组件。

## 组件生命周期 Lifecycle methods

React 提供 **will**（在事件发生前）和 **did**（在事件发生后）方法，即 Lifecycle Methods。

当组件第一次被渲染进 DOM 的时候，被称为“挂载（mount）”。当 DOM 中 组件被删除的时候，在 React 中被称为“卸载（unmount）”。

### Mounting

组件第一次被渲染进 DOM 的时间，称为 mounting。

一个组件的实例被创建和插入 DOM 的过程：

`constructor()`，初始化 state 数据，绑定成员函数的 this 环境。无状态的 React 组件不需要定义构造函数。

`componentWillMount()`，所有可以在这个函数中做的事都可以提前到 constructor 中做。

`render()`，返回 JSX 表示对象。

`componentDidMount()`，组件的 render 函数执行完毕，组件第一次输出呈现到 DOM 之后调用此函数。只在**浏览器端**调用，因为服务器端渲染不会产生 DOM 树。在这个钩子函数里做 DOM 节点的初始化、执行 ajax call，这样可以使用 setState 更新组件状态

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

`componentWillUnmount()`，在此函数里做一些清理工作，如 clear timer

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

## Fragments

有时为了让 React 运行，我们在 JSX 里添加 `<div>` 作为根节点，破坏了 HTML 的语义。如： lists (`<ol>`, `<ul>` and `<dl>`) 还有 `<table>`。此时可以使用 `<Fragment></Fragment>` 作为根节点。缩写形式：`<></>`

### Prop Validation

prop 是组件的对外接口，那么应该可以规范：支持哪些 prop，每个prop 应该是什么格式。

出于性能考虑，仅在开发阶段进行 `propTypes` 检查。若有 invalid value，会在浏览器 JS console 中报错。

```js
class Greeting extends React.Component {
  render() {
    return (
      <h1>Hello, {this.props.name}</h1>
    );
  }
}
Greeting.propTypes = {
  name: React.PropTypes.string
};
```

更多用法参考[这里](https://facebook.github.io/react/docs/reusable-components.html).

### Default Prop values

通过 `defaultProps` 给父组件的 _props_ 设置默认值。使我们可以安全地使用 props，不必担心没有值，也避免重复书写。

```js
class Greeting extends React.Component {
  render() {
    return (
      <h1>Hello, {this.props.name}</h1>
    );
  }
}
// Specifies the default values for props:
Greeting.defaultProps = {
  name: 'Stranger'
};
// Renders "Hello, Stranger":
ReactDOM.render(
  <Greeting />,
  document.getElementById('example')
);
```

无状态的函数仍然可以设置 `propTypes` 和 `defaultProps`。

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
