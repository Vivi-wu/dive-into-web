---
title:  "HTML Tables"
category: HTML
---
Tables are defined with the `<table>` tag.

The `<tr>` element defines a **table row** 表格行, the `<th>` element defines a **table heading** 表头, and the `<td>` element are the data container of the table 单元格.

**Table data** `<td>` can contain all sorts of HTML elements like text, images, lists, other tables, etc. 单元格可包含各种HTML元素：文本、图片、列表、其他表等。

`<thead>` group 表格的 header content，`<tbody>` group 表格体内容，`<tfoot>` 包含表格脚的内容。

<!--more-->

### `<colgroup>` and `<col>`

`<colgroup>` 该标签用来指定表格中**一列或多列**的formatting。The `<colgroup>` tag **must** be a child of a `<table>` element, **after** any `<caption>` elements and **before** any `<thead>`, `<tbody>`, `<tfoot>` and `<tr>` elements. 该标签要结合 `<col>` 标签一起使用。其中 _span_ 特性指定了 a column group 需要扩展的列数。

    <table>
      <colgroup>
        <col span="2" style="background-color:red">
        <col style="background-color:yellow">
      </colgroup>
      <tr>
        <th>ISBN</th>
        <th>Title</th>
        <th>Price</th>
      </tr>
      <tr>
        <td>3476896</td>
        <td>My first HTML</td>
        <td>$53</td>
      </tr>
    </table>

效果如下：

<table>
  <colgroup>
    <col span="2" style="background-color:red">
    <col style="background-color:yellow">
  </colgroup>
  <tr>
    <th>ISBN</th>
    <th>Title</th>
    <th>Price</th>
  </tr>
  <tr>
    <td>3476896</td>
    <td>My first HTML</td>
    <td>$53</td>
  </tr>
</table>

**Tips**: The width of a table can be defined using CSS. 可以**通过CSS _width_ 设定表格宽度**

### Table with a Border Attribute

If you do not specify a border for the table, it will be displayed without borders. 如果不设置表格的border，则**默认显示无边框表格**，通过CSS设置表格的 border

    table, th, td
    {
      border:1px solid black;
    }

### Table with Collapsed Borders

合并边框，使用 _border-collapse_ 属性将边框会合并为单一的边框，相对于上面的例子。

    table, th, td
    {
      border: 1px solid black;
      border-collapse: collapse；
    }

### Table with Cell Padding

Cell padding specifies the space between the cell content and its borders. 单元格内边距定义了单元格内容和边框的空隙。如果不特别设定，则**默认无内边距显示**。通过CSS _padding_ 设定单元格内边距：

    th, td
    {
      padding: 15px;
    }

### Table with Border Spacing

Use the CSS _border-spacing_ property to set the space between the cells. 设置单元格边框间距

**注意：如果表格设置了 collapsed 边框，则设置 border-spacing 就没有效果了。**

    table
    {
      border-spacing: 5px;
    }

### Examples:

1.竖直显示表头

    <table>
      <tr>
        <th>Name:</th>
        <td>Bill Gates</td>
      </tr>
      <tr>
        <th>Telephone:</th>
        <td>555 77 854</td>
      </tr>
      <tr>
        <th>Telephone:</th>
        <td>555 77 855</td>
      </tr>
    </table>

<table>
  <tr>
    <th>Name:</th>
    <td>Bill Gates</td>
  </tr>
  <tr>
    <th>Telephone:</th>
    <td>555 77 854</td>
  </tr>
  <tr>
    <th>Telephone:</th>
    <td>555 77 855</td>
  </tr>
</table>

2.使用 `<caption>` 设置表格标题

    <table>
      <caption>Monthly savings</caption>
      <tr>
        <th>Month</th>
        <th>Savings</th>
      </tr>
      <tr>
        <td>January</td>
        <td>$100</td>
      </tr>
    </table>

<table>
  <caption>Monthly savings</caption>
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td>$100</td>
  </tr>
</table>

3.单元格 列扩展 _colspan_ ：make a cell span more than one column

    <table>
      <tr>
        <th>Name</th>
        <th colspan="2">Telephone</th>
      </tr>
      <tr>
        <td>Bill Gates</td>
        <td>555 77 854</td>
        <td>555 77 855</td>
      </tr>
    </table>

<table>
  <tr>
    <th>Name</th>
    <th colspan="2">Telephone</th>
  </tr>
  <tr>
    <td>Bill Gates</td>
    <td>555 77 854</td>
    <td>555 77 855</td>
  </tr>
</table>

4.单元格 行扩展 _rowspan_ ：make a cell span more than one row

    <table style="width:100%">
      <tr>
        <th>Name:</th>
        <td>Bill Gates</td>
      </tr>
      <tr>
        <th rowspan="2">Telephone:</th>
        <td>555 77 854</td>
      </tr>
      <tr>
        <td>555 77 855</td>
      </tr>
    </table>

<table style="width:100%">
  <tr>
    <th>Name:</th>
    <td>Bill Gates</td>
  </tr>
  <tr>
    <th rowspan="2">Telephone:</th>
    <td>555 77 854</td>
  </tr>
  <tr>
    <td>555 77 855</td>
  </tr>
</table>
