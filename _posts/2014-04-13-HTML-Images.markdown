---
title:  "HTML Images"
category: HTML
---
## Images Syntax

The `<img>` tag 定义了HTML的图片，it is empty, it **contains attributes only**, and has **no closing tag**.
该标签是空的，只包含属性。

The `<img>` tag has two **required** attributes: _src_ and _alt_.

    <img src="url" alt="some_text">  

**Note**: Images are not technically inserted into an HTML page, images are linked to HTML pages. The `<img>` tag creates a holding space for the referenced image. 图片并不是被技术性地插入到一个HTML页面中，而是链接到其中。`<img>` 标签为这个引用的图片创建一个放置的空间。

<!--more-->

## The Alt Attribute

The _alt_ attribute provides alternative text for an image if it cannot be displayed (because of slow connection, an error in the src attribute, or if the user uses a screen reader)
该属性为一个图片提供可替换的文字信息，如果用户因为某些原因无法看到它，或浏览器无法找到图片，会显示alt值定义的文本。

Note: A web page will not validate correctly without the image's Alt attribute.

## Image Size - Height and Width

图片尺寸可以通过`<img>`标签的 _style_, 即inline css设定，也可以通过 _height_ and _width_ 特性设定。默认以pixel为单位。

Tip:

+ It is a good practice to specify both the height and width attributes for an image. If these attributes are set, the space required for the image is reserved when the page is loaded.
  
    在 `<img>` 上设定的宽高属性值，是个好的实践，因为如果设定了这些属性，当页面加载的时候，图片的所占空间就会被预留下来。如不指定，图片加载时页面会有flicker闪动。

+ 如果一个HTML文件包含10张图，为了正确显示这个页面则需要11个文件。加载图片花时间，请小心地使用图片。

## 破解防盗链

有些网站对图片做了防盗链，在 Request Headers 里通过 Referer 字段，拦截外站访问，返回403 forbidden。

解法： 设置 `<img>` 的 _referrerpolicy_ 属性值为 `no-referrer`，这样fetch资源文件时，不发送 Referer header。

参考[img标签](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img)

## Image Floating

使用css _float_ 属性，让图片浮动，文字自动环绕。

    <p>
    <img src="smiley.gif" alt="Smiley face" style="float:left" width="42" height="42"> A paragraph with an image. The image will float to the left of this text.
    </p>

## Image map

The `<map>` tag is used to define a client-side image-map which is an image with clickable areas.
该标签用于定义一个客户端的图片地图（有可点击区域的图片）

```html
<img src="planets.gif" width="145" height="126" alt="Planets" usemap="#planetmap">
<map name="planetmap">
  <area shape="rect" coords="0,0,82,126" href="sun.htm" alt="Sun">
  <area shape="circle" coords="90,58,3" href="mercur.htm" alt="Mercury">
  <area shape="circle" coords="124,58,8" href="venus.htm" alt="Venus">
</map>
```

`<map>` 元素的 _name_ 属性(**required**)值与相关联的 `<img>` 元素 的 _usemap_ 属性值 # 号后面内容一致。

它包含一系列定义了地图上可以点击的区域元素 `<area>`。该标签总是内嵌在 `<map>` 标签里，它**没有闭合标签**。

**Note**: 在 H5 中，如果要设定 `<map>` 标签的 _id_ 特性，且必须和 _name_ 特性值相同。

## `<picture>` Element

H5引入 `<picture>` 元素让我们可以像 `video` 和 `audio` 元素一样，定义不同的源文件。

```html
<picture>
  <source srcset="img_smallflower.jpg" media="(max-width: 400px)">
  <source srcset="img_flowers.jpg">
  <img src="img_flowers.jpg" alt="Flowers">
</picture>
```

_srcset_ 特性是必须的，用来定义图片源。_media_ 特性是可选的，接受像 CSS @media 查询规则。

由于目前全球支持该元素的浏览器不到 60%，需要定义一个 `<img>` 元素用于那些不支持 `<picture>` 元素的浏览器。
