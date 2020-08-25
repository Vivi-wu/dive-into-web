---
title:  "React.js 入门（二）"
category: JavaScript
---
本章主要写 React 的数据操作

## state 状态

state 对于拥有和设置它的 React 组件是 private 的（任何其他组件都不接近）。组件可以向下传递 state 及其派生的状态给子组件。

当数据变化时，通过调用 `this.setState(data, callback)` 把数据合并到组件私有属性 `this.state` 中，驱动组件重新 render 自己。其中 callback 是可选的。

+ constructor 是唯一可以给 this.state 赋值的地方
+ 直接修改 state 的值**不会重新渲染**组件，必须使用 `setState()`
+ 出于性能考虑，React 可能会把多个 setState() 调用合并成一个更新。因为 this.props 和 this.state 可能会**异步更新**，所以**不要依赖**他们的值来更新下一个状态

<!--more-->

解决上面的问题，使用 setState 方法的第二种形式，以 function 作为入参，而不是 object。

```js
// 第一个参数是 previous state，第二个参数是更新时的 props
this.setState((state, props) => ({
  counter: state.counter + props.increment
}));
```

### Lifting State Up 状态提升

在 React 中，将多个组件中共享的 state 向上移动到最近的共同父组件中，实现共享 state，称之为“状态提升”。

在 React 应用中，任何可变数据应当只有一个相对应的唯一“数据源”。通常，state 都是首先添加到需要渲染数据的组件中去。然后，如果其他组件也需要这个 state，那么你可以将它提升至这些组件的最近共同父组件中。

依赖于自上而下的数据流，“存在”于组件中的任何 state，仅有组件自己能够修改它，因此 bug 的排查范围被大大缩减了。

### 什么样的组件应该拥有 State

有时你需要响应**用户输入**、**服务器请求**或者时间的流逝，这时就要用到 State。

但是尽可能使你的大部分组件 stateless 无状态，减少冗余。

一个常见的模式就是创建一些没有状态的组件，仅用来渲染数据，然后把它们内嵌在一个 stateful 的父组件里。父组件通过 props 把 state 传递给子组件。

```js
// Stateless Function
const Greeting = (props) => (
  <h1>Hello, {props.name}</h1>
);
ReactDOM.render(
  <Greeting name="Sebastian" />,
  document.getElementById('example')
);
```

### 什么不应该放在 State 中

+ 根据其他 state 或 props 计算出该数据的值
+ 由父组件通过 props 传递而来的。凡是有例外：当需要指定 previous 的值时，可以把 props 中取得的值存在私有状态中。因为父组件重新渲染时，props 值也会变。
+ 随时间的推移而保持不变

## Handling Events 事件处理

尽管事件处理器看似被内联地渲染（直接写在 React 组件上，看起来像 inline 绑定），但它们本质是使用了事件委托的方式处理同一类事件。无论有多少个同类事件出现，最后只在顶层DOM节点上添加一个事件处理函数。

命名规范：

- 将代表事件监听**属性**命名为 on[Event]
- 将处理事件监听**方法**命名为 handle[Event]
- 对于内置组件，如 `<button>` 元素的点击事件使用 onClick 这对于 React 有特殊的含义

事件名以小驼峰式 **camelCase** 绑定事件处理函数，同 JSX 用法要求

在 React 中不能通过return false 的方式**阻止默认行为**，必须显式地使用 `preventDefault`。

React 事件处理函数里，入参 e 是一个合成事件。React 根据 W3C 规范来定义这些合成事件，不需要担心跨浏览器的兼容性问题。

函数式组件，事件处理函数自动绑定它所属的组件实例:

```js
function ActionLink() {
  function handleClick(e) {
    e.preventDefault();
    console.log('The link was clicked.');
  }

  return (
    <a href="#" onClick={handleClick}>
      Click me
    </a>
  );
}
```

使用 ES6 class 语法（class组件）时，需手动绑定 this:

```js
class SayHello extends React.Component {
  constructor(props) {
    super(props);
    // 为了在回调中使用 `this`，必须手动绑定 this 到当前实例对象
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick() {
    alert('Hello!');
  }

  render() {
    // Because `this.handleClick` is bound, we can use it as an event handler.
    return (
      <button onClick={this.handleClick}>
        Say hello
      </button>
    );
  }
}
```

如果嫌 bind 麻烦，建议使用 class fields 语法，该语法在 Create React App 里默认支持:

```
class LoggingButton extends React.Component {
  // This syntax ensures `this` is bound within handleClick.
  // Warning: this is *experimental* syntax.
  handleClick = () => {
    console.log('this is:', this);
  }

  render() {
    return (
      <button onClick={this.handleClick}>
        Click me
      </button>
    );
  }
}
```
你也可以在 callback 里使用箭头函数。

这种语法的问题是每次组件 render 都创建一个新的 callback，大部分情况下ok。但如果该 callback 作为 props 传递给子组件，子组件可能会做一个额外的 re-rendering，带来性能影响。

### 给事件处理函数传参

两种方式下 React event 作为 id 后的参数传入，只不过箭头函数需要显式的传递。

```js
<button onClick={(e) => this.deleteRow(id, e)}>Delete Row</button>
<button onClick={this.deleteRow.bind(this, id)}>Delete Row</button>
```

当在循环里绑定函数时，可以考虑使用 `data-*` 属性存储数据。[参考](https://reactjs.org/docs/faq-functions.html#example-passing-params-using-data-attributes)

## 条件渲染

在 JSX 中使用大括号 `{}` 内嵌条件渲染表达式：

通过 `expression && element` 在 JSX 中实现 inline 的 if 渲染组件。因为 true && expression 总是返回 expression，而 false && expression 结果为 false，React 会忽略。

通过 `condition ? elementA : elementB` 在 JSX 中实现 inline 的 if-else 渲染组件。

### 阻止组件渲染

某些情况下你希望一个组件隐藏，即使它曾经被其他组件渲染。方式： `return null`。这不影响组件的生命周期方法执行。

## Lists and Keys

在 React 中将数组转为 React elements 组成的列表，与使用 js array 方法产生新数组是一样的。

在构建动态列表的时候，强烈建议指定一个合适的 key.

如果没有指定任何 key，React 会发出警告，并且会把数组的索引当作默认的 key。

如果不会对列表进行重新排序、插入、删除操作，以数组索引作为 key 是安全的，反之，则不然。

组件的 key 值并不需要在全局都保证唯一，只需要在当前的同一级元素（兄弟节点）之间保证唯一即可。

`Key` 是 React 特殊保留属性，不会传递给子组件（不能通过 `props.key` 获取）。

```js
render() {
  return (
    <ol>
      {this.props.results.map((result, index) => (
        <li key={index}>{result.text}</li>
      ))}
    </ol>
  );
}
```

这个 _key_ 属性必须直接**在数组**方法中提供给组件:

```js
// WRONG! There is no need to specify the key here:
class ListItemWrapper extends React.Component {
  render() {
    return <li key={this.props.data.id}>{this.props.data.text}</li>;
  }
}
class MyComponent extends React.Component {
  render() {
    return (
      <ul>
        {this.props.results.map((result) => ( // The key should have been specified here:
          <ListItemWrapper data={result} />   // <ListItemWrapper key={result.id} data={result} />
        ))}
      </ul>
    );
  }
}
```

原理：当列表重新渲染，React 将拿每个新列表项的 key 与旧列表项进行比对。如果当前列表中的 key 在旧列表不存在，则创建一个新组件；如果当前列表中缺少旧列表中的某个key，则销毁旧列表中对应的组件；如果两个列表中 key 匹配，则更新对应组件。

Keys 告诉 React 每个组件的身份，以便 React 在重新渲染之间保持状态。如果组件的 key 改变，则组件被销毁，并以全新的 state 重新创建。

## Composition

有些组件无法提前知晓子组件的具体内容，可以使用一个特殊的 `{props.children}` 在组件里预留位置，将任意子组件传递到渲染结果中。

少数情况下，你可能需要在一个组件中预留出多个“洞”。这种情况下，可以自行约定，自定义 `props` 的属性（类似 vue 的具名插槽）

在 React 中没有“槽”这一概念的限制，组件可以接受任意 props，包括原始值、React 元素以及函数。

```js
function SplitPane(props) {
  return (
    <div className="SplitPane">
      <div className="SplitPane-left">
        {props.left}
      </div>
      <div className="SplitPane-right">
        {props.right}
      </div>
    </div>
  );
}

function App() {
  return (
    <SplitPane
      left={
        <Contacts />
      }
      right={
        <Chat />
      } />
  );
}
```

props和composition在自定义组件时提供了足够的灵活性。如果你想要复用非UI功能，建议将其抽出为单独的 js 模块。无需 extend，通过 import 进来使用。
