---
title:  "CSS Colors and Backgrounds"
category: CSS
---
## CSS Colors

CSS 颜色可以有三种基本表示方法：

1. _Predefined Color names_，所有现代浏览器都支持至少 140 种颜色名称表示的 CSS 颜色。Color name 是**大小写不敏感**的.

    常见的 17 种标准颜色有: aqua 水绿色, black, blue, fuchsia 紫红色, gray, green, lime 绿黄色, maroon 褐红色/栗色, navy 藏青色, olive 黄褐色/橄榄色, orange, purple, red, silver, teal 青色, white, and yellow

2. _RGB(Red, Green, Blue)_，三原色配色表示法: rgb(255,0,0)，rgb(0,255,0)，rgb(0,0,255)。颜色密度取值在 0 和 255之间。

3. _Hexadecimal Colors_ 十六进制表示法，语法 `#RRGGBB` 或者 `#RGB`。十六进制取值在 00 和 FF 之间。例如：<span style="color:red;">#ff0000</span>，<span style="color:green;">#00ff00</span>，<span style="color:blue;">#0000ff</span>。HEX 值是**大小写不敏感**的，`#ff0000` 和 `#FF0000` 是相同的.

<!--more-->

### CSS3 新增 Colors

1. _RGBA_ colors: **rgba(red, green, blue, alpha)**. 新增的最后一个参数表示透明度。The alpha parameter is a number between **0.0** (fully transparent 完全透明) and **1.0** (fully opaque 完全不透明)

2. _HSL_ colors: **hsl(hue 色调, saturation 饱和度, lightness 亮度)**。前者取值在 **0-360** 之间（0 或 360 是 red，120 是 green，240 是blue），后两者按百分比取值，其中饱和度取 100% 表示 full color，最后一个亮度取 0% 是 black，取 100% 是 white

3. _HSLA_ colors: 在 HSL 基础上添加了一个 alpha 透明度参数，用法同 RGBA。

4. _opacity_，CSS3 透明度属性用来设置 rgb 颜色的透明度，取值在 0.0 和 1.0 之间。

## CSS Backgrounds

CSS 背景属性用来定义元素的背景效果。

注意: The background of an element is the total size of the element, including **padding** and **border** (but **not** the **margin**). 一个**元素的背景指的是除了外边距之外元素完整的大小，包含内边距和边框**。

+ _background-color_，设定元素背景色。属性值参考 CSS color 的取值。
+ _background-image_，给一个元素指定一张图片作为背景。默认情况下，<span class="blue-text">图片被放置在一个元素的 **左上角**，同时沿水平方向和垂直方向重复摆放，以覆盖住整个元素</span>。

    Tip: <span class="blue-text">Always set a background-color to be used if the image is unavailable</span>.

+ _background-repeat_，有时背景图只需要在水平方向（`repeat-x`）或 垂直方向（`repeat-y`）重复。有时只需显示一次，不需要重复（`no-repeat`）
+ _background-position_，该属性用来设置背景图片的位置。

<table>
  <tr>
    <th style="width:8em;">取值</th><th>描述</th>
  </tr>
  <tr>
    <td>left top<br>left center<br>left bottom<br>right top<br>right center<br>right bottom<br>
    center top<br>center center<br>center bottom<br>
    </td>
    <td>如果只设定了一个关键字，则另一个取值将是 <b>center</b></td>
  </tr>
  <tr>
    <td>x% y%</td><td>前者是水平位置，后者是垂直位置。默认值是左上角<b>0% 0%</b>，右下角是<b>100% 100%</b>。如果只设定了一个值，另一个值将是<b>50%</b></td>
  </tr>
  <tr>
    <td>xpos ypos</td><td>左上角是<b>0 0</b>，其他非零取值要使用 CSS units。<span class="blue-text">如果只设定一个值，另一个值将为50%。可以混合 ％ 和 带有 CSS 单位的 position 取值</span></td>
  </tr>
  <tr><td>initial</td><td>设为默认值</td></tr>
  <tr><td>inherit</td><td>继承父元素的取值</td></tr>
</table>
+ _background-attachemnt_，该性质指定了一张背景图片是否位置固定，还是与页面剩余部分一起滚动。

    默认值是 `scroll`，即背景图默认跟着它的元素相对于 main view 一起滚动，但是**背景图相对于元素内容是不动的**。
    如果设为 `fixed`，则会相对于 viewport（main view） 和 元素内容（local view）都是固定的。
    而当取值 `local`，背景图会随元素相对于 main view 一起滚动，**同时相对于元素内容（local view）也可以一起滚动**。

### All in one 简写形式

使用 `background` 属性，将以上属性简写进一个性质里：

+ background-color
+ background-image
+ background-repeat
+ background-attachment
+ background-position

如果其中之一没有指定也没有关系，**重要的是按照这个顺序写**。

## CSS3 Background 新属性

首先，CSS3 允许使用 _background-image_ 给一个元素添加多个背景图，使用逗号分隔开每张背景图的参数设置。

    #example1 {
      background-image: url(img_flwr.gif), url(paper.gif);
      background-position: right bottom, left top;
      background-repeat: no-repeat, repeat;
    }

上面的写法也可以简写到一个 `background` 属性里。

    #example1 {
      background: url(img_flwr.gif) right bottom no-repeat, url(paper.gif) left top repeat;
    }

+ _background-size_，该属性用来指定背景图的尺寸。在 CSS3 之前，背景图片的大小就是图片的实际大小，现在，我们可以在不同环境里重复使用背景图。这个属性同样接受以逗号分隔的多个值，即支持多图背景。

<table>
  <tr>
    <th style="width:10em;">取值</th><th>描述</th>
  </tr>
  <tr>
    <td>auto</td><td>默认值。背景图尺寸就是图片实际大小</td>
  </tr>
  <tr>
    <td>xlength ylength</td><td>以px为单位设置图片宽高，如果只设定一个值，另一个将设为<b>auto</b></td>
  </tr>
  <tr>
    <td>x% y%</td><td>以父元素对百分比设定背景图的宽高，如果只设定一个值，另一个将为<b>auto</b>.如果取值为<span style="color: red;">100% 100%</span>图片的宽和高会拉伸以完全覆盖住内容区域，属于<span style="color: red;">非等比放大</span>。</td>
  </tr>
  <tr>
    <td>cover</td><td>尽可能缩放背景图，以完全覆盖住内容区域。注意：<span class="blue-text">背景图的 width 或 height 达到其所在元素宽度的 100%</span>，保持宽高比，属于<span style="color: red;">等比放大</span>，图片部分区域可能因此 invisible。</td>
  </tr>
  <tr>
    <td>contain</td><td>缩放背景图，<span class="blue-text">使其宽和高分别顶住所在元素的边缘</span>，尽力去填满内容区域(通常填不满)。保持宽高比，属于<span style="color: red;">等比放大</span>。</td>
  </tr>
</table>

+ _background-origin_，指定背景图片的 _background-position_ 应该相对于谁来放置。该性质的三个取值是：`border-box`: 背景图从边框的左上角开始，`padding-box`（**默认值**）: 此为默认值，背景图从内边距的边缘左上角开始，`content-box`: 背景图从内容区域左上角开始。
+ _background-clip_，指定背景上色的区域。取值种类同 _background-origin_。但**默认值**是 `border-box`。
