---
title:  "HTML Links"
category: HTML
---
## HTML Links - Hyperlinks

The HTML `<a>` tag defines a hyperlink that you can click on to jump to another document. 通过点击超链接可以跳到另一个文件。

    <a href="url">Link text</a>

**Tips**:

+ The "Link text " is the visible part and doesn't have to be text. It can be an image or any other HTML element
标签 `<a>` 的内容也可以是**图片**或者**其他HTML元素**，只要用 `<a>` 标签将那个元素包围住。
+ 记得在子文件索引后加一个 **trailing slash** 结尾斜杠。否则可能会向服务器发送两个request。Many servers will automatically add a trailing slash to the address, and then create a new request.

<!--more-->

#### Local links

An absolute URL (a full web address, like: http://www.w3schools.com/html/), a local link (链接到同一个网站) is specified with a relative URL (without http://www....)

### Links - Colors

默认情况下在所有浏览器中，一个链接有以下几种状态：

+ An <span style="color:blue;text-decoration:underline;">unvisited</span> link is underlined and blue 未访问的链接，下划线，蓝色
+ A <span style="color:purple;text-decoration:underline;">visited</span> link is underlined and purple 已访问过的链接，下划线，紫色
+ An <span style="color:red;text-decoration:underline;">active</span> link is underlined and red 活跃的链接（mouseover时），下划线，红色

### The _href_ Attribute

The most important attribute of the `<a>` element is the href attribute which specifies the destination addresse. 
属性 _href_ 指定了一个超级链接的目的地.

常用对例子，创建一个 email 链接:

    <a href="mailto:xxx@yyy">  

### The _target_ Attribute

The target attribute specifies where to open the linked document. 属性 _target_ 指定在哪里打开所链接的文件。该特性不同取值的表现如下表所示：

<table>
  <tbody>
    <tr>
      <td>_blank</td><td>in a new window or tab（在新窗口或标签里打开）</td>
    </tr>
    <tr>
      <td>_self</td><td>in the same frame as it was clicked (<strong>default</strong>) 在相同的框架内打开</td>
    </tr>
    <tr>
      <td>_parent</td><td>in the parent frame</td>
    </tr>
    <tr>
      <td>_top</td><td>in the full body of the window. 比如本来webpage被锁定在一个框架里，如果链接的target特性值设为<i>_top</i>，点击链接后会 break out 这个frame，全窗口显示被链接的文件。</td>
    </tr>
    <tr>
      <td><i>framename</i></td><td>in a named frame</td>
    </tr>
  </tbody>
</table>

### HTML Links - Create a Bookmark

在HTML文件内创建书签 to allow readers jump to specific parts of a web page.

首先在目标元素上添加 _id_ 特性，

    <a id="tips">Useful Tips Section</a>

同页内超链接跳转:

    <a href="#tips">Visit the Useful Tips Section</a>

链接其他网页中的指定区域:

    <a href="http://blog.csdn.net/html_links.htm#tips">Visit the Useful Tips Section</a>
