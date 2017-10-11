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
+ `setCustomValidity()`, 设置一个输入元素的 _validationMessage_ 属性，将表单控件置于 customError 状态

	常见的例子是，比较两次输入的密码是否一致。不一致时，传入一个自定义的错误 message。相匹配时，则 `setCustomValidity("")`

+ _validity_, 包含与一个输入元素的 validity 有关的一系列 boolean 属性，见下面详细列表
+ _validationMessage_, 包含当输入元素的 validity 是 false 时，浏览器将要显示的消息。
+ _willValidate_, 显示一个输入元素是否将要 validated

## Validity 的属性

一个元素的 validity 属性（如 _document.myForm.myInput.validity_），包含一系列与数据有效性相关的属性。当满足条件时，下面这些属性值为 **true**

+ _customError_, 如果设定了一个自定义的 validity 消息
+ _patternMismatch_, 输入值不符合设置的格式 pattern 规则。（在包含_pattern_ 特性的表单控件中设置 _title_ 特性以说明模式规则。）
+ _rangeOverflow_, 如果一个元素的值大于它的 max 特性的值
+ _rangeUnderflow_, 如果一个元素的值小于它的 min 特性的值
+ _stepMismatch_, 如果一个元素的值不符合它的 step 特性的值，比如设定 step 为 3，初始值为 1，那么输入 5 就不合法。
+ _tooLong_, 如果一个元素的值超过了它的 maxLength 特性的值
+ _typeMismatch_, 表单控件中的值与预期 type 不匹配
+ _valueMissing_, 如果一个元素设定了 required 特性，但是没有输入值，这个属性为 true。
+ _valid_, 如果一个元素的值是 valid 时

**注意**：<span class="t-blue">一个输入域如果没有值，将会从 constraint validation 中**排除**</span>。The empty string is considered valid (no misMatch) unless the _required_ attribute is present as well (符合 valueMissing).

## Forms API

HTML5 Forms 规范的核心是功能性动作和语义，而非外观和显示效果。

1. 浏览器不支持新的输入控件时，会把它们呈现为简单的文本输入框。

2. progress 进度条元素，对于不确定的进度条，通常会显示为动态的条，但上面没有完成百分比的指示符。设置 progress 元素的 value 属性和 max 属性（前者除以后者能够计算出进度条上显示的完成百分比）则可以触发确定的进度条显示。

3. 对带有文本内容的输入控件和 textarea 控件设置 spellcheck 属性，需要赋值（有些属性只需要设置而不需要给定 value 就可以生效，比如 autofocus，但是 spellcheck=“true” 才能生效）。大部分浏览器默认启用 spellcheck。

4. 表单验证实际上是一种优化，避免错误数据在客户端和服务器端来回传输。让 Web 应用更快地抛出错误，利用浏览器内置的处理机制来告诉用户网页内包含无效的表单控件值。但仍然不能完全取代服务器端验证。

5. 只要发生表单验证（不管是在提交表单时，还是直接调用 checkValidity 函数），所有未通过验证的表单都会接收到一
个 invalid 事件。如果不希望使用浏览器提供的默认的验证反馈，在 invalid 事件处理函数中写明 `event.preventDefault()`。同时为阻止其他程序处理 invalid 事件，调用 `stopPropagation()` 函数。

6. 默认的 form.submit 表现为：将表单数据提交到 action 属性所指向的地址，并刷新页面。
