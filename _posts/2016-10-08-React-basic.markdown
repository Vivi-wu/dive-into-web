---
title:  "React.js 入门（一）"
category: JavaScript
---
React 是一个声明式的灵活高效的用于构建 UI 的 js 库。由 Facebook 创建的开源项目。

借助 React 通过小的、相互独立的代码片段（component，即组件）可以构建复杂的用户界面。

对已有网页添加 React 最简单的方式是，以 `<script>` 标签引入 React（顶层API）、React DOM（DOM相关方法）、Babel（在旧浏览器里使用ES6+）外部js文件。

但随着应用不断增长变复杂，为了处理一些如：大量的文件、组件，使用 npm 上的第三方库，提前检测语法/代码错误，热更新CSS/JS，优化打包文件等，我们引入官方建议的 [toolchain](https://reactjs.org/docs/create-a-new-react-app.html#recommended-toolchains)。

<!--more-->

## JSX

即 JavaScript XML，它是 JavaScript 语法的扩展，在编译后转换成 `React.createElement(标签名称，属性对象，子组件)`，即常规的函数调用 。

一个事实：渲染逻辑天然地与UI逻辑耦合。（比如：在 UI 中绑定事件、在某些时刻状态发生变化时需要通知到 UI，以及需要在 UI 中展示准备好的数据。）

官方建议在 React 中使用 JSX 创建树节点（描述 UI），在写 JS 代码时提供视觉上的辅助，易于阅读，同时允许 React 显示更多有用的报错和 warning 信息。

默认情况下，React DOM 在渲染前 escapes 任何嵌入 JSX 的值，因此在 JSX 中插入用户输入是安全的（不必担心XSS）。

### 用法

+ 用 camelCase（小驼峰命名）来写属性和方法名
+ 可以在 JSX 内的大括号 `{ expression }` 里书写任何有效的 JavaScript 表达式
+ 使用双引号 `"value"` 指定 string literal 字符串字面量设置属性值
+ 添加 css 样式时使用 className 代替 class
+ 每个组件必须自闭合，如 `<img />`
+ 为了便于阅读，可将 JSX 拆分为多行书写。同时将内容包裹在**括号** `()` 中，避免 `return` 末尾自动插入分号。
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

是 React 应用最小构建块。

```js
const element = <h1>Hello, world</h1>;
```
React 元素也是 JSX 表达式，可等价于 JS Object。因此可以：

1. 赋值给变量
2. 作为函数入参
3. 作为函数返回
4. 在 `if` 声明和 `for` 循环里使用

React DOM 负责更新 DOM 以匹配的 React element。

以 React 构建的应用只有一个 root DOM 节点。对已有的项目接入 React，则可有多个 isolated 的 root DOM 节点。

React 元素是 immutable 不可变的，一旦创建，不能改变它的子元素或属性。

目前唯一更新UI的方式是创建一个新的元素，并传给 `ReactDOM.render()`。实践中，大部分 React 应用只调用一次。

## React Components

从概念上讲，React 组件类似 js 函数接受任意输入 `props` (properties 的缩写)，组件通过 `render()` 返回 React element（一种对待展示的视图层次结构的轻量级描述）。

以 function、class 形式定义组件：

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
+ 自定义 component 采用**首字母大写的驼峰**标记，与常规 HTML 元素区分开。
+ 之前 React class 组件需要包含 `constructor()`，现在不必了
+ 函数组件没有自己的 state
+ 在 .js 文件里，函数组件可以与 class 组件混用

### 组件拆分原则

如果 UI 中某个部分被使用多次（如：按钮、panel、avatar），或者组件自身足够复杂，最好将其提取到独立组件里。
