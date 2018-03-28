---
title:  "CSS Dimension and Box Model"
category: CSS
---
## CSS Dimension

CSS 的范围属性用来控制元素 content 区域的高和宽，**不包含**内边距、边框和外边距。

### Height & Width

基本的 _height_, _width_ 属性可取的值：

+ `auto`: **默认值**，浏览器来计算
+ length: 以 px, cm, 等为单位具体的值
+ %: 以**所包含的内容模块**的百分比显示

<!--more-->

### Max-height、Max-width、Min-height、Min-width

设定尺寸最大值用来解决的问题如：某元素设定了 _max-width_，当浏览器宽度大于它时，元素的宽度即为这个最大宽度，不会改变。而当浏览器宽度减小，直到小于元素最大宽度时，**元素将随着浏览器一起减小**（有 responsive 的效果）。

如果不设定最大宽度，则在浏览器窗口宽度小于元素宽度时，窗口出现横向 scrollbar。

_max-*_ 可取的值：

+ `none`: **默认值**，意思是默认没有最大宽度或高度
+ length: 以 px, cm, 等为单位具体的值
+ %: in percent of the containing block

**注意**: <span class="t-blue">_max-height/width_ 属性的值覆盖 _height/width_ 所设定的值</span>。

设定尺寸最小值用来保证视图范围小的情况下，内容依然可读。

_min-*_ 可取的值：

+ length: 默认值为 **0**，以 px, cm, 等为单位具体的值
+ %

**注意**: <span class="t-blue">_min-height/width_ 属性的值覆盖 _max-height/width_ 属性和 _height/width_ 所设定的值</span>。

## CSS Box Model

所有 HTML 元素可以被认为是一些盒子。在 CSS 中，当讨论设计和布局时，会用到 box model 盒模型。

The CSS box model consists of: **margins**, **borders**, **padding**, and the actual **content**.

正如上面所写到的，当我们用 CSS 设定元素的宽和高时，只是设定了 the width and height of the **content area**. 因此<span class="t-red">在计算元素完整的尺寸时，要加上内边距、边框和外边距</span>。

在 IE 早期浏览器中如果 `!DOCTYPE` 文档声明没有指定 standards-compliant 模式渲染，则 _width_ 宽高属性除了包含 content box 还加上左右 padding 和左右 border。

### CSS Margins

_margin_ 属性用来设定元素边框外边空白区域（**outside** the border）的大小。

**注意**：<span class="t-blue">外边距是完全**透明的**，没有 background color</span>。

_margin_ 属性实际上是 _margin-top_, _margin-right_, _margin-bottom_, _margin-left_ 四个属性的 all in one 缩写形式。设定方式同 border。

可以取值类型：

+ `auto`，浏览器来计算外边距。
+ length，以 px，pt，cm 等为单位来指定，默认值是**0**
+ %，基于所包含**元素的宽度**的百分比
+ inherit

外边距可以取<span class="t-red">负值</span>，因为两个元素可以重叠 overlap。

### CSS Paddings

_padding_ 属性用来设定元素的内容和元素的边框之间空白区域（**inside** the border）的大小。

**注意**：<span class="t-blue">内边距受到元素的 background color 影响</span>。

_padding_ 属性实际上是 _padding-top_, _padding-right_, _padding-bottom_, _padding-left_ 四个属性的 all in one 缩写形式。设定方式同 border。

可以取值类型：

+ length，以 px，pt，cm 等为单位来指定，默认值是**0**
+ %，基于所包含**元素的宽度**的百分比
+ inherit

## CSS3 Box Sizing

上面提到 CSS 设定元素的宽和高，只是限定了实际内容区域的大小，是针对默认情况。CSS3 引入 _box-sizing_ 属性，因此再讲宽高就要看情况了。

该属性**默认值**是 `content-box`，也就是上面提到的一般情况。

如果设定元素的 `box-sizing: border-box;` ，那么 <span class="t-blue">CSS 宽、高 属性值相同的两个元素，即使其中一个含内边距、边框，它们看起来也是一样大小</span>。

新属性的引入是解决：虽然我们用 CSS 指定了元素的 _width_, _height_ 属性，但如果元素还设有内边距和边框，最终看到的元素看起来比预想的要大。长久以来，为了让元素满足设计尺寸，不得不减小 CSS _width_, _height_ 的值。

通过 DOM Element 查看，两个元素**有无内边距、边框**得到了**完全一样的值**：

    element.offsetWidth = width + padding + border + (scrollbar)
    element.clientWidth = width + padding

那么它们有区别吗？通过浏览器开发工具 Computed 和模型图可以看到，含内边距和边框的元素，它的内容区域宽要小得多。

因为 _box-sizing_ 属性使得设置元素尺寸更加 intuitive 直觉性，许多浏览器已经使用 `box-sizing: border-box;` 在许多表单元素上。（除了 `<input>`, `<textarea>`）

## CSS Outline

_outline_ 用来设定元素的轮廓——围绕元素所画的线，**outside the border**。

**注意**: <span class="t-blue">轮廓**不是**元素的一部分，因此，outline 的宽度不会影响到元素的宽和高</span>。

+ _outline-style_ 指定要显示什么类型的轮廓。

    可能的取值:

    + `dotted`: 小方块（像素点）连成的
    + `dashed`: 虚线的（比 dotted 长）
    + `solid`: 实线边框
    + `double`: 双实线边框，<span class="t-red">边框之间的距离等于 _border-width_ 边框宽度的值</span>
    + `groove`: 3D纹理（槽）边框
    + `ridge`: 3D隆起的
    + `inset`: 3D嵌入的
    + `outset`: 3D突出的
    + `none`: 没有边框
    + `hidden`: 效果同 "none"

+ _outline-color_ 设定四条边的轮廓颜色。颜色可以按照 CSS color 的 **name**, **RGB**, **HEX** 设定，也可以设为 **invert** 颜色反向 (To ensure the outline is visible, performs a color inversion of the background. Note that browsers are not required to support it. If not, they just consider the statement as invalid
 在 Mac Safari 和 Chrome 中测试，目前均不支持 **invert** 关键字)。
+ _outline-width_ 设定四条边的轮廓的宽度。宽度可以用指定的尺寸（以 px，pt，cm，em 等为单位），或者使用三个预定义的值（`thin`, `medium`, 或 `thick`）
+ _outline-offset_ 指定轮廓和边框之间的距离，默认值为 **0**.

**注意**: <span class="t-blue">同边框一样，除非先设定 **outline-style** 这个属性，否则任何 outline 性质（如：outline width、outline color...）都不会产生效果</span>。

### All in one 简写形式

使用 _outline_ 属性一次性设定四条边轮廓的样式，下面列出每项的默认值。如果有值没有设定，也是允许的。但应遵循的顺序如下：

+ outline-width: `medium`
+ outline-style (**required**): `none`
+ outline-color: `invert`
