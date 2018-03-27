---
title:  "HTML Canvas"
category: HTML
---

## Canvas API

1. 用 Canvas 绘制出的对象不属于页面 DOM 结构或者任何命名空间

2. 写在 Canvas 开闭标签之间的内容会作为替代内容，在浏览器不支持 Canvas 的时候显示出来，除了文本，还可以使用图片。

3. 可以使用 CSS 为 Canvas 元素添加边框、设置内边距及外边距。一些 CSS 属性可以被 Canvas 内的元素继承。为 Canvas 上下文设置属性要遵循 CSS 语法。

4. 使用 Canvas 编程，首先调用 canvas 对象的 `getContext()` 方法，传入希望使用的 canvas 类型。如传入 _2d_，获取一个二维上下文。如果希望在支持 WebGL 的浏览器中创建 3D 绘图上下文，则使用关键字 _webgl_。

5. canvas 中所有的操作都是通过 context 对象来完成的。所有涉及视觉输出效果的功能都只能通过 context 对象而不是画布对象来使用。

<!--more-->

6. 很多对上下文的操作不会立刻反映到页面上，如 `beginPath`、`moveTo`、`lineTo`，只有对路径应用绘制 `stroke` 或填充 `fill` 方法时，结果才会显示出来。

7. 关于可重用代码一条重要建议：一般绘制都应从原点（坐标系的 0,0 点）开始，应用变换（缩放、平移、旋转等）

    基本步骤：首先，保存当前绘图状态 `context.save()`，然后根据需要移动绘图上下文 `context.translate(x, y)`，接着以原点为起点进行绘制等操作，最后，恢复原有绘图状态 `context.restore()`。

8. 绘制线条常见函数：

    + beginPath()，不论绘制何种图形，这是第一个调用到函数，通知 canvas 要开始绘制新图形了，canvas 以此来计算图形的内部和外部范围，以便完成后续的描边和填充
    + moveTo(x, y)，将当前位置移动到新的目标坐标(x, y)，不绘制
    + lineTo(x, y)，将当前位置移动到新的目标坐标(x, y)，并且在两个坐标之间画一条直线
    + closePath()，该函数行为同lineTo，不过是以路径的起始坐标为目标坐标。

9. context 属性 _lineJoin_，用来修改当前形状中线段的连接方式，如设为 `round`，让拐角变得更圆滑。属性 _lineCap_ 可以来指定线段末端的样式。

10. context 的 `fill()` 函数可以让 canvas 对当前图形中所有的闭合路径内部的像素点进行填充。

11. 描边与填充，如设路径宽度为4px，这个宽度是**沿路径线居中对齐**的。填充则是把路径轮廓内部所有像素全部填充，因此**会覆盖描边路径的一半**。如果希望看到完整的描边路径，可以先填充 `fill()` 后描边 `stroke()`。

    + `strokeRect()` 作用是基于给出的位置和坐标画出矩形的轮廓。
    + `fillRect()` 就是填充矩形区域。
    + `clearRect()` 作用是清除矩形区域内所有的内容并将它恢复到初始状态，即透明色。

12. 如何绘制曲线：先使用 `moveTo(x, y)` 函数设置起点，然后使用比如 `quadraticCurveTo(x1, y1, x2, y2)` 之类的函数，第一组代表控制点 control point（调整控制点的位置，可以改变曲线的曲率），第二组是曲线的终点（类似还有 `bezierCurveTo`、`arcTo` 等）通过多种控制点（如半径、角度等）让曲线更具可塑性。

13. 在 canvas 中加入图片，必须等图片完全加载后才可以对其操作，因此**对图片的操作需写在图片对象的 onload 函数里**。

14. context 的画图函数 `drawImage()`，使用前查一下它的所有参数，根据实际需要来设定。

15. 使用渐变三个步骤：

    1.创建渐变对象，如线性渐变，`createLinearGradient(x1, y1, x2, y2)`，设置起点和终点。放射性渐变，`createRadialGradient(x0, y0, r0, x1, y1, r1)`，渐变会在两个圆中间的区域出现为渐变对象设置颜色，指明过渡方式。
    2.在渐变对象上使用 `addColorStop(偏移量，颜色)` 函数。偏移量是一个 _0.0_ 到 _1.0_ 之间的数值，代表沿着渐变线渐变的距离有多远
    3.在 context 上为填充样式或描边样式设置渐变

16. 在描边和填充的时候，还可以使用 `createPattern(image，‘repeat’)`函数实现图片平铺。将该函数返回值赋给 `strokeStyle` 或 `fillStyle` 属性。

17. 特别需要注意的是，缩放（scale）和旋转（rotate）等变换操作都是**针对原点**进行的。如果对一个不在原点的图形进行旋转变换，那么 rotate 变换函数会将图形绕着原点旋转，而不是原地旋转。类似的，如果进行缩放操作时，没有将图形放在合适的坐标上（通常先 save 上下文，然后 translate 原点坐标到何时的位置），那么所有路径的坐标都会被同时缩放，新的坐标可能会全部超出canvas范围。

18. 文本绘制由两个函数 `fillText(text, x, y, maxwidth)` 和 `strokeText(text, x, y, maxwidth)`，（x，y）是第一个字左上角顶点的坐标，最后一个参数是可选的，用来限制字体大小，将文本强制收缩到指定尺寸。设定maxwidth参数以后，可以指定文本的对齐方式，通过上下文 _textAlign_ 属性，如居中对齐 center.

19. 此外 context 还有 `measureText()` 函数，度量指定文本的实际显示宽度。

20. Canvas API 允许开发人员直接访问 canvas 底层像素数据，一方面以数值数组形式获取像素数据，另一方面可以修改数组的值以将其应用于 canvas 上。

    + `getImageData(x，y，width，height)`，返回被x、y、width和height四个参数框定的矩形区域内的canvas上的像素。返回对象包含三个属性，每行、列有多少个像素，一个一维数组，存有获取的每个像素的RGBA值。
    + `putImageData(imagedata, dx, dy)`，通过数学方式修改数组中的像素值，然后使用此函数来更新canvas上的显示
    + `createImageData(sw, sy)`，创建一组图像数据并绑定在canvas对象上

21. `canvas.toDaraUrl()` 能够通过编程来获取canvas上当前呈现的数据，以文本格式存在，这种格式是一种标准的数据表示方法，浏览器能将其解析成图像。

    将 canvas 的内容转为 dataURL 格式以后，可以作为页面中 image 元素的源，(img.src = canvasDataURL)，或者用在 CSS 样式中。

22. 因为可以直接操纵像素数据，为了安全考虑，origin-clean canvas 概念应运而生。如果 canvas 中的图片并非来自包含它的页面所在的域，页面中的脚本将不能取得其中的数据。`getImageData` 函数被调用的时候，如果 canvas 中的图像来自其他域，就会抛出安全异常。只要不获取显示着其他域中图片的 canvas 的数据，可以显示远程图片。

23. 许多浏览器提供 requestAnimationFrame 函数来替代经典的 setTimeout和setInterval 来实现页面更新（这两个函数即便页面在后台运行，仍然会持续更新，这样在用户看不到页面的情况下运行脚本，会让用户觉得你的web应用非常浪费手机电量）。requestAnimationFrame 函数以一个回调函数为参数，由浏览器决定以何种频度调用动画帧。在后台运行的页面，其调用度会降低，浏览器可能会剪掉对提供给 requestAnimationFrame 函数调用的元素的渲染，以优化绘图资源。

注意：如果你的图像显示**需要显著的交互行为**，可以考虑使用 SVG 代替。
