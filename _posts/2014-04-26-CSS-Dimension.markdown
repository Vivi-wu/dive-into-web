---
title:  "CSS Dimension"
category: CSS
---
## CSS Dimension

CSS 的范围属性用来控制元素 content 区域的高和宽，**不包含**内边距、边框和外边距。

### Height & Width

基本的 _height_, _width_ 属性可取的值：

+ `auto`: **默认值**，浏览器来计算
+ length: 以 px, cm, 等为单位具体的值
+ %: 以所包含的内容模块的百分比显示

<!--more-->

### Max-height、Max-width、Min-height、Min-width

设定尺寸最大值用来解决的问题如：某元素有 _max-width_，当浏览器宽度大于它时，元素的宽度就是这个最大宽度，是固定的。而当浏览器宽度减小，直到小于元素最大宽度时，**元素的宽度会随着浏览器宽度一起减小**（有 responsive 的效果）。如果不设定最大宽度，则，在浏览器窗口宽度小于元素宽度时，将出现水平 scrollbar。

_max-*_ 可取的值：

+ `none`: **默认值**，意思是默认没有最大宽度或高度
+ length: 以 px, cm, 等为单位具体的值
+ %: in percent of the containing block

**注意**: <span class="blue-text">_max-height/width_ 属性的值 **override** 覆盖 _height/width_ 所设定的值</span>。

设定尺寸最小值是为了避免元素的宽度过于小。

_min-*_ 可取的值：

+ length: 默认值为 **0**，以 px, cm, 等为单位具体的值
+ %

**注意**: <span class="blue-text">_min-height/width_ 属性的值 **override** 覆盖 _max-height/width_ 属性和 _height/width_ 所设定的值</span>。

Tips: 对于 `<p>` 元素设置 _max-height_ 看起来并不会影响到文字排版，**不会起到限制文字内容总高度的作用**。要弄清楚原因，我们可以给这个元素设置背景颜色，可以看到只有在 max-height 高度范围内的文字有背景色。

## CSS Box Model

所有 HTML 元素可以被认为是一些盒子。在 CSS 中，当讨论设计和布局时，会用到 box model 盒模型。

The CSS box model consists of: **margins**, **borders**, **padding**, and the actual **content**.

正如上面所写到的，当我们用 CSS 设定元素的宽和高时，我们只是设定了 the width and height of the **content area**. 所以在计算元素完整的尺寸时，要加上内边距、边框和外边距。

## CSS Outline

_outline_ 该属性用来设定元素的轮廓——围绕元素所画的线，**outside the border**。

**注意**: <span class="blue-text">轮廓**不是**元素的一部分，因此，outline 的宽度不会影响到元素的宽和高</span>。

+ `outline-style` 属性指定要显示什么类型的轮廓。

    可能的取值:

    + `dotted`: 小方块（像素点）连成的
    + `dashed`: 虚线的（比 dotted 长）
    + `solid`: 实线边框
    + `double`: 双实线边框，边框之间的距离等于 _border-width_ 边框宽度的值
    + `groove`: 3D纹理（槽）边框
    + `ridge`: 3D隆起的
    + `inset`: 3D嵌入的
    + `outset`: 3D突出的
    + `none`: 没有边框
    + `hidden`: The same as "none"

+ `outline-color` 用于设定四条边的轮廓颜色。颜色可以按照 CSS color 的 **name**, **RGB**, **HEX** 设定，也可以设为 **invert** 颜色反向 (To ensure the outline is visible, performs a color inversion of the background. Note that browsers are not required to support it. If not, they just consider the statement as invalid
 在 Mac Safari 和 Chrome 中测试，目前均不支持 **invert** 关键字)。
+ `outline-width` 用于设定四条边的轮廓的宽度。宽度可以用指定的尺寸（以 px，pt，cm，em 等为单位），或者使用三个预定义的值（thin, medium, or thick）
+ `outline-offset` 指定轮廓和边框之间的距离，默认值为 **0**.

**注意**: <span class="blue-text">同边框一样，除非先设定 **outline-style** 这个属性，否则任何 outline 性质（如：outline width、outline color...）都不会产生效果</span>。

### All in one 简写形式

可使用 _outline_ 属性一次性设定四条边轮廓的样式，如果有一个值没有设定，也是允许的。但应遵循的顺序如下：

+ outline-width 默认值: medium
+ outline-style (**required**)默认值: none
+ outline-color 默认值: invert
