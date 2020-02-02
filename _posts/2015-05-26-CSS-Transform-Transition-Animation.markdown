---
title:  "CSS Transform, Transition and Animation"
category: CSS
---
## CSS Transforms

_transform_ 属性通过以下的方法让元素实现：移动、旋转、放大和变形。

### 2D transform 方法

+ `translate(n[, n])` **移动**，根据给定的参数把元素从当前位置移动到 n 决定的位置。一个参数表示沿 x 、y 轴移动相同的距离；若含两个参数，前者表示向左 (X-axis ) 后者表示向上 (Y-axis)
+ `scale(number[, number])` **缩放**: 根据给定的参数放大或缩小元素的尺寸。一个参数表示宽高同时缩放相同倍数；若有两个参数，第一个表示 width(X-axis) 第二个表示 height (Y-axis)
+ `rotate(angle)` **旋转**，以给定的角度沿顺时针方向旋转. **Negative values** 表示逆时针方向选择
+ `skew(angle[, angle])` **扭曲**，以给定的角度歪斜。一个参数表示沿 x 、y 轴移歪斜相同角度；若含两个参数，前者表示水平方向 (X-axis ) 后者表示垂直方向 (Y-axis)
+ `matrix(n, n, n, n, n, n)` **矩阵变化**: 把所有的 2D 变换组合到一个函数里, 具体使用方法参看<a href="https://dev.opera.com/articles/understanding-the-css-transforms-matrix/" target="_blank">这里</a>。

<!--more-->

同时提供 translateX(n), translateY(n), scaleX(n), scaleY(n), skewX(angle), skewY(angle) 方法。

### 3D transform 方法

+ `rotateX(x)` 沿 X 轴水平旋转
+ `rotateY(y)` 沿 Y 轴垂直旋转
+ `rotateZ(z)`

以上三个方法 all in one 简写形式为 `rotate3d(x, y, z)`，同样还有 `translate3d(x, y ,z)`，`scale3d(x, y, z)`，以及把所有 3D 变换组合到一个函数里的 `matrix3d()`（使用4×4的矩阵，共需16个值）。

### transform-origin

_transform-origin_ 用来修改元素变形的原点位置。可取的值从左到右分别表示 x、y、z轴，默认值为 (50% 50% 0)。

+ x-offset，值为 length 或 `%`，表示设定变形的原点距离盒子的**左边**有多远。
+ y-offset，值为 length 或 `%`，表示设定变形的原点距离盒子的**上边**有多远。
+ z-offset，值为 length（**不能**用百分比表示，否则状态无效），表示设定变形的原点距离用户垂直视线有多远。

也可以使用关键字来描述变形的偏移量：

+ x-offset-keyword，取值为 `left`（0%）, `right`（100%）或者 `center`（50%）。
+ y-offset-keyword，取值为 `top`（0%）, `bottom`（100%）或者 `center`（50%）。

## CSS Transitions

_transition_ 属性使我们能够在给定的时间段里平滑地改变属性值。

注意：<span class="t-blue">transition 写在元素的默认状态里</span>。

为实现特效（过渡）, **必须至少指定**:

+ _transition-property_，你想要添加特效的 CSS 属性。
+ _transition-duration_，特效持续的时间。**默认值**为 0。因此<span class="t-red">不明确设定持续时间，transition 没有效果</span>。

其他可操作的属性还有：

+ _transition-timing-function_，**默认**是 `ease`（slow start， then fast then slowly end）。
+ _transition-delay_，设置特效实际开始前需要等待的时间。

以上四个属性的 all in one 简写形式为

    transition: <property> <duration> <timing-function> <delay>;

### 同时设置多个属性的 transition

以逗号分隔开。

    transition: width 2s, height 4s;。

## CSS Animations

要使用 CSS3 _animation_，必须先为动画指定一些 keyframes，即关键帧时元素的状态。

<span class="t-red">`@keyframes` 要在使用它之前就定义好</span>（指代码位置）。

然后至少要指定以下两个性质:

+ _animation-name_ 动画名称（即定义的 `@keyframes` rule 的名字）
+ _animation-duration_ 动画持续时间

关键帧可以用 `%` 表示，也可以用关键字 "from" 和 "to" (前者表示 0% 动画开始，后者表示 100% 动画完成)。

例如：

```css
@keyframes example {
    0%   {background-color: red; left:0px; top:0px;}
    25%  {background-color: yellow; left:200px; top:0px;}
    50%  {background-color: blue; left:200px; top:200px;}
    75%  {background-color: green; left:0px; top:200px;}
    100% {background-color: red; left:0px; top:0px;}
}
div {
    width: 100px;
    height: 100px;
    position: relative;
    background-color: red;
    animation-name: example;
    animation-duration: 4s;
}
```

除了上面提到的两个性质，还包括：

+ _animation-timing-function_（**默认值**是 ease）
+ _animation-delay_（**默认值**是 0s）
+ _animation-iteration-count_ （设定动画播放次数，可以是 integer 数字或关键字 infinite，**默认值**是 1）
+ _animation-direction_（**默认值**是 normal）
+ _animation-fill-mode_ 指定当动画结束或有 delay 时给元素应用的一些样式，可以取值：

    + `none` **默认值**
    + `forwards`，tells the browser to stop the animation on the last keyframe at the end of the last iteration and not revert back to its pre-animation state
    + `backwards`，makes the element Go directly to keyframe 0% when the page loads, even if there is an animation-delay, staying there until the animation starts
    + `both`，applies both backwards and forwards, sitting on the first keyframe until the animation begins (no matter the length of the positive animation delay) and staying on the last keyframe at the end of the last animation

+ _animation-play-state_（**默认值**是 running) 设定当前动画是运行还是暂停。

所有性质的 all in one 简写形式是 _animation_ 。
