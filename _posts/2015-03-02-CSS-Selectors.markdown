---
title:  "CSS Selectors"
category: CSS
---
除了在 CSS Basic 章节提到的几个简单选择器，下面说说其他类型的 CSS 选择器。

## Attribute Selectors

属性选择器又分为：

### Attribute presence and value selectors

`[att]` Selector，匹配那些拥有 att 特性的元素，不管 att 值是什么。

`[att=val]` Selector，匹配那些拥有 att 特性，且 att 值等于 val 的元素。

`[att~=val]` Selector，匹配那些拥有 att 特性，且 att 值是一个由空格分隔的单词 list，其中一个单词为 val 的元素。<q title="Represents an element with the att attribute whose value is a whitespace-separated list of words, one of which is exactly &quot;val&quot;。">原文</q>

<!--more-->

注意：val 不能包含空格，不能是空 string

    [title~="flower"]

上面代码匹配 title="flower", title="summer flower", 和 title="flower new", 但**不匹配** title="my-flower" 或 title="flowers".

`[att|=val]` Selector，匹配那些拥有 att 特性，且 att 值要么就是 val，要么以 val 开始后跟 `-` 小横线。 <q title="Represents an element with the att attribute, its value either being exactly &quot;val&quot; or beginning with &quot;val&quot; immediately followed by &quot;-&quot;">原文</q>

    [class|="top"]

上面代码匹配 class="top", 或 class="top-text"

### Substring matching attribute selectors

特性值子字符串匹配，does not have to be a whole word!

`[att*=val]` Selector，匹配那些拥有 att 特性，且 att 值**包含 val** 的元素。

`[att^=val]` Selector，匹配那些拥有 att 特性，且 att 值**以 val 开始**的元素。

`[att$=val]` Selector，匹配那些拥有 att 特性，且 att 值**以 val 结束**的元素。

## Pseudo-classes

伪类选择器能够对**基于文档树之外的信息**进行选择。Pseudo-class 名称是 **case-insensitive**

1. 链接 pseudo-classes `:link` 和 `:visited`。
2. 用户操作 pseudo-classes `:hover`, `:active`, 和 `:focus`
3. `:target`，作为 URI 的目标元素，CSS 3 新增，<q title="Some URIs refer to a location within a resource. This kind of URI ends with a &quot;number sign&quot; (#) followed by an anchor identifier (called the fragment identifier)">原文</q>
4. `:lang(C)`，C 代表语言。实现针对不同语言元素设定不同样式
5. UI 元素状态 pseudo-classes

    + `:enabled` 和 `:disabled`
    + `:checked`
    + `:indeterminate`，单选框和复选框的中间状态
    + `:invalid` 和 `:valid`，当前 input 的值是否有效

6. Structural pseudo-classes

    + `:root`，文档根元素
    + `:nth-child(an+b)`，表示在文档树中其**前面**含有 an+b-1 个兄弟元素的元素。其中 _odd_ 等同于 2n+1，_even_ 等同于 2n
    + `:first-child`，等同于 `:nth-child(1)`
    + `:nth-last-child(an+b)`，表示在文档树中其**后面**含有 an+b-1 个兄弟元素的元素
    + `:last-child`，等同于 `:nth-last-child(1)`
    + `:nth-of-type(an+b)`
    + `:first-of-type`，等同于 `:nth-of-type(1)`
    + `:nth-last-of-type(an+b)`
    + `:last-of-type`，等同于 `:nth-last-of-type(1)`
    + `:only-child`，选择有父元素，且它是其父元素的唯一子元素，等同于 `:first-child:last-child`
    + `:only-of-type`，选择有父元素，且它是其父元素的子元素中，唯一是这种类型的元素，等同于 `:first-of-type:last-of-type`
    + `:empty`，代表没有子节点的元素，比如 `<p></p>`

7. Negation pseudo-class `:not(X)`，X 可以是除 `:not()` 选择器外的其他简单选择器。选中所有非 X 选择器的元素。

## Pseudo-elements

伪元素选择器创建文档树上抽象的节点，allow authors to refer to this otherwise inaccessible information。

`::first-line`，匹配一个元素中第一行 formatted 的内容。只适用于 block-like 的容器元素，比如 a block box, inline-block, table-caption, 或 table-cell.

并不匹配任何 real 文档元素，匹配的内容取决于页宽、字体大小等因素。参看<a href="https://drafts.csswg.org/selectors-3/#type-selectors" target="_blank">CSS官方草案解释</a>

`::first-letter`，匹配一个元素的第一个 letter 。

`::before`，`::after`，用来匹配一个元素前、后创建的内容

## Combinators

组合选择器其实是来解释选择器之间关系的。

### Descendant combinator

在两个简单选择器之间加一个空格，组成后代选择器。

E F，可以匹配 E 元素下所有的 F 元素，<span class="t-blue">两个元素之间的层次间隔可以是无限的</span>。

### Child combinators

两个简单选择器之间加一个 `>`，组成孩子选择器。

E &gt; F，匹配 E 元素下符合条件的所有（直接）孩子元素。<span class="t-blue">如果有其他元素包裹住这些元素，则视为不匹配</span>

### Sibling combinators

兄弟（姐妹）组合选择器有两种类型：

1. Next-sibling combinator，在两个简单选择器之间加一个 `+` 组成。

    E + F，匹配拥有相同父元素，**立即跟随** E 元素的兄弟 F 元素。比如 大哥+二哥，意思是选二哥。三哥、四哥，等等则不算在内。

2. Following-sibling combinator，在两个简单选择器之间加一个 `~` 组成。也称 general sibling combinator。

    E ~ F，匹配拥有相同父元素，不一定立即跟随 E 元素的兄弟 F 元素。**选择所有与指定元素同级的元素**。

以上两种情况在考虑元素 adjacency 关系时，non-element nodes (e.g. text between elements) 都忽略不计。

## 计算选择器特殊性

1. 统计 ID 选择器的个数 (= a) 权重 100
2. 统计 class、attribute、伪类选择器的个数 (= b) 权重 10
3. 统计 type 选择器和伪元素选择器的个数 (= c) 权重 1
4. universal 选择器忽略不计
5. `:not(X)` 内部的选择器遵循上面的规则，它本身不作为伪类选择器计算。

例如：

```css
*               /* a=0 b=0 c=0 -> specificity =   0 */
LI              /* a=0 b=0 c=1 -> specificity =   1 */
UL LI           /* a=0 b=0 c=2 -> specificity =   2 */
UL OL+LI        /* a=0 b=0 c=3 -> specificity =   3 */
H1 + *[REL=up]  /* a=0 b=1 c=1 -> specificity =  11 */
UL OL LI.red    /* a=0 b=1 c=3 -> specificity =  13 */
LI.red.level    /* a=0 b=2 c=1 -> specificity =  21 */
#x34y           /* a=1 b=0 c=0 -> specificity = 100 */
#s12:not(FOO)   /* a=1 b=0 c=1 -> specificity = 101 */
```
