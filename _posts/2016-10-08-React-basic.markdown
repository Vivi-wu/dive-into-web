---
title:  "React.js 入门（一）"
category: JavaScript
---
对已有网站添加 React 以实现动态组件最简单的方式是，以 `<script>` 标签引入，加上可选的 JSX。

随着你的应用不断增长变复杂，为了处理一些如：大量的文件、组件，使用npm上第三方库，提前检测语法/代码错误，热更新CSS/JS，优化打包文件等，可以引入官方建议的 [toolchain](https://reactjs.org/docs/create-a-new-react-app.html#recommended-toolchains)。

React 本质就是写一些可重用的组件，React 组件是一些操作 `props` 和 `state` 的函数。

    UI = render(data)

React 是 one-way data flow（单选数据流）。

<!--more-->

任何前端框架最终都要输出页面，首先介绍 React 中用于渲染的重要概念。

## JSX

它是 JavaScript 语法的扩展。

一个事实：渲染逻辑天然地与UI逻辑耦合。（比如：在 UI 中绑定事件、在某些时刻状态发生变化时需要通知到 UI，以及需要在 UI 中展示准备好的数据。）

官方建议在 React 中使用 JSX 创建树节点（描述 UI），在写 JS 代码时提供视觉上的辅助，易于阅读，同时允许 React 显示更多有用的报错和warning信息。

当然 JSX is optional。

任何东西在渲染前都会转为 string，阻止 XSS，所以在 JSX 中插入用户输入是安全的。

```js
<HelloMessage name="John" />
<div>Hello {this.props.name}</div>
```

经过 Babel 编译后，JSX 表达式变成了常规的 JS 函数调用（`React.createElement()`），创建了一个 JS 对象，用于描述渲染内容的 React elements。

### 用法

+ 为了便于阅读，将 JSX 拆分为多行书写。同时建议将内容包裹在**括号** `()` 中，避免代码末尾自动插入分号。
+ React DOM 使用 camelCase（小驼峰命名）来定义属性的名称，class 变为 className
+ 组件名必须以变量形式声明，如下：

    var Nav;
    var app = <Nav color="blue" />;

+ Namespaced Components 命名空间式的组件使得只需**声明一个**组件变量，让其他子组件作为其属性来获取。

  ```js
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
  ```

+ 大括号 `{ expression }` 指定任何有效的 JavaScript 表达式作为属性值
+ 双引号 `"value"`，指定 string literal 字符串字面量作为属性值
+ 缺省特性值时，JSX 认为它就是 `true`。因此，为了明确指定某个 attribute 是 `false`，要么不写这个特性，要么使用大括号赋值，如： `disabled={false}`
+ 注释标记跟 JS 的 comment 一样，有单行和多行注释。当你为一个 tag 的子区域写注释时，使用大括号将这条注释括起来。

  ```js
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
  ```

+ React 会在生成的 raw HTML 中自动插入类似 `<!-- react-text: 4 --><!-- /react-text -->` 的注释，据说是它用来识别如何在 DOM 添加和替换节点。
+ React **不会渲染原生 HTML 元素中不存在的特性**，除非以 `data-` 作为其前缀。
+ 支持以 `aria-` 为前缀的 Web 可用性特性，保持 kebab-case 的书写

更多用法参考这里：[JSX 语法](https://facebook.github.io/react/docs/jsx-in-depth.html)

### 条件渲染

通过 `expression && element` 在 JSX 中实现 inline 的 if 渲染组件。因为 false && expression 结果是 false，React 会忽略。

通过 `condition ? elementA : elementA` 在 JSX 中实现 inline 的 if-else 渲染组件。

阻止组件渲染，從組件的 render 方法 return null。这不影响组件的生命周期方法执行。

### JSX Spread Attributes 属性的传递

当 React 元素为用户自定义组件时，它会将 JSX 所接收的属性（attributes）转换为单个对象传递给组件，这个对象被称之为 “props”。

当组件的所有属性 props 可预知时，可以把它们一一写在组件上传递给子组件。但有时不能预知全部属性，而 props 作为 immutable 的对象，不要给对象写属性如：`component.props.foo = x;`

此时可以使用 JSX 的新特性，被称作 **spread attributes**。不直接对 `component.props` 操作也能解决前面的问题。

```js
var props = {};
props.foo = x;
props.bar = y;
var component = <Component {...props} />;
```

`{...this.props}` 属性的传递把组件上的 HTML attributes 都复制到底层的 HTML 元素上，save typing！

此外还可以用来合并老的 `props` 和额外的属性值，如下:

```js
<Component {...this.props} more="values" />
```

注意：attribute 的**书写顺序很重要**，写在右边的覆盖前面的同名特性。

还可以指定哪个属性不往下面传递：

```js
function FancyCheckbox(props) {
  var { checked, ...other } = props;
  var fancyClass = checked ? 'FancyChecked' : 'FancyUnchecked';
  // `other` contains { onClick: console.log } but not the checked property
  return (
    <div {...other} className={fancyClass} />
  );
}
ReactDOM.render(
  <FancyCheckbox checked={true} onClick={console.log.bind(console)}>
    Hello world!
  </FancyCheckbox>,
  document.getElementById('example')
);
```

如果既想要消费一个属性，又想把它传递下去，就在子组件上再明确地写下这个属性即可：

```js
function FancyCheckbox(props) {
  var { checked, title, ...other } = props;
  var fancyClass = checked ? 'FancyChecked' : 'FancyUnchecked';
  var fancyTitle = checked ? 'X ' + title : 'O ' + title;
  return (
    <label>
      <input {...other} checked={checked} className={fancyClass}
        type="checkbox"
      />
      {fancyTitle}
    </label>
  );
}
```

## React Elements

```js
const element = <h1>Hello, world</h1>;
```

React 元素可以：

1. 在 `if` 声明 `for` 循环里使用
2. 赋值给变量
3. 作为函数入参
4. 作为函数返回

以 React 构建的应用只有一个 root DOM 节点。对已有的项目接入 React，则可有多个 isolated 的 root DOM 节点。

React 原生是 immutable，一旦创建，不能改变它的子元素或属性。唯一的方式是创建一个新的元素，并传给 `ReactDOM.render()`

React DOM 会将元素和它的子元素与它们之前的状态进行比较，只应用与之前相比DOM上必要的变化。

## Components

从概念上讲，组件类似 JS 函数，接受任意输入（props），返回 React elements（将出现在屏幕上的东西）

以函数形式、class 定义组件：

```js
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}

const element = <Welcome name="Sara" />;
```

+ React component **首字母大写的驼峰**标记，React 会将以小写字母开头的组件视为原生 DOM 标签。

    那些看起来像（上面也称之为）HTML tag 的标记**并非真正的** DOM 节点; 它们是 React 组件的实例，你可以把它们想象成是 React 知道如何处理的一些标记或数据。
+ 建议从组件自身的角度命名 props，而不是依赖于调用组件的上下文命名。
+ 所有 React 组件必须像 pure 函数，不直接改变它的输入（props）

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

The other type of component in React is the simple component, which is a function. This component doesn't use the class keyword

simple and class components can be mixed.

return is contained to one line, it does not need parentheses.

```js
// Simple Component
const SimpleComponent = () => {
  return <div>Example</div>
}
// Class Component
class ClassComponent extends Component {
  render() {
    return <div>Example</div>
  }
}
```
[用react开发一个井字游戏教程](https://zh-hans.reactjs.org/tutorial/tutorial.html)

每个组件都是封装好的，并且可以单独运行。

在 React 应用中，数据通过 props 的传递，从父组件流向子组件。

在 JavaScript class 中，每次定义其子类的构造函数时，都需要调用 super 方法。因此，在所有含有构造函数的的 React 组件中，构造函数必须以 super(props) 开头。

如果你想写的组件只包含一个 render 方法，并且不包含 state，那么使用**函数组件**。

使用 CodePen 在线编辑器如何正确使用React DevTools？

1. 登录或注册。
2. 点击 “Fork” 按钮。
3. 在“Open this Pen in:”选择 “Debug mode”。
4. 上一步会打开一个新的标签页，此时打开开发者工具就会有一个 React 选项卡，并且在“⚛️ Components”里可以看到干净的组件树。

当你遇到需要同时获取多个子组件数据，或者两个组件之间需要相互通讯的情况时，需要把子组件的 state 数据提升至其共同的父组件当中保存。
之后父组件可以通过 props 将状态数据传递到子组件当中。这样应用当中所有组件的状态数据就能够更方便地同步共享了。

### tips

尽管 this.props 由 React 本身设置的，this.state 有特殊的含义，我们可以向 class 中随意添加**不参与数据流**的额外字段（如，this.timerID）。

props：
1.devTool中对应的component默认全部打开
2.因为是js报错可显示对应的Line *
3.没有v-model的trim等修饰符

子组件 state 没更新是不会触发 render 渲染的。

在 `componentDidMount()` 钩子函数里执行 ajax call，这样可以使用 setState 更新组件状态

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