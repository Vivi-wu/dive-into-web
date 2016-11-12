---
title:  "CSS 实现步骤进度条"
category: CSS
---
问题描述：实践中经常会使用带方向箭头式的“步骤进度条”来提示用户某个操作的完整流程，以及用户当前所处环节。最简单的办法是让视觉出条形图，因为要高亮当前步骤，有几个步骤，就需要出几张图。这样在流程更新时就需要重做所有条形图。视觉会抱怨说没时间也很麻烦。

之所以让视觉出图，因为各种原因开发无法实现非直角三角形。按照**样式的问题就交给 CSS**，今天我尝试用 CSS 来实现带非直角三角形箭头的步骤进度条。

关键：了解 CSS 边框的绘制原理。

参看 demo 里的粉色矩形，当边框 border 调到很粗的时候，每条边的边框会出现三角形的基本轮廓。

因此我们可以通过设置元素宽、高为 0，边框样式为 solid，上边框设置一定的宽度和颜色，左右两边设为同尺寸透明边框，绘制出非直角三角形。

借助 CSS transform 属性来旋转三角形。然后给每一步的 `:before` 伪元素添加与进度条边框同色的三角形，在默认情况下和高亮时分别给 `:after` 伪元素添加不同颜色的三角形。

之所以把代表默认情况和高亮的三角形写在 `:after` 里，如 CSS Position 章节所写，当两个 positioned 元素重叠，都没有明确指定 _z-index_ 的值, the element **positioned last** in the HTML code will be **shown on top**. 在 HTML 代码中书写靠后的元素将显示在上面。（打开浏览器调试工具查看 Element，可以发现 `:after` 伪元素在 `:before` 伪元素下面）。

下面是一个简单的三步操作进度条 demo。可通过点击“下一步”和“上一步”在流程中依次前进或后退。

<p data-height="400" data-theme-id="0" data-slug-hash="GNoXNR" data-default-tab="css,result" data-user="VivienneWU" data-embed-version="2" data-pen-title="CSS progress bar" class="codepen">See the Pen <a href="http://codepen.io/VivienneWU/pen/GNoXNR/">CSS progress bar</a> by Vivienne (<a href="http://codepen.io/VivienneWU">@VivienneWU</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>
