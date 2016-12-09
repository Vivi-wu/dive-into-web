---
title:  "React.js 入门（二）"
category: JavaScript
---
本章主要写 React 的数据操作

## 事件处理

React 保证所有事件在各种浏览器中表现一致，与 W3C spec 的冒泡和捕捉一致。

使用 **camelCase** 的特性名绑定事件处理函数（区别于 HTML 元素的全小写 `onclick`）.

每个事件处理函数自动绑定它所属的组件实例，除了使用 ES6 class 语法时。

    class SayHello extends React.Component {
      constructor(props) {
        super(props);
        // This line is important! 需要手动绑定 this 到实例
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

<!--more-->

## 状态

当数据变化时，通过调用 `this.setState(data, callback)` 把数据合并到组件私有属性 `this.state` 中。组件会重新 render 自己。其中 callback 是可选的。

### 什么样的组件应该拥有 State

有时你需要响应**用户输入**、**服务器请求**或者时间的流逝，这时就要用到 State。

但是尽可能使你的大部分组件 stateless 无状态，减少冗余。一个常见的模式就是创建一些没有状态的组件，仅用来渲染数据，称为 Stateless Function。然后把它们内嵌在一个 stateful 的父组件里。父组件把 state 通过 props 传递给子组件。

    // Stateless Function
    const Greeting = (props) => (
      <h1>Hello, {props.name}</h1>
    );
    ReactDOM.render(
      <Greeting name="Sebastian" />,
      document.getElementById('example')
    );

### 什么不应该放在 State 中

+ Computed data，计算的数据。把计算都放在 `render()` 中，比如状态中存放了一个数组，要输出数组长度可放在渲染函数中，而不是把长度值保存在状态里。
+ React 组件。基于 props 和 state 在渲染函数里创建。
+ 从 Props 中复制的数据。凡是有例外：当需要指定 previous 的值时，可以把 props 中取得的值存在私有状态中。因为父组件重新渲染时，props 值也会变。

## 用法

+ `React.createClass()` 用来创建新的 React component. 其中最重要的一个方法叫 `render()` —— 返回一个最终将渲染成 HTML 的 React 组件树。
+ `ReactDOM.render()` 该方法初始化 root 组件，把组件的 markup 注入到 raw DOM 元素（由第二个参数提供的）中。该方法需要放在脚本的最下面，只有 composite 组件被定义了才可以调用。
+ Data passed in from a parent component is available as a 'property' on the child component. 数据通过成为子组件属性的方式，从父组件传递到子组件
+ We access **named attributes** passed to the component as keys on `this.props`, 通过 props 对象的属性读取写在父组件上有命名的 attribute 传递给子组件的值。
+ 任何内嵌在父组件里的内容通过 `this.props.children` 获取.
+ `.props` 对象是 immutable 不可变的，"owned" by the parent。
+ `getInitialState()` 该函数在组件的生命周期内只执行一次，用来设置组件的初始 state。ES6 classes 中，初始状态写在 `constructor()` 中

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

+ `componentDidMount` 函数在组件**第一次**被渲染时由 React 自动调用。
+ 无状态的函数仍然可以设置 `propTypes` 和 `defaultProps`。
+ 官方建议使用 ES6 语法。


One **limitation**: React 组件只能渲染一个 **single root node** 单独的一个根节点. 如果你想要返回过个节点，它们必须要 be wrapped 在一个唯一的根节点元素里。

### Dynamic Children

当子节点为动态插入（如搜索结果，或者流中加入新的组件）时，每个子节点的标识和状态在渲染过程必须保持，这时需要通过 _key_ 属性给每一个 child 分配一个标识符。

    render() {
      return (
        <ol>
          {this.props.results.map((result, index) => (
            <li key={index}>{result.text}</li>
          ))}
        </ol>
      );
    }

这个 _key_ 属性必须直接在数组中提供给组件，而不是组件的 HTML 子元素的容器上。如下，_text_ 可以，但是 _key_ 不行.

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

### Prop Validation

出于性能考虑，仅在开发阶段通过 `propTypes` 属性检查组件接受到的数据类型是否正确。若是 invalid value，在浏览器 JS console 中报错。

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

更多用法参考[这里](https://facebook.github.io/react/docs/reusable-components.html).

### Default Prop values

通过 `defaultProps` 给父组件的 _props_ 设置默认值。使我们可以安全地使用 props，不必担心没有值，也避免重复书写。

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