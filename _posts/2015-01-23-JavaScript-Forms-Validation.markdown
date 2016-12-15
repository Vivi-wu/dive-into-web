---
title:  "JavaScript Forms Validation API"
category: JavaScript
---
## Data Validation

数据验证是为了保证输入是 clean、correct and useful，分为服务器端验证和客户端（浏览器）的验证。H5引入了新的验证原则叫做 **constraint validation**。

基于 HTML Input Attributes，CSS Pseudo Selectors，DOM Properties and Methods。前两者内容参考 HTML 和 CSS 部分文章，本章围绕 DOM 属性和方法。

<!--more-->

## DOM Methods and Properties

与 constraint validation 有关的 DOM 方法和属性是：

+ `checkValidity()`, 如果一个输入元素包含 valid data，返回 true
+ `setCustomValidity()`, 设置一个输入元素的 _validationMessage_ 属性
+ _validity_, 包含与一个输入元素的 validity 有关的一系列 boolean 属性，见下面详细列表
+ _validationMessage_, 包含当输入元素的 validity 是 false 时，浏览器将要显示的消息。
+ _willValidate_, 显示一个输入元素是否将要 validated

## Validity 的属性

一个元素的 validity 属性，包含一系列与数据有效性相关的属性。当满足条件时，下面这些属性值为 **true**

+ _customError_, 如果设定了一个自定义的 validity 消息
+ _patternMismatch_, 如果一个元素的值与它的 pattern 特性不匹配
+ _rangeOverflow_, 如果一个元素的值大于它的 max 特性
+ _rangeUnderflow_, 如果一个元素的值小于它的 min 特性
+ _stepMismatch_, 如果一个元素的值不符合它的 step 特性，比如设定 step 为 3，初始值为 1，那么输入 5 就不合法。
+ _tooLong_, 如果一个元素的值超过了它的 maxLength 特性
+ _typeMismatch_, 如果一个元素的值不符合它的 type 特性
+ _valueMissing_, 如果一个元素设定了 required 特性，但是没有输入值，这个属性为 true。
+ _valid_, 如果一个元素的值是 valid 时

**注意**：<span class="t-blue">一个输入域如果没有值，将会从 constraint validation 中**排除**</span>。The empty string is considered valid (no misMatch) unless the _required_ attribute is present as well (符合 valueMissing).
