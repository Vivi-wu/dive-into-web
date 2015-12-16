---
title:  "HTML Attributes"
categories: HTML
---
HTML elements 可以有一些 attributes 特性。

+ Attributes provide **additional information** about an element, always specified in the start tag
+ Attributes come in name/value pairs like: **name="value"**
+ 特性名称是 case-insensitive 大小写不敏感的

### land 特性

The document language can be declared in the `<html>` tag with the **lang** attribute.

    <html lang="en-US">

前两个字母指定语言，如果同一种语言有分歧，再指定具体的国家。

Declaring a language is important for accessibility applications (screen readers) and search engines.定义文档语言，对于屏幕阅读器和搜索引擎可获取性很重要。

### alt 特性

The **alt** attribute specifies an alternative text to be used, when an HTML element cannot be displayed. The value of the attribute can be read by "screen readers". 
该特性设定了作为替代的文本，当该元素的内容无法展示时， alt 的值还能被屏幕阅读器读取。

### Quote 引号

HTML5 并没有要求用引号将特性值限制起来，但是最好记得使用引号。比如：

    <p title=About W3Schools>  

避免由属性值里面的空格引起的显示错误。

此外，W3C在HTML4中建议使用引号，在XHTML中要求使用引号将attribute值包围起来。

### 单/双引号

Double style quotes are the most common, but single style quotes are also allowed. 
通常使用双引号，但是单引号也是被允许的。

Tip: In some rare situations, when the attribute value itself contains quotes, it is necessary to use single quotes

    <p title='John "ShotGun" Nelson'>  

当属性值包含双引号，则必须使用单引号把它括起来。


### 建议Attribute使用lowercase

W3C **recommends** lowercase in HTML4, and **demands** lowercase for stricter document types like XHTML.
因此，尽管HTML5没有要求属性要小写(Title and/or TITLE都是被允许的)，通常使用小写的特性名称。

## HTML Global Attributes（常用的适用于任何HTML元素的属性）：

<table>
  <tbody>
    <tr>
      <td>class</td><td>one or more class names for an element (refers to a class in a style sheet)</td>
    </tr>
    <tr>
      <td>id</td><td>a unique id for an element</td>
    </tr>
    <tr>
      <td>style</td><td>an inline CSS style for an element</td>
    </tr>
    <tr>
      <td>title</td><td>extra information about an element (when mouse over the element, title displayed as a tool tip 提示框)</td>
    </tr>
  </tbody>
</table>
