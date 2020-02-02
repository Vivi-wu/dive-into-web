---
title:  "HTML Input Attributes"
category: HTML
---
本章将总结所有 Input 元素的特性。

### value

    <input type="text" name="firstname" value="John">

该特性设定了一个输入区域的**初始值**，即页面加载完用户看到的 input 的值。

### readonly

    <input type="text" name="firstname" value="John" readonly>

该特性指定了一个输入区域是只可以读，**不能被改变**的。这个特性不需要有一个值。It is the same as writing readonly="readonly".

### disabled

    <input type="text" name="firstname" value="John" disabled>

一个 disabled 的元素是 **un-usable** 不可以被使用，且 **un-clickable** 不可以点击，也**不会被提交**。该特性不需要有一个值。It is the same as writing disabled="disabled".

<!--more-->

### size

    <input type="text" name="firstname" value="John" size="40">

该特性**以 _characters_ 为单位**设定一个输入区域的大小(宽度)。

### maxlength

    <input type="text" name="firstname" maxlength="10">

该特性指定一个输入区域的最多允许输入的字符长度。但是该特性不提供任何反馈，如果你想提醒用户，必须写JS代码来实现。

**注意：为了安全地严格的输入，必须在接收端（服务器）也检查是否满足约束条件**。

## HTML5 Attributes

### autocomplete

    <input type="text" name="firstname" value="John" size="40">

该特性设定一个表单 form 或者 input 输入区域是否开启自动填充功能。若开启，浏览器会根据用户之前填充的值来填满表单。

你可以给一个 `<form>` 表单开启自动填充功能，然后针对某个 input 输入区域关闭自动填充。如下：

```html
<form action="action_page.php" autocomplete="on">
  First name:<input type="text" name="fname"><br>
  Last name: <input type="text" name="lname"><br>
  E-mail: <input type="email" name="email" autocomplete="off"><br>
  <input type="submit">
</form>
```

支持 autocomplete 特性的输入类型有：**text**，**search**，**url**，**tel**，**email**，**password**，**datepickers**，**range** 和 **color**。有些浏览器需要开启自动填充功能该特性才有效。

注意：Opera不支持该特性。

### novalidate

    <form action="action_page.php" novalidate>
      E-mail: <input type="email" name="user_email">
      <input type="submit">
    </form>

该特性是 `<form>` 特性，说明表单在提交时不必对其验证。<span class="t-blue">Form has the _novalidate_ attribute it will submit even though it contains an empty required input.</span>

注意：IE9 以前版本和 Sarari 不支持该特性。

### autofocus

    First name:<input type="text" name="fname" autofocus>

该特性是布尔类型的，当一个输入元素拥有该特性时，表示这个输入元素在页面加载时应该自动得到焦点（光标出现在这里）。

**注意**：每个页面**只允许出现一个 _autofocus_ 特性**，如果设置了多个 autofocus 特性，则相当于未指定此行为。

### form

```html
<pre name="code" class="html"><form action="action_page.php" id="form1">
  First name: <input type="text" name="fname"><br>
  <input type="submit" value="Submit">
</form>
Last name: <input type="text" name="lname" form="form1">
```

该特性指定一个 input 输入元素属于一个或多个表单。这样<span class="t-blue">即使 input 元素没有嵌套写在 `<form>`元素里，仍然可以作为这个 form 的表单数据被提交</span>。

如果想让一个 input 同时指向多个 form，用 _space-separated 列出表单的 id_。

button 元素同样支持H5 _form_ 属性

注意：IE 不支持该特性。

### formaction

    <input type="submit" formaction="demo_admin.asp" value="Submit as admin">

该特性指定了在表单提交时将要处理输入控制的文件的URL，overrides 覆盖 form 元素里的 _action_ 特性值。

### formenctype

    <input type="submit" formenctype="multipart/form-data" value="Submit as Multipart/form-data">

该特性指定了在提交到服务器时表单数据应该被如何编码（**只针对使用 post 方法的表单**），覆盖 form 元素里的 _enctype_ 特性。

### formmethod

    <input type="submit" formmethod="post" formaction="demo_post.asp" value="Submit using POST">

该特性指定了表单数据发送到 action URL 使用的 HTTP 方法，覆盖 form 元素里的 _method_ 特性。

### formnovalidate

    <input type="submit" formnovalidate value="Submit without validation">

该特性是布尔类型的，带有这个特性的 input，在表单提交时不应该被认为是有效的。覆盖 form 元素里的 _novalidate_ 特性。用在 **type="submit"** 的元素上。

注意：Sarari 不支持该特性。

### formtarget

    <input type="submit" formtarget="_blank" value="Submit to a new window">

该特性指定了一个名字或关键字（当提交表单后在哪里显示接收到的结果），覆盖 form 元素里的 _target_ 特性。同 **formaction**，**formenctype**, **formmethod** 一样，用在 _type="submit"_ 和 _type="image"_ 的元素上。

### height， width

    <input type="image" src="img_submit.gif" alt="Submit" width="48" height="48">

这两个特性指定了一个 input 元素的高和宽，**只能用在** type="image" 的元素上。

### list

该特性用来指向拥有与其值相同的id值的 `<datalist>` 元素，注意：Sarari不支持该特性。

### min， max

```html
Enter a date before 1980-01-01:
<input type="date" name="bday" max="1979-12-31">
Enter a date after 2000-01-01:
<input type="date" name="bday" min="2000-01-02">
Quantity (between 1 and 5):
<input type="number" name="quantity" min="1" max="5">
```

这两个特性指定了一个 input 元素的最小值和最大值，支持该特性的输入类型有：**number**，**range**，**date**，**datetime-local**，**month**，**time** 和 **week**。

注意：FF 不支持该特性，IE 支持也不够好。

### multiple

    Select images: <input type="file" name="img" multiple>

该特性是布尔类型的，带有这个特性的输入元素表示用户被允许键入一个以上的值。支持这个特性的输入类型有：**email** 和 **file**

### pattern

    Country code: <input type="text" name="country_code" pattern="[A-Za-z]{3}" title="Three letter country code">

该特性指定一个输入元素的值需要遵循的 regular expression 常规表达式。支持这个特性的输入类型有：**text**，**search**，**url**，**tel**，**email** 和 **password**。

要求输入的值是完全符合 pattern 要求的规则（换句话说，pattern 特性的值 has to match the entire string）

注意：IE9 及之前版本和 Sarari 不支持该特性。

### placeholder

    <input type="text" name="fname" placeholder="First name">

该特性指定一个 hint 提示，描述该输入区域期望的输入值（一个输入值的例子或者一个简短的类型描述）。这个提示在用户键入值之前显示。支持这个特性的输入类型有：**text**，**search**，**url**，**tel**，**email** 和 **password**。

### required

    Username: <input type="text" name="usrname" required>

该特性是布尔类型的，带有这个特性的输入元素表示在提交表单前必须填写。支持这个特性的输入类型有：**text**，**search**，**url**，**tel**，**email**，**password**，**data pickers**， **number**，**checkbox**，**radio** 和 **file**。

注意：IE9及之前版本和 Sarari 不支持该特性。

### step

    <input type="number" name="points" step="3">

该特性指定一个输入元素合法的数字间隔。上面的例子 legal numbers could be -3, 0, 3, 6, etc. 支持这个特性的输入类型有：**number**，**range**，**date**，**datetime-local**，**month**，**time** 和 **week**。

为了配合step特性，HTML5引入了 stepUp 和 stepDown 两个函数来根据 step 特性的值来增加或减少控件的值。

注意：IE9 及之前版本和 FF 不支持该特性。
