---
title:  "CSS Links, Lists and Tables"
category: CSS
---
## CSS Links

`<a>` 可以根据它的状态，被赋予不同的样式。

链接的四种状态是：

+ a**:link** - a normal, unvisited link 还没有访问
+ a**:visited** - a link the user has visited 已访问
+ a**:hover** - a link when the user mouses over it 鼠标滑过
+ a**:active** - a link the moment it is clicked 鼠标点击时（也是它被选中的时刻）

<!--more-->

### 根据链接状态设定 CSS 须遵守的顺序规则

1. `a:hover` MUST come **after** `a:link` and `a:visited`
2. `a:active` MUST come **after** `a:hover`

## CSS Lists

CSS list 属性可以用来给有序 ordered 列表 和无序 unordered 列表设置不同的列表元素标记 markers，使用图片作为列表元素标记，给列表和列表元素添加背景色。

### List item marker

使用 _list-style-type_ 属性来设置列表元素标记。默认值是 `disc`（实心小黑圆）。

在 HTML List 章节提到有序列表可以在元素 `<ol>` 上通过 _type_ 特性值来设置列表元素的标记，而 CSS 设置无序列表 `<ul>` 元素标记的值只有**四**种。

所以这里只讲用 CSS 设置**有序列表**元素样式可取的值：

+ armenian（亚美尼亚计数文字）
+ cjk-ideographic（中文：一，二，三）
+ decimal（十进制数字），decimal-leading-zero（以 0 开始的十进制：01，02，03）
+ georgian（格鲁吉亚语的）
+ hebrew（希伯来语的）
+ hiragana（日语平假名），hiragana-iroha（？）
+ katakana（日语片假名），katakana-iroha（？）
+ lower-alpha（小写英文字母）
+ lower-roman（小写罗马数字）
+ lower-greek（小写希腊语）
+ lower-latin（同 alpha）
+ upper-alpha
+ upper-latin（同 alpha）
+ upper-roman

注意：<span class="t-blue">_list-style-type_ 只用于列表父元素 `<ul>`, `<ol>` ，而**不是**列表子元素 `<li>`</span>

### 使用图片作为列表元素标记

要使用 _list-style-image_ 属性，默认值为 `none`。只要将属性值设为图片 url 即可。

注意：即使使用图片作为标记，也要设定 _list-style-type_ 属性，这样在图片不可用的情况下也有 fallback。

### 指定 list item marker 的位置

使用 _list-sytle-position_ 属性来指定**列表元素标记的位置是出现在内容流的里面，还是外面**。具体见下面的例子。

`outside`：（默认值）

<ul style="list-style-position:outside;width:205.5px">
<li style="border:1px solid gray">Coffee</li>
</ul>

`inside`：

<ul style="list-style-position:inside;width:205.5px">
<li style="border:1px solid gray">Coffee</li>
</ul>

### All in one

_list-style_ 属性是以上三个属性的简写形式。需要遵循的顺序是：

+ list-style-type
+ list-style-position
+ list-style-image

## CSS Tables

使用 CSS 可以极大程度上改善 HTML 表格的样式。

### Table Borders

给表格设置边框的时候，注意：both `<table>` and the `<th>` and `<td>` elements have **separate borders**. 表格和单元格都有各自独立的边框。

在 `<table>` 元素上，使用 _border-collapse_ 属性设置表格的边框<span class="t-red">是否要合并成一个单边边框</span>。

**默认值**是 `separate`，这样 _border-spacing_ 和 _empty-cells_ 属性就**不能被忽略**。

当取值为 `collapse` 时，表格边框就会合并成 a single border。

**独立边框模式下**，以下两个属性都是只在 `<table>` 元素上设置。

1. _border-spacing_ 设定边框和单元格之间的距离，默认值为 0. 取值方式：

    + length length，以 px，cm 等为单位。**不允许**负值。前者指定水平间距 **horizontal spacing**，后者指定竖直间距 **vertical spacing**。当只有一个值时，表示相同的水平和竖直的间距。
    + initial
    + inherit

2. _empty-cells_ 设定是否隐藏表格中空的单元格的边框、背景。**默认值**是 `show`。希望隐藏的话，属性值设为 `hide`

### Horizontal & Vertical alignment

使用 _text-align_ 和 _vertical-align_ 属性来对齐表格 `<th>`，`<td>` 里的元素。

默认地，在水平方向上，`<th>` 表头单元格里的元素**中心**对齐，`<td>` 普通单元格里的元素为**左**对齐。

而竖直方向上，单元格的元素是居中 middle 对齐。

### Table padding

在 `<th>`，`<td>` 单元格上设置 _padding_ 属性，来控制边框与单元格内容的间距。

### Table caption

使用 _caption-side_ 属性指定表格标题的位置。该属性在元素 `<caption>` （需要包裹在 `<table>` 元素里）上设置。

默认值是 `top`，还可以取值 `bottom`。

### table-layout

_table-layout_ 指定表格用来布局的算法。**默认值**是 `auto`，表格列的宽度由最宽的、内容不可 break 的单元格决定。

这种算法可能会比较慢，因为它需要在决定最终的布局之前读取表格中的全部内容。

另一种取值是 `fixed`。水平布局只取决于表格和列的 width，而不是单元格的内容。使得浏览器可以在接收到表格第一行时就开始显示表格，比起 automatic table layout 可以快速布局表格。
