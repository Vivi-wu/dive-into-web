---
title:  "CSS Media Queries"
category: CSS
---
本文为 <a href="https://www.w3.org/TR/css3-mediaqueries/" target="_blank">W3C Recommendation Media Queries</a> 文档阅读笔记。

A media query consists of a **media type** and **zero or more expressions** that check for the conditions of particular media features. 一个媒体查询由一种媒体类型和 0 个或多个表达式（用于检查某种媒体特征的条件）构成。

通过使用媒体查询，可以为特定范围的输出设备量身定制样式，而不需要改变其内容。
 
一个媒体查询是一个逻辑表达式，要么为真要么为假。

<!--more-->

<span class="t-blue">当媒体查询的 media type 匹配上用户代理所运行的设备的媒体类型，且媒体查询中所有表达式都为真时，这个媒体查询才为真</span>。

### 用法

1. 用于所有类型设备的媒体查询，可以缺省关键字 _all_。

    以下两句等价：

        @media all and (min-width:500px) { … }
        @media (min-width:500px) { … }

2. 几个媒体查询可以组合在一个媒体查询列表里。由逗号分隔开。

    在媒体查询语法中，`,` 代表**逻辑或**，关键字 `and` 代表**逻辑与**。因此媒体查询 list 中，只要有一个为真，则结果为真。

        @media screen and (color), projection and (color) { … }

3. 如果媒体查询列表为空（描述为空字串或就是空格），则认为媒体查询结果为真

    以下两句等价：

        @media all { … }
        @media { … }

4. **逻辑非**可以通过关键字 `not` 来表示。

    那些只支持查询 media type 的用户代理将不识别关键字 not，相关联的样式表不会被应用。

        <link rel="stylesheet" media="not screen and (color)" href="example.css" />

5. 关键字 `only` 也可以被用来对旧用户代理隐藏样式表。

        <link rel="stylesheet" media="only screen and (color)" href="example.css" />

注意：CSS 样式表通常大小写不敏感，媒体查询也是 case-insensitive。

### Error Handling

1. Unknown media type 未知的媒体类型，或者规定的媒体类型与设备不匹配
2. Unknown media features 未知的媒体特征，比如：

    ```css
    @media aural and (device-aspect-ratio: 16/9) { … }
    @media screen and (max-weight: 3kg) { … }
    @media (min-orientation: portrait) { … }
    ```

3. Unknown media feature value 未知的媒体特征的取值

    ```css
    @media (min-width: -100px) { … } /* 作为媒体特征的宽度不允许取负值 */
    @media (color:20example) { … }  /* unknown value for the ‘color’ */
    ```

4. Malformed media query 异常的媒体查询，在解析时遇到意外的 tokens

    ```css
    @media &test, screen { … }
    @media all and(color) { … } /* having no space between ‘and’ and the expression is not allowed */
    @media test;,all { body { background:lime } } /* semicolon terminates the @media rule in CSS */
    ```

Media features 的类型和取值规范参阅文档，因为比较多，就不搬了。

除了使用 `@media` 引入媒体查询，还可以跟 HTML, XHTML, XML 以及 `@import` 一起用：

```html
<link rel="stylesheet" media="screen and (color)" href="example.css" />
```

```css
@import url(color.css) screen and (color);
```
