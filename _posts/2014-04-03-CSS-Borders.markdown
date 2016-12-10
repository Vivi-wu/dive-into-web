---
title:  "CSS Borders"
category: CSS
---

## CSS Borders

+ _border-style_ 属性指定要显示什么类型的边框。可能的取值:

    + `none`: 没有边框
    + `dotted`: 小方块（像素点）连成的
    + `dashed`: 虚线的（比 dotted 长）
    + `solid`: 实线边框
    + `double`: 双实线边框，边框之间的距离等于 _border-width_ 边框宽度的值
    + `groove`: 3D纹理（槽）边框
    + `ridge`: 3D隆起的
    + `inset`: 3D嵌入的
    + `outset`: 3D突出的
    + `hidden`: 效果同 "none"

+ _border-width_ 设定四条边的边框宽度。宽度可以用指定的尺寸（以 px，pt，cm，em 等为单位），或者使用三个预定义的值（`thin`, `medium`, 或 `thick`）
+ _border-color_ 设定四条边的边框颜色。颜色可以按照 CSS color 的 **name**, **RGB**, **HEX** 设定，也可以设为 `transparent` 透明的。

<!--more-->

### 赋值的形式

_border-style_ 可以同时拥有**1**到**4**个值，按照 <span class="t-blue">上 右 下 左 --> 顺时针</span> 赋值。_border-width_ 和 _border-color_ 的赋值同样适用。

1. border-style: <span class="t-red">dotted solid double dashed</span>;。效果如下：

    <div style="border-style: dotted solid double dashed;border-width: 4px;height: 2rem;max-width: 28rem;"></div>

2. border-style: <span class="t-red">dotted solid double</span>;。效果如下：

    <div style="border-style: dotted solid double;border-width: 4px;height: 2rem;max-width: 28rem;"></div>

3. border-style: <span class="t-red">dotted solid</span>;。效果如下：

    <div style="border-style: dotted solid;border-width: 4px;height: 2rem;max-width: 28rem;"></div>

4. border-style: <span class="t-red">dotted</span>;。效果如下：

    <div style="border-style: dotted;border-width: 4px;height: 2rem;max-width: 28rem;"></div>

**注意**: <span class="t-blue">除非先设定 **border-style** 性质，否则任何 border 性质（如：width、color...）都不会产生效果</span>。

### Individual Sides 单独边框

我们可以单独对一条边（top，right，bottom，left）的边框进行设定。

比如: _border-top-style_, _border-right-style_, _border-bottom-style_, _border-left-style_

### All in one 简写形式

可使用 _border_ 属性一次性设定边框四条边的样式，如果有一个值没有设定，也是允许的。但应遵循的顺序如下：

+ border-width: medium（默认值）
+ border-style (**required**): none（默认值）
+ border-color: 元素的 color 即字体颜色（默认值）
 
Tip: 同样的，可以只针对一条边来一次性设定边框样式。规则同上。

_border-top_, _border-right_, _border-bottom_, _border-left_

### CSS 画等腰直角三角形

<div style="width:100px;height:50px;border-width:1rem;background-color:pink;border-style:solid;border-color: black gray black gray;margin-bottom:1rem;margin-right:1rem;float:left;"></div>

当边框调到很粗的时候，每条边的边框会出现三角形的基本轮廓。

<p style="clear:left;">因此我们可以借助 CSS border 绘制三角形。</p>

<div style="margin-bottom:1rem">
<span>上：</span><div style="display:inline-block;width:0;height:0;border-width:20px;border-style:solid;border-color:transparent transparent #363532 transparent;"></div>
<span>右：</span><div style="display:inline-block;width:0;height:0;border-width:20px;border-style:solid;border-color:transparent transparent transparent #363532;"></div>
<span>下：</span><div style="display:inline-block;width:0;height:0;border-width:20px;border-style:solid;border-color:#363532 transparent transparent transparent;"></div>
<span>左：</span><div style="display:inline-block;width:0;height:0;border-width:20px;border-style:solid;border-color:transparent #363532 transparent transparent;"></div>
</div>


```css
div { /* 向上的三角形 */
  width: 0;
  height: 0;
  border-width: 20px;
  border-style: solid;
  border-color: transparent transparent #363532 transparent;
}
```

### CSS 画非等腰三角形

通过设置元素宽、高为 0，边框样式为 solid，上边框设置一定的宽度和颜色，左右两边设为同尺寸透明边框，可绘制出非直角三角形。

下面借助 CSS 实现一个简单的三步操作进度条：

<p data-height="400" data-theme-id="0" data-slug-hash="GNoXNR" data-default-tab="result" data-user="VivienneWU" data-embed-version="2" data-pen-title="CSS progress bar" class="codepen">See the Pen <a href="http://codepen.io/VivienneWU/pen/GNoXNR/">CSS progress bar</a> by Vivienne (<a href="http://codepen.io/VivienneWU">@VivienneWU</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

## CSS3 Borders 新属性

1. _border-radius_ 该属性实际上是 border-**top**-**left**-radius, border-**top**-**right**-radius, border-**bottom**-**right**-radius 和 border-**bottom**-**left**-radius 这四个属性的 all in one 缩写形式。

    通过给 _border-radius_ 属性赋予不同个数的值，来指定每一个圆角。当取值为：

    + 四个值：左上角、右上角、右下角、左下角

        <div style="width: 15rem;height: 4rem;border-radius: 5px 10px 30px 40px;background-color: #bca590;padding: 0.5rem 0 0 0.5rem;;">border-radius: 5px 10px 30px 40px;</div>

    + 三个值：左上角、右上角和左下角（**两个斜对角**）、右下角

        <div style="width: 15rem;height: 4rem;border-radius: 5px 10px 30px;background-color: #bca590;padding: 0.5rem 0 0 0.5rem;;">border-radius: 5px 10px 30px;</div>

    + 两个值：左上角和右下角、右上角和左下角

        <div style="width: 15rem;height: 4rem;border-radius: 5px 20px;background-color: #bca590;padding: 0.5rem 0 0 0.5rem;;">border-radius: 5px 20px;</div>

    + 一个值：四个角

        <div style="width: 15rem;height: 4rem;border-radius: 5px;background-color: #bca590;padding: 0.5rem 0 0 0.5rem;;">border-radius: 5px;</div>

2. _box-shadow_ 给元素添加水平和（或）竖直方向上的阴影，设定阴影的颜色、模糊效果。Tip: 通过给 _::before_ and _::after_ 伪类添加 shadow，可以实现有趣的效果。

    该属性可以给一个元素添加**一个**或**多个**阴影，使用**逗号**来分隔开每一种阴影效果。

    `box-shadow: none|h-shadow v-shadow blur spread color |inset|initial|inherit;`

    + `none`: 默认不显示阴影
    + h-shadow: **required**, 水平阴影的位置，允许负值
    + v-shadow: **required**, 竖直阴影的位置，允许负值
    + blur: 可选的, 模糊的距离
    + spread: 可选的, 阴影的尺寸大小，允许负值
    + color: 可选的, 默认是**黑色**，<span class="t-blue">PC 端 Safari 中，颜色值是 required。如果不指定颜色，将不显示阴影</span>
    + inset: 可选的, 把默认的 outset 外部阴影显示为 inner shadow，向内的阴影。

3. _border-image_ 该属性有包含三部分：所需的图片，裁剪图片的位置（将图片分为9部分，像一个井字棋盘，It then places the corners at the corners, and the middle sections are repeated or stretched as you specify.），定义中间部分是否需要重复或拉伸。是以下属性的 all in one 简写形式。

    + border-**image-source**
    + border-**image-slice**
    + border-**image-width** 默认值是 1
    + border-**image-outset** 默认值是 0
    + border-**image-repeat**（可取值 `stretch` **默认值**，`repeat`，`round`，`space`）

    其中，_border-image-repeat_ 取值为 `round` 时，是说图片按照整数的 tiles 重复排列以填充边框区域，如果不满足整数，图片会 rescaled 重新缩放来填充。

    当取值为 `space` 时，也是要求按整数个 tiles 重复排列来填充，如果不满足，剩余的空间将平均分配到 tiles 的周围。

**注意**：<span class="t-blue">要使用图片边框，需要设置 **border** 性质</span>。
