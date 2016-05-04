---
title:  "CSS Position"
category: CSS
---
CSS _position_ 属性指定了一个元素的放置方法的类型，一共有四种取值：static，relative，fixed，absolute。

### Static Positioning

默认情况下，HTML 元素是被**静态放置**的，其位置属性值为 `static`。

HTML 元素总是<span class="blue-text">根据正常的页面流，从上到下，从左到右放置</span>。

静态放置的元素**不**受 _top_，_bottom_，_left_，_right_ 属性影响。

<!--more-->

### Relative Positioning

元素位置属性值为 `relative` 时，是 <span class="blue-text">relative to its normal position</span> 相对于正常情况下，它应该在的位置放置。

其他元素并不会自动调整，去填充这个元素移动所产生的空白。<span class="blue-text">Other content will not be adjusted to fit into any gap left by the element</span>.

<span class="blue-text">the reserved space for the element is still preserved in the normal flow</span>. 相对放置的元素可以被移动并覆盖住其他元素，但是它在正常页面流里本来占据的空间仍然有效（**没有**被从页面流里**剔除**）。

Tips：<span class="blue-text">Relatively positioned elements are often used as Container blocks for absolutely positioned elements</span>.

### Fixed Positioning

元素位置属性值为 `fixed` 时，是 <span class="blue-text">relative to the viewport</span> 相对于视图浏览器窗口放置的。即使页面滚动，它也待在同样的位置。

拥有固定位置的元素是固定在萤幕视窗最大可视范围上，如果不指定位置 (top, left, right, bottom) 时，元素会固定在原本的位置；而指定位置后，就会以萤幕视窗最大可视范围的边界为绝对基准点。

Fixed positioned elements are removed from the normal flow. 固定位置的元素被从正常的页面流中**剔除**，文档和其他元素表现得就像这个固定位置的元素不存在一样。

### Absolute Positioning

元素位置属性值为 `absolute` 是 <span class="blue-text">relative to the nearest positioned ancestor</span>（相对于最近的，位置属性值非 static 的祖先元素放置）. If no such element is found, it use the document body `<html>`.

绝对放置的元素随页面一起滚动。

### top, bottom, left, right

Elements can be positioned using the top, bottom, left, and right properties. However, these properties will **not work unless** the position property is set first (as absolute, relative, or fixed, **anything except `static`**).
元素可以使用上、下、左、右，四个方向的属性来定位，但必须先指定 position 这个性质（即，如果元素的位置属性还是默认值 static，否则这四个方向性质不会有任何效果）。

可取的值有：

+ auto 默认值
+ length，以 px，cm 等为单位，允许负值
+ %，以包裹元素的百分比，允许负值

方向属性根据 position 的值，又有不同的工作方式：

+ 对于 relatiely-positioned 的元素，是根据它正常的位置，来上下左右调整元素。
+ 对于 absolutely positioned elements (those with position: `absolute` or position : `fixed`), CSS _top_ sets the top edge of an element to a unit above/below the top edge of its nearest positioned ancestor. 对于绝对放置的元素， top 性质表示该元素的上边界，与其最近的非静态放置的祖先元素的上边界之间的距离。这里仅举个例子，bottom、left、right 属性同理。

### Overlapping Element

When elements are positioned outside the normal flow, they can overlap other elements. 当元素被从 normal flow 中删除，他们就可以覆盖其他元素。

_z-index_ 属性指定了 stack order of an element 元素的叠放顺序 (which element should be placed in front of, or behind, the others). 可取值为：

+ `auto` 默认值，叠放顺序同它的父元素
+ number，可正 positive 可负 negative。值越大的，放得越靠上面。

注意：

+ z-index **only** works on positioned elements (position as absolute, relative, or fixed, **anything except `static`**)
+ 如果两个 positioned elements 重叠了，都没有明确指定 _z-index_ 的值, the element **positioned last** in the HTML code will be **shown on top**. 代码位于 HTML 文件后面的元素将显示在上面。

### Clip

_clip_ 属性使我们可以用一个矩形框，来剪切一个 absolutely positioned 的元素。

1. 被矩形框框住的区域被保留（visible）。
2. 从元素的左上角开始剪切。
3. 如果溢出设为可见，这个属性就无效了。 **not work** if `overflow:visible`.

可取值：

+ `auto` 默认值，No clipping will be applied.
+ shape 唯一的有效取值是矩形，**rect (top, right, bottom, left)**

### Overflow

_overflow_ 属性定义了如果内容超出了一个元素的盒模型将会发生什么。

取值：

+ `visible` 默认值，It renders outside the element's box. 会无视元素的边界限定，把内容全部显示出来。
+ `hidden` 超出部分被剪切掉，the rest of the content will be invisible
+ `scroll` 超出部分被剪切掉，但是会添加一个滚动条用于查看 the rest of the content
+ `auto` 如果有超出边界的内容，添加 scroll-bar to see the rest of the content

<span class="blue-text">The default value for the `<body>` element is auto</span>.

_overflow-x_ 属性定义了如果内容超出了一个元素的盒模型，内容的 left/right 边会怎么处理。取值同 _overflow_ .

_overflow-y_ 属性定义了如果内容超出了一个元素的盒模型，内容的 top/bottom 边会怎么处理。取值同 _overflow_ .

### Cursor 指针

_cursor_ 属性用来指定当鼠标指向一个元素时，光标显示的类型。

默认值为 `auto`，效果同 `text`，可以选择文本的样式。常用的有 `default`（默认鼠标箭头指针），`help`（问号），`pointer`（手势指针），`progress`（效果同 `wait`）
