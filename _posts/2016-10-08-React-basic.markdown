---
title:  "React.js 入门"
category: JavaScript
---
## JSX

The XML syntax inside of JavaScript is called **JSX**.

React 中模板使用 JSX，当然并不是必须使用 JSX 才能使用 React（JSX is optional and **not required** to use React）。

    <HelloMessage name="John" />
    <div>Hello {this.props.name}</div>

使用 JSX 的好处是：比起 function calls 和 object literals使得大型的树结构易于阅读。

React JSX code 可以写在单独的文件里，通过

    <script type="text/babel" src="xx.js"></script>

方式引用。注意这里 _type_ 特性。

### 用法

[JSX 语法](https://facebook.github.io/react/docs/jsx-in-depth.html)

+ HTML 标签使用 lower case 书写标记
+ React component 使用首字母为 uppercase 的驼峰书写标记
+ 那些看起来像（上面也称之为）HTML tag 的标记 **not actual** DOM nodes 并非真正的 DOM 结点; they are instantiations of React  components. 它们是 React 组件的实例，You can think of these as markers or pieces of data that React knows how to handle. 你可以把它们想象成是 React 知道如何处理的一些标记或数据。
+ 组件名必须以变量形式声明，如下：

    var Nav;
    var app = <Nav color="blue" />;

+ Namespaced Components, 命名空间式的组件使得只需使用一个组件变量，其他子组件作为其属性来获取。

    var MyFormComponent = React.createClass({ ... });
    var Form = MyFormComponent;
    var App = (
      <Form>
        <Form.Row>
          <Form.Label />
          <Form.Input />
        </Form.Row>
      </Form>
    );

    MyFormComponent.Row = React.createClass({ ... });
    MyFormComponent.Label = React.createClass({ ... });
    MyFormComponent.Input = React.createClass({ ... });

+ 当使用 JS 表达式设置 attribute 的值时，使用大括号 `{}` 包裹，代替一般情况下使用的双引号。
+ 不设置一个 attribute 的值时，JSX 认为它就是 true。因此，为了明确指定某个 attribute 是 false，要么不写这个特性，要么使用大括号设定，如： `disabled={false}`
+ 注释标记跟 JS 的 comment 一样，有单行和多行注释。需要注意的是，当你为一个 tag 的子区域写注释时，需要使用大括号将这条注释括起来。

    var content = (
    <Nav>
      {/* child comment, put {} around */}
      <Person
        /* multi
           line
           comment */
        name={window.isLoggedIn ? window.name : ''} // end of line comment
      />
    </Nav>
  );

+ `React.createClass()` 用来创建新的 React component. 其中最重要的一个方法叫 `render()` —— 返回一个最终将渲染成 HTML 的 React 组件树。
+ `ReactDOM.render()` 该方法初始化 root 组件，把组件的 markup 注入到 raw DOM 元素（由第二个参数提供的）中。该方法需要放在脚本的最下面，只有 composite 组件被定义了才可以调用。

### 输出 HTML tag 而不是 string

Improper use of the innerHTML can open you up to a cross-site scripting (XSS) attack.

而 React 的设计哲学是让制作东西很容易是安全的。开发人员需要明确指出他们要进行 unsafe 的操作。因此想要输出 HTML tag 时，需要做到两点：

1. 在要改变 innerHTML 属性的元素上添加 `dangerouslySetInnerHTML` prop name，通常给它绑定一个自定义函数，把需要 render 的值传进去.
2. 自定义函数只需要返回一个只包含 `__html` 属性的对象。属性值为传进去的 DOM string. 确保 HTML provided must be well-formed (ie., pass XML validation).

## 数据操作

+ Data passed in from a parent component is available as a 'property' on the child component. 数据通过成为子组件属性的方式，从父组件传递到子组件
+ We access **named attributes** passed to the component as keys on `this.props`, 通过 props 对象的属性读取写在父组件上有命名的 attribute 传递给子组件的值，and any **nested elements** as `this.props.children` 任何内嵌在组件里的元素都通过该 props 对象的 _children_ 属性获取.
+ `.props` 对象是 immutable 不可变的额，"owned" by the parent。
+ 为实现 mutable 状态，使用 `this.state` which is private to the component and can be changed by calling `this.setState()`. 当状态改变时，组件自己重新 render 自己。
+ `getInitialState()` executes exactly once during the lifecycle of the component 该函数在组件的生命周期内只执行一次，用来设置组件的初始 state。
+ `componentDidMount` 函数在组件**第一次**被渲染时由 React 自动调用。
+ React 使用 camelCase 命名规则绑定事件处理函数。区别于 HTML 元素上的事件绑定是全小写 `onclick`, `onsubmit`
