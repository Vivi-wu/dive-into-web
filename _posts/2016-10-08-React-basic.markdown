---
title:  "React.js 入门（一）"
category: JavaScript
---
本系列日志主要记录自学过程、知识点。

官网指出 React 是为了解决一个问题而生：创建数据随时更新的大型应用。

当底层数据改变 React 将自动管理所有 UI 更新，且只更新改变的部分。React 本质就是写一些可重用的组件，组件呢又是一些函数，操作 `props` 和 `state`，然后渲染 HTML。

有事没事先写一个组件，我觉得这个也会是弊端。

此外按官网说法，React 直接从 JS 代码生成 HTML 和组件树，那么从加载 JS 到生成页面这段时间的白屏问题可能会有点恼人。

既然是以数据为重，首先介绍 React 中怎么展示数据。

## JSX

React 中使用 JSX 创建树节点，当然 JSX is optional and **not required** to use React。

    <HelloMessage name="John" />
    <div>Hello {this.props.name}</div>

JSX 作为 JS 语法的扩展让我们能使用 HTML 的语法创建 JavaScript objects。

其他的好处如：比起 function calls 和 object literals，JSX 类似 XML 的开闭标签，使得大型的树结构易于阅读。

<!--more-->

React JSX code 可以写在单独的文件里，通过

    <script type="text/babel" src="xx.js"></script>

方式引用。注意这里 _type_ 特性的值。

### 用法

[JSX 语法](https://facebook.github.io/react/docs/jsx-in-depth.html)

+ HTML 标签使用 lower case 书写
+ React component 使用**首字母大写的驼峰**书写标记

    那些看起来像（上面也称之为）HTML tag 的标记**并非真正的** DOM 节点; 它们是 React 组件的实例，You can think of these as markers or pieces of data that React knows how to handle. 你可以把它们想象成是 React 知道如何处理的一些标记或数据。

+ 组件名必须以变量形式声明，如下：

        var Nav;
        var app = <Nav color="blue" />;

+ Namespaced Components 命名空间式的组件使得只需**声明一个**组件变量，让其他子组件作为其属性来获取。

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

+ 使用 JS 表达式作为 attribute 值的时候，使用大括号 `{ }` 包裹，代替一般情况下使用的双引号 `" "`。
+ 缺省特性值时，JSX 认为它就是 `true`。因此，为了明确指定某个 attribute 是 `false`，要么不写这个特性，要么使用大括号赋值，如： `disabled={false}`
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

+ React 会在生成的 raw HTML 中自动插入类似 `<!-- react-text: 4 --><!-- /react-text -->` 的注释，据说是它用来识别如何在 DOM 添加和替换节点。
+ React **不会渲染原生 HTML 元素中不存在的特性**，除非以 `data-` 作为其前缀。而以 `aria-` 为前缀的 Web 可用性特性则可以被正确地渲染。

### JSX Spread Attributes 属性的传递

当组件的所有属性 props 可预知时，可以把它们一一写在组件上传递给子组件。但有时不能预知全部属性，而 props 作为 immutable 的对象，不要给对象写属性如：`component.props.foo = x;`

此时可以使用 JSX 的新特性，被称作 **spread attributes**。不直接对 `component.props` 操作也能解决前面的问题。

    var props = {};
    props.foo = x;
    props.bar = y;
    var component = <Component {...props} />;

`{...this.props}` 属性的传递把组件上的 HTML attributes 都复制到底层的 HTML 元素上，save typing！

此外还可以用来合并老的 `props` 和额外的属性值，如下:

    <Component {...this.props} more="values" />

注意：attribute 的**书写顺序很重要**，写在右边的覆盖前面的同名特性。

还可以指定哪个属性不往下面传递：

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

如果既想要消费一个属性，又想把它传递下去，就在子组件上再明确地写下这个属性即可：

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

        <div>{'First \u00b7 Second'}</div>
        <div>{'First ' + String.fromCharCode(183) + ' Second'}</div>
