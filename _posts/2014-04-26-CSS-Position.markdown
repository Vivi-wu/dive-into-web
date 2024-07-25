---
title:  "CSS Position"
category: CSS
---
## CSS Position

_position_ 属性指定了一个元素放置方法的类型，一共有四种取值：`static`，`relative`，`fixed`，`absolute`。

## Static Positioning

默认情况下，HTML 元素是被**静态放置**的，其位置属性值为 `static`。

HTML 元素总是<span class="t-blue">根据正常的页面流，从上到下，从左到右放置</span>。

静态放置的元素**不**受 _top_，_bottom_，_left_，_right_ 属性影响。

<!--more-->

## Relative Positioning

元素位置属性值为 `relative` 时，是相对于正常情况下/static定位时它应该在的位置放置。

relative 放置的元素在正常页面流里**本来占据的空间仍然有效**，即**没有**被从页面流里**剔除**，也不影响布局。

<div style="background-color:#FFF1F1;width:20rem;">Box 1 Normal positioning</div>
<div style="background-color:#bca590;width:20rem;">Box 2 Normal positioning</div>
<div style="position:relative;top:10px;left:10px;background-color:#FFF1F1;width:20rem;">Box 1 Relative positioning</div>
<div style="background-color:#bca590;margin-bottom:1rem;width:20rem;">Box 2 Normal positioning</div>

上例中设置 Box 1 为 relative 放置并分别设 _top_ 和 _left_ 为 10px，可以看到**相对放置的元素移动，并不影响其后元素的摆放**。

## Fixed Positioning

元素位置属性值为 `fixed` 时，是相对于 viewport 浏览器窗口放置。即使页面滚动，它也待在同样的位置。

fixed 放置的元素是固定在视窗最大可视范围上，<ins>如果不指定位置 (top, left, right, bottom) 时，元素会固定在原本的位置</ins>(持保留意见)；而指定位置后，就会以视窗最大可视范围的边界为绝对基准点。

固定位置的元素被从正常的页面流中**剔除**，文档和其他元素表现得就像这个固定位置的元素不存在一样。

## Absolute Positioning

元素位置属性值为 `absolute` 是相对于最近的位置属性值非 `static` 的祖先元素放置）. 如果不存在这样的祖先元素，it use the document body `<html>`.

绝对放置的元素随页面一起滚动。

### top, bottom, left, right 偏移量

元素可以使用上、下、左、右，四个方向的属性来定位，但必须先指定 position 这个性质（属性不是默认值 static）。

可取的值有：

+ `auto` 默认值
+ length，以 px，cm 等为单位，允许负值
+ %，以包裹元素的百分比，允许负值

方向属性根据 _position_ 的值，又有不同的工作方式：

+ 对于 relatiely-positioned 的元素，是根据它正常的位置，来上下左右调整元素。
+ 对于 absolutely positioned 的元素 (_position_ 取值为 `absolute` 或 `fixed`), top 属性表示该元素的上边界高于（取负值）或低于（取正值）其最近的**非静态放置**的祖先元素的上边界。

bottom、left、right 属性同理。

### Overlapping Element

当元素被从 normal flow 中删除，他们就可以覆盖其他元素。

_z-index_ 属性指定了元素的叠放顺序. 可取值为：

+ `auto` 默认值，叠放顺序同它的父元素
+ number，可正 positive 可负 negative。值越大的，放得越靠上面。

注意：

+ _z-index_ 只有设置在非 static 放置 (position 的值是 **anything except `static`**) 的元素上才起作用
+ 如果两个 positioned elements 重叠了，**都没有明确指定 _z-index_** 的值, <span class="t-blue">代码位于 HTML code后面的元素将显示在上面</span>。

## Clip

_clip_ 使我们可以用一个**矩形框**来剪切一个 absolutely positioned 的元素。

1. 被矩形框框住的区域被保留（visible）。
2. 从元素的左上角开始剪切。
3. 如果溢出设为可见（`overflow:visible`），这个属性就无效了。

可取值：

+ `auto` 默认值，No clipping will be applied.
+ shape 目前唯一的有效取值是矩形，**rect (top, right, bottom, left)**
