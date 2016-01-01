---
title:  "HTML Input Types"
categories: HTML
---
本章中将总结所有 `<input>` 元素的 _type_ 特性可取的值。

### text

    <input type="text">

定义了一个 one-line 单行输入区域，注意：**输入区域的默认宽度是 20 characters**。

### password

    <input type="password">

在密码输入区域里的字符是隐藏的（以**星号**或者**小黑圆**显示）

### submit

    <input type="submit" value="Submit">

定义了一个用于提交表格的按钮。如果缺省提交按钮的 value 属性的值，则按钮将会显示一个默认的文本（Submit）。

### radio

    <input type="radio">

使用户只能在有限数量的选择当中**选择其一**。

### checkbox

    <input type="checkbox">

使用户在有限数量的选择当中选择**0个**或**多个选项**。

### button

    <input type="button">

定义了一个可以点击的按钮，按钮上显示的文字由 _value_ 特性决定。

<!--more-->

## HTML5 Input Types

不用担心，不被旧浏览器支持的输入类型，将以 type="text" 的形式显示。

### number

    <input type="number">

用于需要输入数字的输入区域。根据浏览器的支持情况，可以在数字输入类型元素上加一些限制，比如，min，max等。

### color

    <input type="color">

用于颜色（HEX值）的输入区域。根据浏览器支持情况，一个 color picker 颜色选择器会出现在输入区域上。

注意：目前 IE 和 Safari 不支持该类型。

### range

    <input type="range">

用于输入的值要在一定范围内的输入区域。根据浏览器支持情况，输入区域可以显示为一个控制滑块。使用 min，max，step（默认值是1），value，设定限制条件。

### month

    <input type="month">

允许用户选择某一年的某个月份。根据浏览器支持情况，一个日期选择器会出现在输入区域上。

### week

    <input type="week">

允许用户选择某一年的某个星期。根据浏览器支持情况，一个日期选择器会出现在输入区域上。

### date

    <input type="date">

用于日期的输入区域，根据浏览器支持情况，一个 date picker 日期选择器会出现在输入区域上。同样，可以对日期的取值加一些限制，min，max等。

注意：目前 IE 和 FF 不支持该跟日期有关（month，week，date）的输入类型。

### time

    <input type="time">

允许用户选择一个时间（不是时区）。根据浏览器支持情况，一个 time picker 时间选择器会出现在输入区域上。

### datetime-local

    <input type="datetime-local">

允许用户选择一个日期和时间（不是时区）。根据浏览器支持情况，一个日期选择器会出现在输入区域上。

注意：目前 IE 和 FF 不支持时间相关的（包括 time）输入类型。

### email

    <input type="email">

用于email地址的输入区域。根据浏览器支持情况，email 地址在提交时可以被自动检查是否有效。一些智能手机可以识别 email 输入类型，在键盘上添加 _.com_ 方便用户键入。

注意：目前Safari不支持该类型。

### search

    <input type="search">

用于搜索区域（一个搜索区域看起来就像一个普通的 textfield）。

注意：目前只有 Chrome 和 Safari 支持该类型。

### tel

    <input type="tel">

用于电话号码的输入区域。

注意：目前只有 Safari8 支持该类型。

### url

    <input type="url">

用于 URL 地址的输入区域。根据浏览器支持情况，URL 地址在提交时可以被自动检查是否有效。一些智能手机可以识别 url 输入类型，在键盘上添加 _.com_ 方便用户键入。

注意：目前 Safari 不支持该类型。
