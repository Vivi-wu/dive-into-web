---
title:  "JavaScript HTML DOM"
category: JavaScript
---
DOM stands for **D**ocument **O**bject **M**odel, 是一个独立于平台和语言的接口，允许程序和脚本动态获取和更新一个文档的内容、结构和样式。

W3C DOM 标注分为3种不同的部分：Core DOM，XML DOM 和 HTML DOM。

## HTML DOM

HTML DOM 是针对 HTML 的一个标准对象模型和编程接口。规定了如何获取、改变、添加或删除 HTML 元素。

在 DOM 中，所有 HTML 元素被定义为**对象**。编程接口就是每个对象的属性（你可以获取和设定的**值**，比如 _innnerHTML_，该属性可以用来获取、改变**任何HTML元素**）和方法（可执行的操作，如 `getElementById()`）。

<!--more-->

### HTML DOM Document

HTML DOM Document 对象是页面中所有其他元素的主人。如果你想获取一个页面中的某个元素，always 从获取 document 对象开始。

第一个 HTML DOM Level 1（1998）定义了11个对象，对象集合和属性。下面列举一些：

<table>
  <tr>
    <th>属性</th><th>描述</th><th>DOM Level</th>
  </tr>
  <tr>
    <td>document.anchors</td><td>返回所有包含一个 name 特性的 &lt;a&gt; 元素</td><td>1</td>
  </tr>
  <tr>
    <td>document.body</td><td>返回 &lt;body&gt; 元素</td><td>1</td>
  </tr>
  <tr>
    <td>document.cookie</td><td>返回文档的 cookie</td><td>1</td>
  </tr>
  <tr>
    <td>document.domain</td><td>返回文档服务器的 domain nanme</td><td>1</td>
  </tr>
  <tr>
    <td>document.forms</td><td>返回所有 &lt;form&gt; 元素</td><td>1</td>
  </tr>
  <tr>
    <td>document.images</td><td>返回所有 &lt;img&gt; 元素</td><td>1</td>
  </tr>
  <tr>
    <td>document.links</td><td>返回所有包含一个 href 特性的 &lt;area&gt; 和 &lt;a&gt; 元素</td><td>1</td>
  </tr>
  <tr>
    <td>document.referrer</td><td>返回 referrer（链接的文档） 的 URL</td><td>1</td>
  </tr>
  <tr>
    <td>document.title</td><td>返回 &lt;title&gt; 元素</td><td>1</td>
  </tr>
  <tr>
    <td>document.URL</td><td>返回当前 HTML 文档的完整 URL，与 location.href 相似</td><td>1</td>
  </tr>
  <tr>
    <td>document.baseURL</td><td>返回文档的 absolute base URL</td><td>3</td>
  </tr>
  <tr>
    <td>document.doctype</td><td>返回文档类型</td><td>3</td>
  </tr>
  <tr>
    <td>document.documentElement</td><td>返回 &lt;html&gt; 元素，即全部文档</td><td>3</td>
  </tr>
  <tr>
    <td>document.documentMode</td><td>返回浏览器渲染当前文档使用的模式，<b>该属性是一个 IE only 的属性</b></td><td>3</td>
  </tr>
  <tr>
    <td>document.documentURL</td><td>返回文档的 URL，该属性可以适用于任何文档类型，而上面的 document.URL 只可以用在 HTML 文档</td><td>3</td>
  </tr>
  <tr>
    <td>document.embeds</td><td>返回所有 &lt;embed&gt; 元素</td><td>3</td>
  </tr>
  <tr>
    <td>document.head</td><td>返回 &lt;head&gt; 元素</td><td>3</td>
  </tr>
  <tr>
    <td>document.implementation</td><td>返回文档的 DOMimplementation 对象，目前不知道有什么用</td><td>3</td>
  </tr>
  <tr>
    <td>document.inputEncoding</td><td>返回文档的编码（character set）</td><td>3</td>
  </tr>
  <tr>
    <td>document.lastModified</td><td>返回文档更新的 date 和 time</td><td>3</td>
  </tr>
  <tr>
    <td>document.readyState</td><td>返回文档的 loading 状态：uninitialized（还没有开始下载）、loading、loaded、interactive（已经下载的足够用户可以与它交互）、complete（fully loaded）</td><td>3</td>
  </tr>
  <tr>
    <td>document.scripts</td><td>返回所有 &lt;script&gt; 元素</td><td>3</td>
  </tr>
  <tr>
    <td>document.strictErrorChecking</td><td>目前浏览器都不支持 ＝ ＝</td><td>3</td>
  </tr>
</table>

## Finding HTML Element

常见的查找 HTML 元素的方法:

+ `getElementById('myEle')`, 如果找到，返回该元素作为一个 object，没找到，返回 _null_
+ `getElementsByTagName('p')`, 以标签名查找。该方法返回一个 **node list**（像 array 一样的 nodes 集合），因此 nodes 可以使用 **index number** 像数组那样获取，也可使用 _length_ 属性，获取 node list 长度。但是 <span class="blue-text">node list 不是数组！</span>不能使用数组的方法，比如 `valueOf()` 或者 `join()`
+ `getElementsByClassName('test')`, 以 CSS 样式名查找。
+ `document.querySelectorAll(p.test)`, 查找所有匹配一个特定 CSS 选择器的某 HTML 元素。只返回第一个匹配到元素使用 `document.querySelector(CSS selectors)`
+ 以 HTML Object Collections 查找元素，比如查找 id 为 frm1 的表单，`document.form['frm1']`, 其他可以获取的文档对象集合可参考上面的表格。

### 改变 HTML

使用 `document.write()`，可以直接向 HTML 输出流写东西，但是要注意**不要在文档 loaded 之后使用**，这样会 overwrite 文档。

改变 HTML 元素内容最简单的方法就是使用 _innerHTML_ 属性。

改变一个 Attribute 特性值的方法有 2 种：

    element.attribute = new value
    element.setAttribute(attribute, value)

改变 HTML 元素的样式可以使用 HTML DOM Style 对象：

    element.style.property = new style

上面的 property 就是 CSS 属性名，对于使用 `-` 连字符的属性名，用法为 _paddingTop_

### DOM animation

使用 `setInterval` 和 `clearInterval` 函数作为 timer 实现 JS 动画。

## DOM EventListener

`element.addEventListener(event, function, useCapture)` 方法用来给指定元素绑定一个事件处理函数。最后一个参数是可选的 boolean 值，用来指定是否使用事件冒泡或事件捕捉。默认值是 _false_，所以默认使用 bubbling 冒泡传播。（在 bubbling 阶段，inner most 元素的事件先被处理，然后依次向外。而 capturing 阶段则相反，outer most 元素的事件先被处理）

+ 可以对同一个元素，添加多个不同类型事件的 event handle
+ <span class="blue-text">可以对一个元素添加多个**相同类型**的事件处理函数</span>，比如，两个 click 事件处理，without overwriting existing codes
+ 可以给任何 DOM 元素添加事件监听器，包括 window 对象
+ 使用 `addEventListener()` 方法可以实现 JS 代码和 HTML 内容分离
+ 使用 `element.removeEventListener(event, function)` 方法，移除事件监听器

### 给事件处理函数传递参数

使用**匿名函数**来调用指定事件处理函数，将需要传递的参数作为指定函数的实参。

    element.addEventListener("click", function(){ myFunction(p1, p2); });

## DOM Nodes

根据 HTML DOM标准，在 HTML 文档中所有东西都是一个 node 节点。每一个 HTML element 是一个 **element node** 元素节点，元素里的 text 是 **text node** 文本节点，每一个 HTML attribute 是一个 **attribute node** 特性节点，所有 comment 则是 **comment node** 注释节点。

### Node relationships

除了 `<html>` 元素，每个节点都有唯一的父节点。可以使用以下的节点属性，通过 JS 在节点之间 navigating。

+ _parentNode_，父节点
+ _childNodes[nodenumber]_，孩子节点列表
+ _firstChild_，第一个子节点
+ _lastChild_，最后一个子节点
+ _previousSibling_，前一个相邻节点
+ _nextSibling_，后一个相邻节点

### Node Value

_nodeValue_ 对于元素节点，是 **undefined**；对于文本节点，就是**文字本身**；对于特性节点，就是**特性值**。

注意：元素包含的文字内容是 text node，而不是 text。

获取文本节点的值，除了使用 _.innerHTML_，还可以组合使用 _childNodes_ 和 _nodeValue_.

    <p id="intro">My first page.</p>
    var myText = document.getElementById('intro').childNodes[0].nodeValue;
    // 或者
    var myText = document.getElementById('intro').firstChild.nodeValue;

### nodeName 和 nodeType

_nodeName_ 是只读的，元素节点的 nodeName 与 tag 名字相同，特性节点就是 attribute 名字，文本节点的 nodeName 总是 `#text`，而文档节点则是 `#document`。

_nodeType_ 也是只读的：Element, Attribute, Text, Comment, Document.

## Nodes 操作

常见的操作如添加和删除。

1. 添加操作可以使用 `createElement(tagname)`, `createTextNode(string)`, `appendChild(node)`, `element.insertBefore(node, child)`
2. 删除操作使用 `parent.removeChild(child)`。虽然删除元素如果不需要 referring 父元素的话会更好，但是 DOM 操作需要知道你想删掉的元素和它的父元素。常用的方法是 `child.parentNode.removeChild(child)`
3. 替换操作使用 `parent.replaceChild(newchild, oldchild)`