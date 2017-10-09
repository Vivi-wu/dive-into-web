---
title:  "HTML Forms and Form Elements"
category: HTML
---
## Overview

The `<form>` element defines an HTML form, 该元素定义了一个HTML表单，用于**收集用户输入**。表单包含 **form element**，由不同类型的输入元素组成，可以是 input elements（是最重要的表单元素，将在专门的章节写），多选框，单选框，提交按钮等。

### The _action_ Attribute

该特性定义了当表单被提交后要执行的动作。通常表单被提交到服务器端的一个带有处理脚本的网页上（称为form-handler）。要提交表单，通常使用一个 submit 按钮。

如果该特性 omitted 缺省，则动作被指定为当前页面 is set to the current page。

### The _method_ Attribute

该特性指定了在提交表单时使用的 HTTP 的方法 （**GET** or **POST**）

    <form action="action_page.php" method="GET">

The **default method** is **GET**.

<!--more-->

### 什么时候使用 GET 方法呢？

If the form submission is passive (like a search engine query 搜索引擎查询), 且 without sensitive information.

使用 GET 方法，表单的数据将会在URL上可见。

     action_page.php?firstname=Mickey&lastname=Mouse

这种方适合小量数据提交。

Size limitation is set in your browser(不同浏览器max length不同，2KB-8KB)

### 什么时候用 POST 方法呢？

如果需要更新 database 数据，或者包含敏感信息（如：password），POST 方法较为安全。提交的数据在地址栏里不可见。

### 再看 GET、POST 区别

GET **只接受 ASCII 字符**（参看 HTML-Entities-Charset-URL-Encode 章节），为什么呢？因为 GET 从 URL 的 query string 里获取参数，而 URL 是 HTTP 的一个首部，一定是 ASCII 字符的。如果 GET 请求中包含非 ASCII 字符，在发送请求前使用 URL 编码方法对其转码。

POST 不限制，因为数据是 HTTP 的实体，且使用 MIME（Multipurpose Internet Mail Extensions 多用途互联网邮件扩展）可传输非 ASCII 字符

## The _name_ Attribute

To be submitted correctly, each input field **must have** a name attribute. 为了正确地提交数据，表单里每一个 输入域都必须包含 _name_ 特性。

注意：<span class="t-red">没有设定 _name_ 特性的 input field 的值将不被提交</span>。

## Grouping Form Data

使用 `<fieldset>` 元素将表单里相关的数据分组，and create a border around the elements。使用 `<legend>` 元素为前者定义一个 caption 说明文字标题。

表单 `<form>`元素上可使用的特性还有：

+ accept-charset, 设置提交表单的字符集，**默认 page charset**
+ autocomplete, 设置是否让浏览器自动填充表单，**默认 on**
+ enctype, 设置提交数据的编码方式，**默认 url－encoded**
+ name, 用来身份识别表单，比如DOM操作里 `document.forms['formName']` 可以得到 `name` 特性值为 formName 的 `<form>` 元素
+ novalidate, 设置浏览器不要确认表单（初始化表单是没有通过验证的）

## The `<select>` Element (Drop down list)

该元素定义了一个下拉菜单：

```html
<select>
  <optgroup label="Swedish Cars">
    <option value="volvo">Volvo</option>
    <option value="saab">Saab</option>
  </optgroup>
  <optgroup label="German Cars">
    <option value="mercedes">Mercedes</option>
    <option value="audi">Audi</option>
  </optgroup>
</select>
```

<div>
<span>Options 分组： </span>
<select>
  <optgroup label="Swedish Cars">
    <option value="volvo">Volvo</option>
    <option value="saab">Saab</option>
  </optgroup>
  <optgroup label="German Cars">
    <option value="mercedes">Mercedes</option>
    <option value="audi">Audi</option>
  </optgroup>
</select>
<span style="margin-left:2em;">指定默认被选值： </span>
<select>
  <option value="volvo">Volvo</option>
  <option value="saab">Saab</option>
  <option value="mercedes">Mercedes</option>
  <option value="audi" selected>Audi</option>
</select><br>
<span>自定义默认显示文本（而不是某个 Option 文本）： </span>
<select>
  <option value="">-- Pls choose one car ---</option>
  <option value="volvo">Volvo</option>
  <option value="saab">Saab</option>
  <option value="mercedes">Mercedes</option>
  <option value="audi">Audi</option>
</select>
</div>
<br/>

通常 `<select>` 显示的文本是**第一个选项的文本**，可以通过在指定的 `<option>` 元素上添加 _selected_ 特性，让它作为默认被选项。

与之相关的还有 `<optgroup>` 元素，用来把下拉列表里相关的 options 分组到一起。

## The `<textarea>` Element

该元素定义了一个 multi-line 多行输入区域。

    <textarea name="message" rows="10" cols="30">
    The cat was playing in the garden.
    </textarea>

The size of a text area can be specified by the _cols_ and _rows_ attributes, or even better; through CSS' height and width properties.

## The `<button>` Element

该元素定义了一个可以点击的按钮。

    <button type="button">Click me!</button>

该元素的内容可以是文字或图片，**有别与使用 `<input>` 元素创建的按钮**

**Tips**: 记住指定该元素的 _type_ 特性（**button**，**reset**，**submit**），因为不同的浏览器针对 `<button>` 元素使用不同的默认类型。如果你想点击按钮执行特定脚本，而又没有指定它的类型是 button，谷歌浏览器会当作表单 submit 处理。

## HTML5 `<datalist>` Element

该元素为传统的 `<input>` 单行输入区域元素提供了一列 pre-defined options，方便用户从下拉列表里选择其中一个作为输入数据。**用户仍可以在输入框中键入自己想要的值**，区别与 `<select>` 元素。

```html
<input list="browsers">
<datalist id="browsers">
  <option value="Internet Explorer">
  <option value="Firefox">
  <option value="Chrome">
  <option value="Opera">
  <option value="Safari">
</datalist>
```

注意：

+ Safari 和 IE9 之前版本目前不支持这个元素
+ `<input>` 的 _list_ 特性值必须指向 `<datalist>` 的 _id_ 特性（保持一致）。

## HTML5 `<output>` Element

该元素显示一个运算的结果，就像被一段脚本执行。

```html
<form action="action_page.asp" oninput="x.value=parseInt(a.value)+parseInt(b.value)">
  0
  <input type="range"  id="a" name="a" value="50">
  100 +
  <input type="number" id="b" name="b" value="50">
  =
  <output name="x" for="a b"></output>
  <input type="submit">
</form>
```

#### 针对像 range 这样的控件（改变 range 的值，并没有显示效果）可像下面这样用：

    <label for="age">Age</label>
    <input id="age" type="range" min="18" max="120" value="18" onchange="ageDisplay.value=value">
    <output id="ageDisplay>18</output>

### Bonus

如何用表单发送email，点击提交，弹出默认邮件客户端，各个定义了 _name_ 特性的输入域的值，将被自动写入邮件内容区域。

```html
<form action="MAILTO:someone@example.com" method="post" enctype="text/plain">
  Name:<br>
  <input type="text" name="name" value="your name"><br>
  E-mail:<br>
  <input type="text" name="mail" value="your email"><br>
  Comment:<br>
  <input type="text" name="comment" value="your comment" size="50"><br>
  <input type="submit" value="Send">
  <input type="reset" value="Reset">
</form>
```

### Best Practise

1. 当表单中只有唯一的input输入区域，Enter 键盘事件(keycode为13)将**自动提交表单**
2. 提交方法为 post、patch 等，设置禁止连续点击按钮效果
3. 用户手动输入的值要做 trim 处理，去掉首尾的空格
4. 指定表单里某个输入域获取光标焦点 `form['myName'].focus()`，采用的是指定元素获得焦点的方法 `HTMLElement.focus()`
5. 输入框的 input 事件**实时**反应输入值，而 change 事件只有在**光标再次失去焦点时**才反应输入值
