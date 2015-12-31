---
title:  "HTML Lists"
categories: HTML
---
## Unordered HTML List 无序列表

Starts with the `<ul>` tag. Each list item starts with the `<li>` tag. 无序列表项目由小黑实心圆标记。

    <ul>
      <li>Coffee</li>
      <li>Milk</li>
    </ul>

在 `<ul>` 中定义 _list-style-type_ ，可以取值 : disc（实心小圆，**default**）, circle （空心小圆）, square （实心正方形）, none.

**注意**：HTML5中 `<ul>` 标签不支持 _type_ 属性值.

## Ordered HTML List 有序列表

Starts with the `<ol>` tag. Each list item starts with the `<li>` tag and are marked with numbers. 数字列表每个元素由数字标记

<!--more-->

通过设定 `<ol>` 标签的 _type_ 特性值，来设定列表所使用的标号样式。_type_ 特性可以取的值：

<table>
  <tr>
    <td>1</td><td><strong>default</strong>, 从1开始的阿拉伯数字</td>
  </tr>
  <tr>
    <td>A</td><td>大写英文字母</td>
  </tr>
  <tr>
    <td>a</td><td>小写英文字母</td>
  </tr>
  <tr>
    <td>I</td><td>大写罗马数字</td>
  </tr>
  <tr>
    <td>i</td><td>小写罗马数字</td>
  </tr>
</table>

### _start_ 特性

取值为 number，指定有序列表标号的起始取值。

    <ol start="50">
      <li>Coffee</li>
      <li>Tea</li>
      <li>Milk</li>
    </ol>

## HTML Description Lists

A description list is a list of terms, with a description of each term. 描述列表由一系列**项目条款**和它们的**描述**组成。
The `<dl>` tag defines a **description list**. `<dt>` (定义描述元素 **description terms**/names) and `<dd>` (每个元素的描述 **description data**)

    <dl>
      <dt>Coffee</dt>
      <dd>- black hot drink</dd>
      <dt>Milk</dt>
      <dd>- white cold drink</dd>
    </dl>

### Horizontal Lists

一种常用的使用方式是水平列表，只需要将列表项目 `<li>` 设置为 _display: inline;_ 即可。

**Tip**: List items `<li>` can contain new list and other HTML elements. 列表元素可包含新列表或其他HTML元素。
