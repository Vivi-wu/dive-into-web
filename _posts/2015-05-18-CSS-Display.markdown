---
title:  "CSS Display"
category: CSS
---
_display_ 是 CSS 用于控制布局最重要的属性，该属性指定一个元素是否显示。

对于要显示的大多数 HTML 元素，其 _display_ 默认值取决于元素的类型，即 `block` 或者 `inline`。（这一点在 HTML Blocks章节已提到过）

注意：<span class="t-blue">通过 display 属性仅改变元素显示的方式，而不改变元素的类型</span>。因此，一个看起来是块级元素的 inline 元素，**不允许**包裹其他块级元素。

### 隐藏 HTML 元素

最常见的通过 JS 来隐藏和显示元素，不通过删除和重新创造它们的方法就是：

+ `display: none;` 隐藏以后**不占据空间**，看起来那个元素不在那里
+ `visibility: hidden;` 仍然 takes up space **占据着本来的空间**，尽管看不见，还在影响着页面布局。

<!--more-->

### _visibility_

该属性还可以取值 `visible`，此为**默认值**。

针对**表格**元素，还可以取值为 `collapse`，**删除**一行或一列，仍然 take up space。如果该属性值被用在了其他元素上，效果同 `hidden`。

### _display_

既然该属性对于 CSS 实现页面布局如此重要，这里就详细列举一下，除了 `block` 和 `inline` 还可以取的值：

<table>
  <thead>
    <tr>
      <th style="width:12rem;">取值</th><th>作用</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>inline-block</td><td>使元素成为一个行内级别，可封装块级元素的容器。即元素本身看起来是 inline 元素，元素里面的内容表现为 block 级样式。<span class="t-blue">使用该属性值可以轻松取代旧的利用 float:left; 方式实现的 a grid of boxes 填充满浏览器的效果</span></td>
    </tr>
    <tr>
      <td>flex</td><td>CSS3 新属性，将元素显示为块级 flex 元素</td>
    </tr>
    <tr>
      <td>inline-flex</td><td>CSS3 新属性，将元素显示为行内级 flex 元素</td>
    </tr>
    <tr>
      <td>inline-table</td><td>显示为行内级的表格</td>
    </tr>
    <tr>
      <td>list-item</td><td>使元素表现地像 &lt;li&gt; 元素，前面带默认小实心圆</td>
    </tr>
    <tr>
      <td>run-in</td><td>看环境决定是显示为 block 还是 inline 级别的样子</td>
    </tr>
    <tr>
      <td>table</td><td>使元素表现地像 &lt;table&gt; 元素</td>
    </tr>
    <tr>
      <td>table-caption</td><td>使元素表现地像 &lt;caption&gt; 元素</td>
    </tr>
    <tr>
      <td>table-column-group</td><td>使元素表现地像 &lt;colgroup&gt; 元素</td>
    </tr>
    <tr>
      <td>table-header-group</td><td>使元素表现地像 &lt;thead&gt; 元素</td>
    </tr>
    <tr>
      <td>table-footer-group</td><td>使元素表现地像 &lt;tfoot&gt; 元素</td>
    </tr>
    <tr>
      <td>table-row-group</td><td>使元素表现地像 <span class="t-red">&lt;tbody&gt;</span> 元素</td>
    </tr>
    <tr>
      <td>table-cell</td><td>使元素表现地像 &lt;td&gt; 元素</td>
    </tr>
    <tr>
      <td>table-column</td><td>使元素表现地像 &lt;col&gt; 元素</td>
    </tr>
    <tr>
      <td>table-row</td><td>使元素表现地像 &lt;tr&gt; 元素</td>
    </tr>
  </tbody>
</table>

### Overflow

_overflow_ 属性定义了如果内容超出了一个元素的盒模型将会发生什么。

取值：

+ `visible` **默认值**，会无视元素的边界限定，把内容全部显示出来。
+ `hidden` 超出部分被剪切掉，invisible
+ `scroll` 超出部分被剪切掉，但是会添加一个滚动条用于查看 the rest of the content
+ `auto` 如果有超出边界的内容，添加 scroll-bar

<span class="t-blue">`<body>` 元素的 _overflow_ 默认值是 `auto`</span>.

_overflow-x_ 属性定义了如果内容超出了一个元素的盒模型，内容的 left/right 边会怎么处理。取值同 _overflow_ .

_overflow-y_ 属性定义了如果内容超出了一个元素的盒模型，内容的 top/bottom 边会怎么处理。取值同 _overflow_ .
