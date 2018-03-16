---
title:  "晨读：draw dashed lines, CSS Variables"
category: CSS
---

怎么实现画一条dashed的线，可以控制线size和space？下面的答案介绍了三种方法并比较了利弊：
svg、css linear gradient、css box-shadow
[Control the dashed border stroke length and distance between strokes
](https://stackoverflow.com/a/31315911)

## CSS variables

```css
.block {
  --color: blue;
}
```

1. 定义：以两条 dashes 开头的 CSS 属性名称即为 CSS 变量，也称为 Custom Properties。变量的值应为有效的css属性值。

+ 可以在任何选择器中定义 CSS 变量
+ 支持媒体查询等 conditional rules
+ 支持在 HTML inline style 中定义
+ 变量名称 case-sensitive ！！！
+ 遵循正常的继承和层叠规则
+ 如果变量值是 invalid，则赋值的属性值等于 initial 或 inherited 值

<!--more-->

<img src="{{ "/assets/images/css_variables.png" | prepend: site.baseurl }}" alt="CSS variables">

2. 作用域：

+ 全局：定义在 _:root_ 选择器里的变量，属于 global scope
+ 局部：定义在其他选择器样式里的变量，属于 local scope

3. 引用：

通过 `var()` 函数引用CSS变量。

```css
:root {
  --font-size: 20px
}
p {
  font-size: var(--font-size)
}
```

还可以设置默认值。

```css
.btn {
  border: 2px solid var(--color, black); /*当作用域内不存在此变量，将使用第二个参数所为默认值*/
}
```

4. 跟 sass 等预处理器的区别：

+ css variables只能定义**属性值**
+ 变量值不能直接进行math运输，需要借助 `calc()` 函数

```css
.margin {
  --space: calc(20px * 2);
  font-size: var(--space);  /*equals 40px*/
}
```

+ 结合 css 单位的应用：

```css
:root {
 --size: 20
}

div {
  font-size: var(--size)px; /*WRONG: 浏览器解析为“20 px” */
  font-size: calc(var(--size) * 1px); /*right*/
}
```
