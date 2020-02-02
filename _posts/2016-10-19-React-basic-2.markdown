---
title:  "React.js 入门（二）"
category: JavaScript
---
本章主要写 React 的数据操作

## 事件处理

React 保证所有事件在各种浏览器中表现一致，与 W3C spec 的冒泡和捕捉一致。本质是使用了事件委托的方式处理同一类事件。无论有多少个同类事件出现，最后只在顶层DOM节点上添加一个事件处理函数。

事件命名规范：
- 将代表事件的监听 prop 命名为 on[Event]
- 将处理事件的监听方法命名为 handle[Event] 这样的格式

采用小驼峰式 **camelCase** 的特性名绑定事件处理函数（区别于 HTML 元素的全小写 `onclick`）.

在 React 中另一个不同点是你不能通过返回 false 的方式阻止默认行为。你必须显式的使用 preventDefault。

事件处理函数里，入参 e 是一个合成事件。React 根据 W3C 规范来定义这些合成事件，所以你不需要担心跨浏览器的兼容性问题。

函数式组件，事件处理函数自动绑定它所属的组件实例。

注意：使用 ES6 class 语法（class组件）时，需手动绑定 this。

<!--more-->

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

如果嫌 bind 麻烦，可以在回调中使用箭头函数。在大多数情况下，这没什么问题，但如果该回调函数作为 prop 传入子组件时，（在每次渲染 父组件时都会创建不同的回调函数）子组件可能会进行额外的重新渲染。

我们通常建议在构造器中绑定或使用 class fields 语法来避免这类性能问题。

## 状态

当数据变化时，通过调用 `this.setState(data, callback)` 把数据合并到组件私有属性 `this.state` 中，驱动组件重新 render 自己。其中 callback 是可选的。

“自上而下”或是“单向”的数据流。任何的 state 总是所属于特定的组件，而且从该 state 派生的任何数据或 UI 只能影响树中“低于”它们的组件。

- 构造函数是唯一可以给 this.state 赋值的地方
- 直接修改 state 的值不会重新渲染组件，必须使用 `setState()`
- state的更新会被合并，这里的合并是浅合并

出于性能考虑，React 可能会把多个 setState() 调用合并成一个调用。因为 this.props 和 this.state 可能会异步更新，所以不要依赖他们的值来更新下一个状态。

### 状态提升

在 React 中，将多个组件中需要共享的 state 向上移动到它们的最近共同父组件中，便可实现共享 state。这就是所谓的“状态提升”。

在 React 应用中，任何可变数据应当只有一个相对应的唯一“数据源”。通常，state 都是首先添加到需要渲染数据的组件中去。然后，如果其他组件也需要这个 state，那么你可以将它提升至这些组件的最近共同父组件中。你应当依靠自上而下的数据流，而不是尝试在不同组件间同步 state。

由于“存在”于组件中的任何 state，仅有组件自己能够修改它，因此 bug 的排查范围被大大缩减了。

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

## 用法

有些组件无法提前知晓它们子组件的具体内容。使用一个特殊的 children prop 来将他们的子组件传递到渲染结果中。

通过 `{props.children}` 在组件里预留位置，将任意组件作为子组件传递给它们。

少数情况下，你可能需要在一个组件中预留出几个“洞”。这种情况下，可以自行约定，自定义props的属性（类似与vue的具名插槽）

在 React 中没有“槽”这一概念的限制，你可以将任何东西作为 props 进行传递。

组件可以接受任意 props，包括基本数据类型，React 元素以及函数。

  ```js
  class Counter extends React.Component {
    constructor(props) {
      super(props);
      this.state = {count: props.initialCount};
    }
    // ...
  }
  // 等价写法
  var Counter = React.createClass({
    getInitialState: function() {
      return {count: this.props.initialCount};
    },
    // ...
  });
  ```

+ prop 绑定父组件的函数传递给子组件，子组件调用该函数，即可实现数据传递。
+ `componentDidMount` 函数在组件**第一次**被渲染时由 React 自动调用。
+ 无状态的函数仍然可以设置 `propTypes` 和 `defaultProps`。
+ 官方建议使用 ES6 语法。

One **limitation**: React 组件只能渲染一个 **single root node** 单独的一个根节点. 如果你想要返回过个节点，它们必须要 be wrapped 在一个唯一的根节点元素里。

### Dynamic Children

当子节点为动态插入（如搜索结果，或者流中加入新的组件）时，每个子节点的标识和状态在渲染过程必须保持，这时需要通过 _key_ 属性给每一个 child 分配一个标识符。

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

这个 _key_ 属性必须直接在数组中提供给组件，而不是组件的 HTML 子元素的容器上。如下，_text_ 可以，但是 _key_ 不行.

```js
// WRONG!
class ListItemWrapper extends React.Component {
  render() {
    return <li key={this.props.data.id}>{this.props.data.text}</li>;
  }
}
class MyComponent extends React.Component {
  render() {
    return (
      <ul>
        {this.props.results.map((result) => (
          <ListItemWrapper data={result} />   // <ListItemWrapper key={result.id} data={result} />
        ))}
      </ul>
    );
  }
}
```

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
