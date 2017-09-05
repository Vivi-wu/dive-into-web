---
title:  "用动作创造可用性"
category: Other
---
主要讲动作在 UI 交互中的应用。

原文[CREATING USABILITY WITH MOTION](https://medium.com/ux-in-motion/creating-usability-with-motion-the-ux-in-motion-manifesto-a87a4584ddc)

## 实时 vs. 非实时交互

在 UX 中的 state，即状态，是静止的。行为 act 是临时的，基于动作 motion 的。

“实时”意味着用户是直接与用户界面中的对象进行互动，被认为是“直接操作”；“非实时”则意味着对象的表现发生在用户的动作之后，是过渡性的，其影响是“锁定”了用户直到过渡结束。

<!--more-->

## 动作支持可用性

分四方面：

1. Expectation：减小用户期待的（用户观察到的事物的样子）和他们所体验到的（事物是如何表现的）差距。
2. Continuity：保持用户体验的“一致性”——一系列的场景组成了完整的用户体验
3. Narrative：叙述性的，在用户体验中一系列不引人注意的时间、事件联系在一起
4. Relationship：界面事物之间空间的、临时性的和层级关系的表现引导用户理解和做出决定

## 12个 UX 动作概念

<table>
  <thead>
    <tr>
      <th>Timing</th>
      <th>Object Relationship</th>
      <th>Object Continuity</th>
      <th>Temporal Hierarchy</th>
      <th>Spatial Continuity</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Easing（当临时事件发生时，事物表现与用户期待一致）在合适的放松的动作中，用户体验到的动作本身是“持续的”、“不可见的”（即 non-distracting）</td>
      <td>Parenting（当与多个事物交互时，创建空间的、临时性的层级关系，把一个事物的属性与另一个事物的属性连接）</td>
      <td>Transformation（当对象的用途改变时，创造一系列不间断的变化，让用户经过不同的UX状态。变形是最可辨识的）</td>
      <td>Parallax（视差，当用户滚动页面时，在视觉平面内创建空间层次结构。表现为界面上不同object以不同速率移动。在发生视差事件期间，背景元素的可感知性减弱，用户的注意力被集中到主要操作和内容上）</td>
      <td>Obscuration（字面意思为障碍、混浊。与Masking相似，Obscuration既是静态又是临时的现象。当一个object出现在视野中，其下面的东西被蒙上透明遮罩变得模糊不清）</td>
    </tr>
    <tr>
      <td>Offset &#38; Delay（当引进新元素和场景时，定义事物的关系和层级。通常用来表现一些事物是separate）</td>
      <td></td>
      <td>Value Change（当数字、文本的值改变时，营造一种动态、连续、叙述性的关系。数字和值代表了在现实中发生的事情，可以是时间、收入、游戏得分、健康曲线等。当用户意识到数据动态性的本质，结果是不仅注意到了数值，还激发了主动性）</td>
      <td></td>
      <td>Dimensionality（维度，提供了一种有效的方法来克服视觉平面的层次悖论：同一平面上的objects缺乏深度，而object出现在其他objects的前面或后面）</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>Masking（蒙版，当功能由object的一部分的显示或隐藏来决定时，在对象的内部创造连续性。可以认为是object的形状和它的用途之间的关系。看起来改变了object，实际上其内容没有改变）</td>
      <td></td>
      <td>Dolly &#38; Zoom（Dolly是一个电影术语，指的是镜头向物体拉近，近景拍摄，或物体远离镜头移动，长镜头拍摄；Zoom指的是物体本身缩放，代替视角、物体的空间移动，实现相同效果）</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>Overlay（覆盖，当分层的对象位置相关时，利用平面排序属性在非3D空间里，描述一个object是在其他对象的前面还是后面）</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>Cloning（当新的object从当前场景的hero对象中被创建时，叙事性地阐述它的出现。由于此时用户的注意力被集中在这些hero object上，可以传递出清晰明确的事件关系链：动作X产生的结果是Y（创建新的子对象））</td>
      <td></td>
      <td></td>
    </tr>
  </tbody>
</table>

### 反例

1. Linear motion在视觉上很明显，感觉上“没有完成”，“震惊的”和“干扰的”
2. timing 函数太慢或太快
3. easing 函数与品牌和整体体验不一致
4. 一组本来功能各不相同的 icons 以相同的速度和角度进入视图，结果就是，它们看起来像 a single object

### 建议

1. when to use easing? Always.
2. Parenting 功能最好是“实时”的交互。通常是用户直接操作界面上的事物，通过动作告诉用户事物是怎样联系的，它们之间的关系是怎样的
3. 比如一个submit按钮，从矩形变成一个圆环型的进度条，最后又变成一个明显的确认标记的按钮。它吸引了我们的注意力，tells a story 然后结束
4. 数值改变可以是实时的（用户和对象交互时改变），也可以是非实时的（比如loader和过渡，不需要用户输入）
5. 应用视差时，前景对象移动速率“较快”，看起来离用户更近，背景对象移动速率“稍慢”，看上去离用户更远。把背景和非互动的元素推到“更后面”
6. 维度表现为三类：

    + 折纸维度（Origami Dimensionality）——界面上的object在三个方向上“折叠”。多个对象组合成“折纸”的结构，被隐藏的元素在空间上仍然“存在”，即使不可见
    + 浮动维度（Floating Dimensionality）——给出界面中对象的空间起点和出发点。比如一堆卡片错落地堆叠在一起，通过滑动卡片移走上面一张，来读取下面一张
    + 物体维度（Object Dimensionality）——多个2D层被放置在3D空间中以形成真实的三维物体
