---
title:  "React.js 入门（一）"
category: JavaScript
---
官网自述 React 是为了解决一个问题而生：创建数据随时更新的大型应用。

React 本质就是写一些可重用的组件，React 组件是一些操作 `props` 和 `state` 的函数。

    UI = render(data)

此外按官网说法，React 直接从 JS 代码生成 HTML 和组件树，在网络环境差的情况下，从加载 JS 到生成页面这段时间的白屏问题不可避免。

<!--more-->

既然是以数据为重，首先介绍 React 中如何展示数据。

## JSX

React 中使用 JSX 创建树节点，当然 JSX is optional and **not required** to use React。

```js
<HelloMessage name="John" />
<div>Hello {this.props.name}</div>
```

JSX 作为 JS 语法的扩展让我们能使用 HTML 的语法创建 JavaScript objects。

其他优点如：比起 function calls 和 object literals，JSX 类似 XML 的开闭标签，使得大型的树结构易于阅读。

React JSX code 可以写在单独的文件里，通过

    <script type="text/babel" src="xx.js"></script>

方式引用。注意这里 _type_ 特性的值。

### 用法

+ HTML 标签使用 lower case 书写
+ React component 使用**首字母大写的驼峰**书写标记，We capitalize custom components to differentiate them from regular HTML elements.

    那些看起来像（上面也称之为）HTML tag 的标记**并非真正的** DOM 节点; 它们是 React 组件的实例，You can think of these as markers or pieces of data that React knows how to handle. 你可以把它们想象成是 React 知道如何处理的一些标记或数据。

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

+ 使用 JS 表达式作为 attribute 值的时候，需要使用大括号 `{ expression }` 包裹，代替一般情况下使用的双引号 `"value"`。
+ 缺省特性值时，JSX 认为它就是 `true`。因此，为了明确指定某个 attribute 是 `false`，要么不写这个特性，要么使用大括号赋值，如： `disabled={false}`
+ 注释标记跟 JS 的 comment 一样，有单行和多行注释。需要注意的是，当你为一个 tag 的子区域写注释时，需要使用大括号将这条注释括起来。

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
+ React **不会渲染原生 HTML 元素中不存在的特性**，除非以 `data-` 作为其前缀。而以 `aria-` 为前缀的 Web 可用性特性则可以被正确地渲染。

更多用法参考这里：[JSX 语法](https://facebook.github.io/react/docs/jsx-in-depth.html)

### JSX Spread Attributes 属性的传递

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

You must use this.setState() to modify an array，操作state中的数组

[用react开发一个井字游戏教程](https://zh-hans.reactjs.org/tutorial/tutorial.html)
每个组件都是封装好的，并且可以单独运行。

使用react可以将组件（一些简短、独立的代码片段）合成（构建）复杂的UI界面。

使用JSX通过render函数返回一种对渲染内容的轻量级描述（react元素）。

每一个 React 元素都是一个 JavaScript 对象，你可以在你的程序中把保存在变量中或者作为参数传递。

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

React 元素被视为 JavaScript 一等公民中的对象（first-class JavaScript objects），因此我们可以把 React 元素在应用程序中当作参数来传递。在 React 中，我们还可以使用 React 元素的数组来渲染多个元素

每次只要你构建动态列表的时候，都要指定一个合适的 key.

如果你没有指定任何 key，React 会发出警告，并且会把数组的索引当作默认的 key。但是如果想要对列表进行重新排序、新增、删除操作时，把数组索引作为 key 是有问题的。

组件的 key 值并不需要在全局都保证唯一，只需要在当前的同一级元素（兄弟节点）之间保证唯一即可。

key 应该在数组的上下文中被指定。

### 代码规范

属性命名规范：
- 建议从组件自身的角度命名 props，而不是依赖于调用组件的上下文命名。

React 认为渲染逻辑本质上与其他 UI 逻辑内在耦合，比如，在 UI 中需要绑定处理事件、在某些时刻状态发生变化时需要通知到 UI，以及需要在 UI 中展示准备好的数据。

React 并没有采用将标记与逻辑进行分离到不同文件这种人为地分离方式。

在 JavaScript 代码中将 JSX 和 UI 放在一起时，会在视觉上有辅助作用。它还可以使 React 显示更多有用的错误和警告消息。

JSX 语法上更接近 JavaScript 而不是 HTML，所以 React DOM 使用 camelCase（小驼峰命名）来定义属性的名称

在 JSX 语法中，你可以在**大括号**内放置任何有效的 JavaScript 表达式
为了便于阅读，我们会将 JSX 拆分为多行。同时，我们建议将内容包裹在**括号**中

引号，字符串字面量。
大括号，js表达式。

React 元素是创建开销极小的普通对象，是构成 React 应用的最小砖块。

React DOM 会将元素和它的子元素与它们之前的状态进行比较，并只会进行必要的更新来使 DOM 达到预期的状态。

当 React 元素为用户自定义组件时，它会将 JSX 所接收的属性（attributes）转换为单个对象传递给组件，这个对象被称之为 “props”。

React 会将以小写字母开头的组件视为原生 DOM 标签。

### tips

尽管 this.props 和 this.state 是 React 本身设置的，且都拥有特殊的含义，但是其实你可以向 class 中随意添加不参与数据流（比如计时器 ID）的额外字段。

阻止组件渲染，让 render 方法直接返回 null

在实践中，因为你经常是在向用户展示 JSON 数据模型，所以如果你的模型设计得恰当，UI（或者说组件结构）便会与数据模型一一对应，这是因为 UI 和数据模型都会倾向于遵守相同的信息结构。

第一步：将设计好的 UI 划分为组件层级
第二步：用 React 创建一个静态版本（先用已有的数据模型渲染一个不包含交互功能的 UI）
当你的应用比较简单时，使用自上而下的方式更方便；对于较为大型的项目来说，自下而上地构建，并同时为低层组件编写测试是更加简单的方式。
第三步：确定 UI state 的最小（且完整）表示。其中的关键正是 DRY: Don’t Repeat Yourself

比起写，代码更多地是给人看的。当你开始构建更大的组件库时，你会意识到这种代码模块化和清晰度的重要性。并且随着代码重用程度的加深，你的代码行数也会显著地减少。

props：
1.devTool中对应的component默认全部打开
2.因为是js报错可显示对应的Line *
3.没有v-model的trim等修饰符


对于受控组件来说，每个 state 突变都有一个相关的处理函数。这使得修改或验证用户输入变得简单。
`<input type="text">`, `<textarea>` 和 `<select>` 之类的标签都非常相似—它们都接受一个 value 属性，你可以使用它来实现受控组件

`<input type=“file”>` 的 value 只读，所以它是 React 中的一个非受控组件。

要编写一个非受控组件，而不是为每个状态更新都编写数据处理函数，你可以 使用 ref 来从 DOM 节点中获取表单数据。