---
title:  "HTML Block and Inline Element"
category: HTML
---
Every HTML element has a default _display_ value depending on what type of element it is. 每个HTML元素都有一个默认展示的值，该值取决于它是什么类型的元素。对于大多数元素的默认 _display_ 值是 _block_ or _inline_

## Block-level Elements

Block level elements always start on a new line and takes up the full width available.
**块级元素**通常**以新的一行开始，左右伸展，占满一整行宽度**。

常见的块级元素有: `<div>`, `<h1>`-`<h6>`, `<p>`, `<form>`, `<ul>`, `<ol>`

<!--more-->

## Inline Elements

Inline elements don't start on a new line and only take up as much width as necessary.
**行内级元素**通常**不会以新的一行开始来显示，且只占据必要的宽度**。

常见的行内级元素有: `<span>`, `<a>`, `<img>`, `<strong>`

### `<div>` Element

该元素是块级元素，通常作为**其他HTML元素的容器**。该元素也是替代了原先使用 `<table>` 标签来实现页面布局。当然HTML5引入了许多语义化的标签，如 `<header>`, `<footer>`, `<section>`, `<nav>`, `<article>`，注意使用合适的标签来实现布局。

**Note**: The purpose of the `<table>` element is to display tabular data. 因此W3C不建议使用 `<table>` 来实现网页布局。

### `<span>` Element

该元素是一个行内级元素，通常作为**文本的容器**。

**Tip**: When a text is hooked 被挂钩 in a `<span>` element, you can style it with CSS, or manipulate it with JavaScript. 限制在 `<span>`元素中的文本，可以对它进行CSS个性化设置，或用JS对其进行操作。
