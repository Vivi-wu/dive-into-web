---
title:  "用动作创造可用性"
category: Other
---
主要讲动作在 UI 交互中的应用。

原文[CREATING USABILITY WITH MOTION](https://medium.com/ux-in-motion/creating-usability-with-motion-the-ux-in-motion-manifesto-a87a4584ddc)

## 实时 vs. 非实时交互

在 UX 中的 state，即状态，是静止的。行为 act 是临时的，基于动作 motion 的。

“实时”意味着用户是直接与用户界面中的对象进行互动，被认为是“直接操作”；“非实时”则意味着对象的表现发生在用户的动作之后，是过渡性的，其影响是“锁定”了用户直到过渡结束。

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
      <td>Parallax 平行的</td>
      <td>Obscuration 【天】掩星</td>
    </tr>
    <tr>
      <td>Offset &#38; Delay（当引进新元素和场景时，定义事物的关系和层级。通常用来表现一些事物是separate）</td>
      <td></td>
      <td>Value Change（当数字、文本的值改变时，创建一个动态连续的叙述性的关系。数字和值代表了发生在现实中的事情，可以是时间、收入、游戏得分、健康曲线等，当用户注意到了数据的动态性，结果是不仅注意到了数值，还变得主动）</td>
      <td></td>
      <td>Dimensionality</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>Masking（当用途由事物的部分/组的显示或隐藏来决定时，创造界面对象的连续性。可以认为是事物形状和它的用途之间的关系）</td>
      <td></td>
      <td>Dolly &#38; Zoom</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>Overlay</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>Cloning</td>
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
3. 比如一个submit按钮，从矩形变成一个圆环型的进度条，最后又变成一个明显的确认标记的按钮。它吸引了我们的注意力，tells a story 然后结束。
4. 数值改变可以是实时的（用户和对象交互时改变），也可以是非实时的（比如loader和过渡，不需要用户输入）
