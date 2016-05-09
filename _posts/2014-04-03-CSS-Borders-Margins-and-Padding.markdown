---
title:  "CSS Borders, Margins and Padding"
category: CSS
---

## CSS Borders

+ _border-style_ 属性指定要显示什么类型的边框。

    可能的取值:

    + `none`: 没有边框
    + `dotted`: 小方块（像素点）连成的
    + `dashed`: 虚线的（比 dotted 长）
    + `solid`: 实线边框
    + `double`: 双实线边框，边框之间的距离等于 _border-width_ 边框宽度的值
    + `groove`: 3D纹理（槽）边框
    + `ridge`: 3D隆起的
    + `inset`: 3D嵌入的
    + `outset`: 3D突出的
    + `hidden`: The same as "none"

+ _border-width_ 性质用于设定四条边的边框宽度。宽度可以用指定的尺寸（以 px，pt，cm，em 等为单位），或者使用三个预定义的值（**thin**, **medium**, or **thick**）
+ _border-color_ 性质用于设定四条边的边框颜色。颜色可以按照 CSS color 的 **name**, **RGB**, **HEX** 设定，也可以设为 **transparent** 透明的。

<!--more-->

### 赋值的形式

_border-style_ 可以同时拥有**1**到**4**个值，按照 <span class="blue-text">上 右 下 左 --> 顺时针</span> 赋值。_border-width_ 和 _border-color_ 的赋值同样适用。

1. `border-style: dotted solid double dashed;`

    + **top** border is dotted
    + **right** border is solid
    + **bottom** border is double
    + **left** border is dashed

2. `border-style: dotted solid double;`

    + **top** border is dotted
    + **right** and **left** borders are solid
    + **bottom** border is double

3. `border-style: dotted solid;`

    + **top** and **bottom** borders are dotted
    + **right** and **left** borders are solid

4. `border-style: dotted;`

    + **all** four borders are dotted

**注意**: <span class="blue-text">除非先设定 **border-style** 性质，否则任何 border 性质（如：border width、border color...）都不会产生效果</span>。

### Individual Sides 单独边框

我们可以单独对一条边（top，right，bottom，left）的边框进行设定。

比如: _border-top-style_, _border-right-style_, _border-bottom-style_, _border-left-style_

### All in one 简写形式

可使用 _border_ 属性一次性设定边框四条边的样式，如果有一个值没有设定，也是允许的。但应遵循的顺序如下：

+ border-width 默认值: medium
+ border-style (**required**)默认值: none
+ border-color 默认值: the color of the element
 
Tip: 同样的，可以只针对一条边来一次性设定边框样式。规则同上。

_border-top_, _border-right_, _border-bottom_, _border-left_

### 用 CSS 画三角形

<div>
<span>上：</span><div style="display:inline-block;width:0;height:0;border-width:20px;border-style:solid;border-color:transparent transparent yellow transparent;"></div>
<span>右：</span><div style="display:inline-block;width:0;height:0;border-width:20px;border-style:solid;border-color:transparent transparent transparent yellow;"></div>
<span>下：</span><div style="display:inline-block;width:0;height:0;border-width:20px;border-style:solid;border-color:yellow transparent transparent transparent;"></div>
<span>左：</span><div style="display:inline-block;width:0;height:0;border-width:20px;border-style:solid;border-color:transparent yellow transparent transparent;"></div>
</div><br>

代码如下：

    div {
      width: 0;
      height: 0;
      border-width: 20px;
      border-style: solid;
      border-color: transparent transparent yellow transparent;
    }

## CSS3 Border 新属性

CSS3 使我们可以给任何元素设定圆角边框，给边框加阴影，使用图片作为边框。

+ _border-radius_ 该属性实际上是 border-**top**-**left**-radius, border-**top**-**right**-radius, border-**bottom**-**right**-radius and border-**bottom**-**left**-radius 这四个属性的 all in one 缩写形式。

    通过给 _border-radius_ 属性赋予不同个数的值，来指定每一个圆角。当取值为：

    + 四个值：左上角、右上角、右下角、左下角
    + 三个值：左上角、右上角和左下角（两个斜对角）、右下角
    + 两个值：左上角和右下角、右上角和左下角
    + 一个值：四个角

+ _box-shadow_ 属性给元素添加水平和（或）竖直方向上的阴影，设定阴影的颜色、模糊效果。通过给 _::before_ and _::after_ 伪类添加 shadow，可以实现有趣的效果。

    该属性可以给一个元素添加**一个**或**多个**阴影，使用逗号来分隔开每一种阴影效果。

    `box-shadow: none|h-shadow v-shadow blur spread color |inset|initial|inherit;`

    + `none`: 默认不显示阴影
    + h-shadow: **required**, 水平阴影的位置，允许负值
    + v-shadow: **required**, 竖直阴影的位置，允许负值
    + blur: 可选的, 模糊的距离
    + spread: 可选的, 阴影的尺寸大小，允许负值
    + color: 可选的, 默认是**黑色**，<span class="blue-text">PC 端 Safari 中，颜色值是 required。如果不指定颜色，将不显示阴影</span>
    + inset: 可选的, 把默认的 outset 外部阴影显示为 inner shadow，向内的阴影。

+ _border-image_ 该属性有包含三部分：所需的图片，裁剪图片的位置（将图片分为9部分，像一个井字棋盘，It then places the corners at the corners, and the middle sections are repeated or stretched as you specify.），定义中间部分是否需要重复或拉伸。

    实际上是 border-**image-source**, border-**image-slice**, border-**image-width** 默认值是 1, border-**image-outset** 默认值是 0, border-**image-repeat**（可取值 stretch 默认值，repeat，round，space）属性的简写形式。

    其中，_border-image-repeat_ 取值为 `round` 时，是说图片按照整数的 tiles 重复排列以填充边框区域，如果不满足整数，图片会 rescaled 重新缩放来填充。

    当取值为 `space` 时，也是要求按整数个 tiles 重复排列来填充，如果不满足，剩余的空间将平均分配到 tiles 的周围。

**注意**：<span class="blue-text">要使用图片边框，需要设置 **border** 性质</span>。

## CSS Margins

_margin_ 属性用来设定元素边框外边空白区域（**outside** the border）的大小。

**注意**：<span class="blue-text">外边距是完全**透明的**，没有 background color</span>。

_margin_ 属性实际上是 _margin-top_, _margin-right_, _margin-bottom_, _margin-left_ 四个属性的 all in one 缩写形式。设定方式同 border。

可以取值类型：

+ `auto`，浏览器来计算外边距。
+ length，以 px，pt，cm 等为单位来指定，默认值是**0**
+ %，以所包含元素的宽度的百分比来指定
+ inherit

**注意**：<span class="blue-text">外边距可以取**负值**，因为两个元素可以重叠 overlap</span>。

## CSS Padding

_padding_ 属性用来设定元素的内容和元素的边框之间空白区域（**inside** the border）的大小。

**注意**：<span class="blue-text">内边距受到元素的 background color 影响</span>。

_padding_ 属性实际上是 _padding-top_, _padding-right_, _padding-bottom_, _padding-left_ 四个属性的 all in one 缩写形式。设定方式同 border。

可以取值类型：

+ length，以 px，pt，cm 等为单位来指定，默认值是**0**
+ %，以所包含元素的宽度的百分比来指定
+ inherit
