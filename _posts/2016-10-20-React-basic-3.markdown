---
title:  "React.js 入门（三）"
category: JavaScript
---
表单组件

通过 `onChange` 属性侦听输入域值的变化，在各浏览器中表现一致：

`<input>` 或 `<textarea>` 值的改变，覆盖 DOM 内置的 `oninput` 事件处理函数

`<input>` 多选框或单选框 _checked_ 状态的改变

`<option>` _selected_ 状态的改变

输入组件包含 `value` 属性的称为 controlled component 受控组件。它的值完全反应其属性的值，而不受用户输入影响。因此要实现交互，给 onChange 属性绑定处理函数。

如果输入组件不含 `value` 属性的称为 uncontrolled component 不受控组件。任何用户输入都直接反应在渲染的元素上。可以像受控组件一样给 onChange 属性绑定处理函数。

可通过 `defautChecked` 给多选框、单选框，`defaultValue` 下拉选项、文本输入框等设置初始值。

组件生命周期

React 提供 **will**（在事件发生前）和 **did**（在事件发生后）方法。

### Mounting 组件被插入 DOM 的过程

`getInitialState()`，用来初始化 state 数据。

`componentWillMount()`，mounting 发生之前调用

`componentDidMount()`，mounting 发生之后调用，需要 DOM 节点的初始化写在这里

### Updating 组件被重新渲染去决定是否更新 DOM

### Unmounting 组件被从 DOM 中移除

`componentWillUnmount()`，组件被移除之前调用，Cleanup 写在这里

### `ref` 属性赋予 Callback 函数

When attaching a ref to a DOM component like `<div />`, you get the DOM node back

看以下代码片段：

    render: function() {
      return <TextInput ref={(c) => this._input = c} />;
    },
    componentDidMount: function() {
      this._input.focus();
    },

when attaching a `ref` to a composite component like `<TextInput />`, you'll get the **React class instance**. 这样就可以像上例中所示，调用那个组件的 class 定义中对外暴露的方法。

The referenced component will be passed in as a parameter, and the callback function may use the component immediately, or save the reference for future use (or both).
包含 `ref` 的组件将作为 `ref` 所绑定回调函数的参数被使用。

By default, use the Reactive data flow and save refs for use cases that are inherently non-reactive. 默认情况下鼓励使用 React 的数据流（props 和 state）。

## 语言工具

使用 Babel 把 JSX 语法的文件翻译成可以直接在浏览器中运行的 JS 文件。

更多使用中可能遇到的问题参考官网的[tips](https://facebook.github.io/react/tips/introduction.html)