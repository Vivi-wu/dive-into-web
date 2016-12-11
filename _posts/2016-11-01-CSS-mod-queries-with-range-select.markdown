---
title:  "CSS 选择器实现列表元素占满视图效果"
category: CSS
---
参考文章 [Using CSS Mod Queries with Range Selectors](http://alistapart.com/article/using-css-mod-queries-with-range-selectors)

问题描述：

有一组列表元素，每个元素以矩形展示，元素总个数（即列表长度）不固定，第一行放一个元素，剩下的元素平均放在 n 行展示（每行展示两个或三个）。当元素总个数超过 2 时，最后一行不能只有一个元素。

实现方法：

使用 CSS 的 quantity queries。

<!--more-->

### :nth-child(an+b)

该选择器匹配位置满足 an+b 的子元素（**前面**有 `an+b-1` 个兄弟元素）。下标（`an+b` 计算所得的值）从 1 开始，`n` 大于等于 0，`a` 表示周期长度，`b` 表示偏移量。

+ 1n+0，或 n，匹配每一个子元素。
+ 2n+0，或 2n，匹配位置为 2、4、6、8… 的子元素，该表达式与关键字 _even_ 等价。
+ 2n+1, 匹配位置为 1、3、5、7… 的子元素、该表达式与关键字 _odd_ 等价。

#### :nth-last-child(an+b)

与 `:nth-child(an+b)` 相反，表示从后往前，匹配在文档树中**后面**有 `an+b-1` 个兄弟元素的元素。

## 整除查询 Mod query

比起列表的长度，我们更想知道这个列表是否可以被一个特定的数整除。

下面通过组合 `:nth-child` 和 `:first-child` 两个选择器，实现当某个无序列表中 `<li>` 的个数可以被 3 整除时，选中这个列表中所有 `<li>` 元素。（在 Codepen 中 CSS 代码，例 1-1，把代码uncomment下，选中的效果为浅粉色背景高亮、藏青色字体。）

解释:

+ `li:nth-last-child(3n):first-child`，选中作为其父元素的第一个子元素 `<li>`，且这个元素的位置满足**从后往前数是 3 的倍数**。
+ `li:nth-last-child(3n):first-child ~ li`，选中满足上面条件 `<li>` 的所有 siblings （兄弟元素）

如果问题变成被某个数整除有余数，只需添加偏移量 b 即可。（参看例 1-2）

## 区间选择 Select a range

通过组合 `:nth-child(n)` 和 `:nth-child(-n)` 选择指定范围内的元素。

例如：`li:nth-child(n+3):nth-child(-n+5)`，选择作为其父元素下标大于等于3、小于等于5的所有子元素。（参看例 1-3）

<p data-height="390" data-theme-id="dark" data-slug-hash="xEvqWP" data-default-tab="css,result" data-user="VivienneWU" data-embed-version="2" data-pen-title="CSS mod query" class="codepen">See the Pen <a href="http://codepen.io/VivienneWU/pen/xEvqWP/">CSS mod query</a> by Vivienne (<a href="http://codepen.io/VivienneWU">@VivienneWU</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

再次回到一开始的问题。给一组列表元素样式化：

1. 列表长度等于 1，直接显示就好
2. 列表长度等于 2，这种情况要特别处理，可以通过：`li:nth-child(2):last-child`，选择作为其父元素的第2个子元素，且该元素同时也是其父元素的最后一个子元素。
3. 列表长度大于 2 时：

    + 除以3整除，则第一行占一个元素，第2占两个，其余每行3个。
    + 除以3余1，则第一行占一个元素，其余每行三个。
    + 除以3余2，那么第一行占一个元素，第2、3、4、5行每行两个，其余每行3个。

原文最后代码实现的效果如下：

<p data-height="390" data-theme-id="0" data-slug-hash="QKeqwK" data-default-tab="css,result" data-user="VivienneWU" data-embed-version="2" data-pen-title="Dynamic fill list item" class="codepen">See the Pen <a href="http://codepen.io/VivienneWU/pen/QKeqwK/">Dynamic fill list item</a> by Vivienne (<a href="http://codepen.io/VivienneWU">@VivienneWU</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>
