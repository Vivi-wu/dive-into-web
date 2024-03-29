---
title:  "各种花边各种tip"
category: Other
---
## favicon 引入问题

    <link rel="short icon" style="image/x-icon" href="taobaoLogo.ico" >

一般这个Logo图标不但可以运用在浏览器tab的标题中，而且还可以放在收藏夹中去使用，只需将 `rel="short icon"` 改为 `rel="bookmark"` 即可

如果一个html页面没有用link指定favicon，则会使用网站根目录下的默认 favicon.ico

查看方式：

    http://www.w3cfuns.com/favicon.ico

## 添加智能 App 广告条 Smart App Banner

    <meta name="apple-itunes-app" content="app-id=myAppStoreID, affiliate-data=myAffiliateData, app-argument=myURL" />

以上代码的作用是告诉浏览器这个网站对应的app，并在页面上显示下载 banner

<!--more-->

## 获取滚动条的滚动值

在Android中通过 `document.scrollTop` ， `document.scrollLeft` 两个属性获取到滚动条的值（就像在PC上一样）。但是iOS中这两个属性是未定义的。需要使用 `window.scrollY`， `window.scrollX`属性。

但是事实证明 android 也支持这属性，所以索性都用 woindow.scroll

## Chrome插件 Page Ruler 和 QR code

超好用的神器，可选择Element Mode（鼠标移动到元素上就可以显示尺寸、位置信息），也可以手动模式，自己定位

后者可以把链接转成二维码

## 查看Chrome自带组件的样式

自定义 date 输入框时，发现浏览器自带的 datepicker 样式是由类似 `::-webkit-inner-spin-button` 等 CSS 伪元素样式定义的。

如何在 devtool 里定位和修改这些元素呢？

打开开发这工具，点击 Element、Network,...工具栏上最后边的图标 “Customize and control DevTools” ——> Settings ——> Elements 部分选中 “Show user agent shadow DOM”

注：当前Chrome版本 61.0.3163.79

## 看不到的设计

Good design is often invisible. Much of design is about "feeling right." Users want to engage and interact with something. They don't necessarily understand why. That's invisible design.

## 设计与伦理

通过陈列选项菜单，科技操纵了我们对待选择的方式，而且不断用新的选择去更新这份列表。我们越仔细地查看那些提供给我们的选项，我们越会发现其实这些选项与我们的真实需求并不相关.

如果你想将吸引力最大化，所有产品设计者需要做的是将用户动作（如转动转盘）与不确定奖励相关联。转动转盘，然后你马上会获得一个诱人的奖励（手表、奖金）又或者期待下一次转动转盘。当奖励的几率最不确定时，人们的上瘾程度便会得到最大化。

不幸的事实是——很多人的口袋里都有一个老虎机：

+ 当我们把手机从口袋中拿出来时，是在用老虎机查看收到了哪些信息。
+ 当我们刷新电子邮件时，是在用老虎机看收到了哪些邮件。
+ 当我们滑动 Instagram 的页面时，是在用老虎机看哪些照片即将出现。
+ 当我们在约会软件 Tinder 上，将人们的照片左划右划时，是在用老虎机期待我们是否有配对成功。
+ 当我们点击红色通知的数字时，是在用老虎机查看这些数字背后的消息。

一直活在会错过重要时刻的恐惧中，并不是我们应有的生活方式。

而且，一旦驱赶了这份恐惧，我们会非常迅速地从假象中苏醒过来。当我们断开电源超过一天，退订那些信息，或者去野外扎营，我们以为会担心的事，其实并没有发生。

我们不会错过那些我们看不到的事。

对于 “错过重要事情” 的担忧，只会产生在断开电源、退订或关机之前，而不是之后。

终极自由是思想的自由，我们需要科技帮助我们自由地生活、感受、思考以及行动。

## Chrome DevTool 实用技巧

+ 在"Element"面板中选择某个DOM元素，点击"Console"并输入 `$0` 可以获取当前元素
+ 元素Style面板里，选择“Toggle Element State”可以触发伪类状态，便于调试样式

## 银行理财产品如何计算

选择一款理财产品，除了看收益，安全性、流动性也要综合起来考量。例如，理财产品发行者的实力和信誉(安全性)、产品的投资方向(收益性和安全性)、类似产品过往的表现(收益性)、能否提前赎回(流动性)等等

对于银行理财产品来讲，预期收益率就是银行按照其投资标的以及历史投资收益数据，预期理财产品能实现的最高收益率；实际收益率则是指在理财产品到期后，投资者可以真实获得的收益。二者最大的区别在于，一个是预计的，一个则是实际发生的。

这两者有时候相等，有时候却不等。相等的情况发生在，银行在理财产品存续期间运作良好，到期时实现了开始所给出的预期最高收益，那么预期收益率=实际收益率；如果银行在理财产品运作期间未能实现最好运作，或者理财产品的运行触发了某些先决条件，都可能导致到期收益率≠预期收益率。大多数情况下，前者小于后者，极少数情况下，前者大于后者，但超出部分往往可能被银行以管理费等形式拿走，投资者到手的仍然是预期最高收益率。

计算公式：

　　到期收益=投资金额×实际收益率×实际投资天数/365天

假如一个猫友投入10万元买了一款银行理财产品，到期收益率为5%，投资期限180天，他的到期收益就为10万元×5%×180/365=2465元，而非10万元×5%=5000元。

## 怎么结束跟客户（雇主）的关系

when？
+ 忽略或无视合同条款，如：报酬、支付时间表。
+ always要求一个更好的 rate，你不想把自己看低 sell yourself short
+ 每一次对话都是负面的
+ 你没有足够的时间或者他们没有给你足够的工作去 justify your time
+ 你转向别的方向

how？
+ 进行一次坦诚的对话。让对方知道你的期望，他们是怎么没有达到预期，或者关系是怎么改变的，为什么对双方最好是分开前进。
+ 在合适的时机给出通知，比如一个项目结束的时候。
+ 提供一些建议、可选项，这样他们能够继续前进。
+ 不要胡扯，不要因为感到内疚改变心意。Know what you want and stick to it. Be confident and in control.
+ 感谢他们然后继续前进。如果被问起原因，可以说 the work isn't a fit for my business anymore. Thanks for the experiences you have provided me with along the way
+ 一旦你们进行过沟通，以书面形式把结果发给他们（Email 就行）。
+ 所有客户端的对话都应该是 professional 应该被小心处理，这是 business 关系，即使是一个结束的关系。

## 巧用 ps 切片工具切图和生成 HTML 代码

打开原图，快捷键 C 调出“切片工具”（与“裁剪工具”在一个工具图标菜单里），鼠标左键框选切图区域（可看到切出的几个区域左上角有 01 、02 等蓝色数字编号和一个小图标）

编辑要导出的切片区域，右键-编辑切片选项，名称：图片文件的名称，Alt标记：最好填写图片上有的文字（图片获取失败时，用户可看到的文字）。如果图片点击可以跳转，则需要填写 URL（链接的地址），目标（是否在新tab打开）

文件-导出-存储为web所用格式，预设选 PNG-heigh，点“存储”。

格式：HTML和图像，设置：默认设置，切片：所有切片（默认），也可以只导出“选中的切片”（按住 Shift，左键点选想要导出的切片），点“保存”。

可看到 HTML 文件里的 img 标签 PS 都帮我们写好了。

### Bonus 快速生成九宫格

打开正方形原图（或把原图裁剪成正方形）。调出“切片选择工具” (Slice Select Tool)，鼠标左键点击图片，此时上方工具栏中的“划分...”(Divide...) 按钮变为可选状态，点击“划分”。

勾选“水平划分”、“垂直划分”复选框，纵/横向切片个数都改成 3，点击“确定”。

Alt+Shift+Ctrl+S（文件-导出-存储为web所用格式），剩下保存步骤同上。

## 前后端分离

真正 senior 的人必须了解整个 end-to-end 过程。掌握大局同时了解细节。具体的问题可以丢给 junior 的人去解决。

性能优化只在瓶颈上做，做在非瓶颈上是浪费资源。

使用js模板，然后在浏览器端执行，这是存在一些问题的，比如说seo不友好，首屏性能不够，尤其对于首页DOM量很大的电商类网站，差距很明显。

工程师团队有两种类型工程师：工程师类型和科学家类型。工程师类型，在他们眼中一切皆工具，能快速实现和为工程服务，他们的技能是追求横向的，一切皆我所用。能快速实现，用可以掌握的技术解决工程问题。这样的人，无所谓前后端了。如果这类人，愿意跟随公司业务一起成长，擅长解决遇到各种技术问题，所以在他们眼里无所谓前后端。

科学家类型，做技术就要做到极致，追求更深入研究和细节。用什么东西喜欢研究透。这种工程师会在纵向细分领域研究很深入。这些人倾向于做细分领域也就是前后端分离倾向。

科学家类型像学术方向，工程师类型像应用方向，没有谁绝对好或者不好。

## web 安全

CSP 定义 Content-Security-Policy HTTP 标头，允许创建信任的内容的来源白名单，并指示浏览器仅执行或渲染来自这些来源的资源，而不要盲目地信任服务器提供的所有内容。

CSP并不能防止 XSS 攻击，但可以最小化 XSS 发生后所造成的伤害。通过完全禁止内联脚本（不仅包括在 script 标记中直接嵌入的脚本，也包括内联事件处理程序）来解决XSS攻击带来的脚本注入。禁止内联脚本是 CSP 提供的最大安全性优势，禁止内联样式同样可以提高应用的安全性。

CSP 机制允许为一个资源指定多个策略，包括通过 Content-Security-Policy 标头（response header）、Content-Security-Policy-Report-Only 标头和 `<meta>` 元素。

可以多次使用 Content-Security-Policy 标头，添加额外的策略只能进一步限制受保护资源的能力。

Content-Security-Policy 标头的指令也可以应用于 Content-Security-Policy-Report-Only 标头。

## CSS 开发者大会相关

OOCSS，object oriented CSS，把结构和样式分离，把容器和内容分离。避免使用 IDs 作为样式块。

SMACSS，

### CSS 动效

CSS 书写动效：**命令式**（如 jQuery.animate，显示调用动画函数触发效果）和**声明式**（CSS Transition，Animation，声明式地定义各个“状态”下的CSS规则，通过切换CSS class来触发动效）。

前者把动画状态和应用状态混在一起，逻辑复杂后不易维护。

### CSS 性能

+ 慎重选择高消耗的样式（绘制前需要浏览器进行大量计算的 expensive styles）：`box-shadows`,`border-radius`,`transparency`,`transforms`,`CSS filters`
+ 避免过分 reflow（浏览器重新计算元素的**位置**和**大小**）。常见引起重排的属性：width/height，padding，margin，display，border，border-width，position，top/bottom/left/right，font-size，font-weight，font-family，float，text-align，vertical-align，line-height，min-height，overflow，clear，white-space
+ 避免过分 repaint（重新绘制显示的内容，而元素的几何尺寸没有变），常见引起重绘的属性：color，border-style，visibility，text-decoratoiin，background，background-image，background-position，background-repeat，background-size，outline，outline-color，outline-style，outline-width，border-radius，box-shadow
+ `requestAnimationFrame`，一种提供更高效运行基于脚本动效的 API（让视觉更新按照浏览器的最优时间来安排计划），相比于传统的 timeouts 方法。

硬件加速是指GPU帮助浏览器在渲染一个页面时做一些繁重的工作，代替传统地把全部工作扔给CPU来做。

GPU专门用来执行那些对于图像渲染必要的复杂数学、几何运算。

硬件加速依赖于浏览器渲染页面时使用的 layering 模型。当页面中某个元素上执行特定操作时，元素被移到它自己的 layer，在那里它将被独立渲染然后画到屏幕上。

如果元素的 transform 是frames之间唯一改变的东西，页面剩余内容都不需要 rerender，极大地提升渲染速度。

值得一提的是**只有 3D transforms**有自己的图层。

硬件加速的 CSS 属性有 _opacity_, _translate3d(0, 0, 0)_

Layer creation 技术催生了页面速度，但也有相应的代价——占有系统的RAM和GPU，在确保操作真的提高了页面性能的情况下明智地使用。

由此也诞生了新的 _will-change_ 属性，通过告知浏览器哪些元素以及哪些属性将要改变，让浏览器能提前优化处理这些任务的方案。（除IE主流的浏览器都支持）。

使用该属性能够使 animation 平滑地开始，不会有以前动效开始时短暂的跳动 flicker。

把将要改变的属性名，以逗号分隔形式赋值给 _will-change_ 属性。

    will-change: transform, opacity;

实际使用中需要给浏览器一些时间去优化。比如，点击某元素的时候有动效，可以把 _will-change_ 写在该元素的 hover 状态里。

```css
.element {
    /* style rules */
    transition: transform 1s ease-out;
}
.element:hover {
    will-change: transform;
}
.element:active {
    transform: rotateY(180deg);
}
```

如果 hover 元素时就要有动效，_will-change_ 写在这里就没什么作用（hover 已经发生了）。可以把 _will-change_ 写在该元素的祖先元素的 hover 状态里。

建议使用 JS 来 set 和 unset will-change 属性，这样浏览器在动效结束时可以回收用于优化的资源。

当元素数量较少、用户在这些元素上会频繁交互时，可以把 will-change 属性写在 CSS 样式文件里。比如：滑出一个侧边栏、元素根据用户鼠标移动而改变状态。

tip：

+ 当 will-change 取值为 `scroll-position` 时，会使长页面或快速滚动页面平滑地进行。
+ 当 will-change 取值为 `contents` 时，浏览器会减少在该元素上的缓存。因为如果一个元素的内容频繁改变，保留元素内容的缓存将没什么用还费时间。

## CDN

系统访问量变高了，速度变慢。怎么优化？优化方式有很多，读写分离，负载均衡等。具体到本问题的范畴内，那就是资源服务器与应用服务器的分离。粗暴的理解方式就是，应用安在应用服务器（一台或者是集群），资源部署在资源服务器（单台或者是集群）。此时，js以及css的引用就需要更改为绝对URL，指向对应的资源服务器。

网站的访问速度，只基于一点，那就是页面包含的内容传输到用户电脑的速度，服务器搭的再好再完美，如果用户到服务器的链路之间有一段比较缓慢的话，整体速度也会被拉的十分差劲。

与传统访问方式不同，CDN 网络则是在用户和服务器之间增加缓存层，将用户的访问请求引导到最优的缓存节点而不是服务器源站点，从而加速访问速度。

<img src="{{ "/assets/images/cdn工作原理.png" | prepend: site.baseurl }}" alt="cdn 工作原理流程图">

总结一下CDN的工作原理：通过权威DNS服务器来实现最优节点的选择，通过缓存来减少源站的压力。

## 测试工具、UI 组件、可视化库

- mocha、krama
- notie.js（顶部和底部显示通知，类似手机应用）
- animate.css
- 阿里开源的g2（图标类），g6（关系图可视化）

### npm package-locks

如果 package.json 是 npm-install 的输入，那么一个完整格式的 node_moudles 数则为其输出。

有时 npm 不能生成完全一样的 node_modules 树：

+ 不同版本的npm使用稍有不同的安装算法
+ 指定范围的包发布了新版本since上次安装
+ 依赖之中的某个dependency发布了新版本
+ 安装的注册表不再可用，或者允许版本变异导致在相同版本号下存在不同版本的软件包
+ 任何缺少的依赖关系都会以通常的方式安装

[package-lock.json](https://docs.npmjs.com/files/package-lock.json) 在任何更新node_modules和/或package.json的依赖关系时，都会自动同步现有的锁定程序。这样即使中间dependency更新，之后的install也能生成相同的tree。

强烈建议commit这个文件到source仓库里：

+ 描述唯一的依赖树，保证其他人按照完全相同的依赖
+ 方便用户追溯 node_modules 的修改记录，而无需git追踪这个文件夹
+ 提高依赖树变更的可读性
+ 优化安装进程，通过让npm跳过重复的（已安装的包）metadata解析，任何未来的安装都将基于这个文件，而不是重新计算package.json的依赖版本

如果该文件没有放在项目root目录下将被忽略。

### Draw dashed lines

怎么实现画一条dashed的线，可以控制线size和space？下面的答案介绍了三种方法并比较了利弊：
svg、css linear gradient、css box-shadow
[Control the dashed border stroke length and distance between strokes
](https://stackoverflow.com/a/31315911)

### CSS 关键词 unset

关键词 _unset_ 适用于任何 CSS 属性，效果是将属性值设为 **inherited** value from 祖先元素；如果祖先元素中没有对该属性进行设值，则将属性值设为 initial value。

## 小的UI tips

1.在引起严重后果的action按钮上使用红色高亮，提醒用户这个操作有危险
2.在非主要操作的按钮上不要使用深色，而是浅灰色或其他浅色
3.背景图使用 `blend-mode: multiply` 并结合背景色，生成叠加效果，让hero banner白色字体有一个漂亮的contrast
4.相似的内容排在一行，使用上下边线来group，便于用户理解
5.英文全大写文案增加 letter spacing
6.英文页面的body text采用 `font-size: 16px;` 和 `line-height: 1.5`
7.让图标和段落首行或小标题在同一行对齐
8.图标的颜色采用比旁边label文案更light的颜色，让更重要的文字信息pop out

### object-fit

该 css 属性设定 img、video 插入的内容如何进行缩放以填充容器。可选的值：contain（保持长宽比）、cover、fill、none、scale-down（效果有时同none和contain）

### attr()

css 函数，用于提取选定的 html 元素上某属性的值，并用于样式表。也可用于伪元素，在这种情况下，返回伪元素的 originating element 上的属性值。

## Windows vs. Unix

换行符：Windows 为 `\r\n`（CRLF），Unix 为 `\n`（LF）