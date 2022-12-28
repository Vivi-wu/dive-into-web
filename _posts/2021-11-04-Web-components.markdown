---
title:  "Web Components"
category: JavaScript
---
Web Components用于创建可复用的自定义元素——将它们的功能封装在其他代码之外，便于在web app里使用。

为了解决编写复杂的 HTML（以及相关的样式和脚本）来呈现自定义 UI 控件，Web Components提供了3种技术：Custom elements、Shadow DOM、HTML templates。

本文涉及ES6 classes（也称ES2015），当前 global 支持情况达 96.54%

<!--more-->

### Custom elements

```js
class WordCount extends HTMLParagraphElement {
  constructor() {
    // Always call super first in constructor
    super();
    // Element functionality written in here
    ...
  }
}
customElements.define('word-count', WordCount, { extends: 'p' });
```

web文档使用 `CustomElementRegistry` object 为页面注册自定义元素。其 `define()` 方法入参依次为元素的名称（必须为 kebab-case，不能是single word）、class object（使用标准 ES2015 class语法，定义元素的行为）、可选项（包含属性 extends，表示元素继承自哪个 built-in element）。

- class里可以定义特殊的lifecycle callback，在元素的生命周期特定时刻运行
- 有两种类型的自定义元素：Autonomous 和 Customized built-in。前者不继承自任何标准的HTML元素，用法 `<popup-info>`。后者在基础元素上通过 _is_ 属性指定元素名称 `<p is="word-count">`

既可以通过 `<style>` 也可以通过 `<link>` 引入样式。许多现代浏览器为前者实现了优化，因此外部和内部样式的性能应该是相似的。

### Shadow DOM

可以使用 non-shadow 节点完全一样的DOM API：添加子元素、设置attribute、给单独节点设置样式，etc。不同点是shadow DOM里的代码不会影响外部的元素，实现代码封装。

### <template> 和 <slots>

用于创建灵活的模版。

```html
<template id="my-paragraph">
  <p>My paragraph</p>
</template>
```

`<template>` 元素和其内容不会渲染进DOM，但可以被JS referenced到，插入 DOM。 `<slot>` 用法跟Vue.js一样。具名slot将渲染slot属性值同名的节点内容。unnamed slot将把自定义元素top-level中所有没有slot属性的子节点填充进来。

技术上可以单独使用 slot 元素，不需要 template 元素。但是，在 template 元素中添加 slot 通常更实用，因为不太可能需要基于已经渲染的元素定义pattern。

动态内容渲染也可以用 template 和 slot 吗？
