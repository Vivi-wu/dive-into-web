---
title:  "Shopify独立站实践（1）"
category: Other
---
{% raw %}
## Shopify 主题

Shopify 的主题是由模板文件创建的目录。这些文件是 Shopify 基于 Ruby 的开源模板语言 Liquid 编写的。不同于 app 是运行在开发者的 infrastructure 上，主题运行在 Shopify 的 servers 上。

主题目录被打包成 zip 文件进行分发。商家可以通过 Shopify admin 上传。

无论是 free 还是 paid 的主题，由于与主题或 Shopify admin 相关的限制，某些自定义设置是不支持的。

尽管 Shopify Support 能够支持各种基本自定义，但是官方给出 Design Policy，列出了一些列他们不会提供支持的 [task](https://help.shopify.com/en/manual/online-store/os/using-themes/theme-support#shopify-design-policy)

[主题开发者文档](https://shopify.dev/docs/themes)

在 Shopify 主题里引入 JS 的[“黄金法则”](https://shopify.dev/tutorials/include-javascript-in-shopify-themes)

可以在Shopify admin在线编辑主题代码，缺点：Online code editor 只记录代码修改时当前文件的快照。

<!--more-->

可以通过 admin API 修改主题的名称：https://shopify.dev/api/admin-rest/2021-10/resources/theme#[put]/admin/api/#{api_version}/themes/{theme_id}.json_examples

## Shopify API

Shopify 开发预判需要使用哪些 api，可以先看下[这里](https://shopify.dev/docs)

除了官方支持的库（Ruby、Ruby on Rails和 Python），官方也列里第三方库（目前仅 Node），可以用来进行身份验证并与Shopify API进行交互

地址：https://shopify.dev/tools/supported-libraries

## 转化跟踪

GA分析、Google Ads及Facebook分析的配置，参看这篇文章[Complete Guide to Shopify Conversion Tracking](https://deepfieldinc.com/shopify-conversion-tracking/)

作者建议always使用直接来在Shopify的 Google Ads conversions，只在有必要时从 Google Analytics import conversions。如果你对同一个转化即使有了native ads追踪，又从 ga import 了，就会得到 double-counting 的结果。

## 商品推荐

官方文档[Showing product recommendations on product pages](https://shopify.dev/tutorials/develop-theme-recommended-products)

使用 `recommendations.products` Liquid object 展示商品推荐，由 Shopify algorithm 来生成 recommended products.

默认商品推荐的算法使用销售数据和商品描述，选出相似或经常一起购买的商品。当这些数据不存在时，显示来自相关 collection 的商品。

算法使用来自 API 请求 URL 所含的 collection，然后拉取这个 collection 中的其他商品。当一个商品没有 collection url时，推荐算法找到包含此商品的 collection。

随着时间推移，当有新订单和商品数据产生，推荐会变得更加准确。

使用API​​指定的产品URL格式来 track 商品推荐对于提升销售的有效性（在 Shopify admin 的 Analytics 中）。

### 要求和限制

Shopify 商品推荐取决于 online store 配置和 Shopify plan：

+ 购买历史记录和商品描述：对拥有 Shopify Plus plan，所售商品数量少于7000，且使用英语作为店面
+ 仅够买历史记录：同上，非英语
+ 仅够买历史记录：没有 Shopify Plus plan，且商品少于7000
+ Collections：适用于任何 plan，且商品多于7000

你**不能定制推荐算法**：比如排除指定商品、使用从其他店铺或电商平台导入的订单。

库存为0、价格为0或者礼品卡不包含在推荐中。

### UI建议

由于推荐算法会按照相关性由强到弱的顺序，将每个产品最多关联十个产品，建议每个产品页面显示的相关产品不超过四个。

推荐模块使用 js 异步加载，可以在页面初次渲染时，添加一个 empty 状态，或者不展示推荐 section。

### 官方博客

[How to Build a Customizable Related Products Section](https://www.shopify.com/partners/blog/related-products)

1. 自定义 product-recommendations.liquid 模版
2. 在 `{% javascript %}` 里执行 ajax 请求（调用 Shopify 内置的读取推荐商品接口）
3. 将接口返回的（拼装好的）html 片段通过 innerHTML 的方式插入页面
4. 在 product.liquid 文件里通过 section 方式将自定义的模版 include 进来

本质上，是在产品推荐部分请求读取数据，并在页面上动态插入 response 的 markup。

此外，在版本 {% schema %} 添加配置，允许用户通过主题编辑器设置 section，比如：标题，是否显示该 section。

#### 通过 tags 匹配商品

该方式早于 `recommendations` Liquid 对象的引入，因此使用这种方式用户将无法利用由数据驱动的方法收集的分析数据。

另外，由于此方法涉及搜索所有产品以查找和显示 share 特定标签的产品，因此此查询会产生一定的性能成本。

Shopify 推荐接口以 product-recommendations.liquid 为模版，将推荐商品数据渲染进去后返回 browser。我们自己没有 liquid 渲染机制，直接替换接口，就无法利用 liquid 模版的便捷。

Shopify 提供 Section Rendering API，通过 ajax 请求指定的 section，返回渲染好的 html markup，实现页面局部更新。问题是那个 section 里数据来源怎么搞定？

override recommendations 对象？

今日调研 Shopify Plus plan结论：
1.是否可以 override Shopify 的 recommendations 对象？不行。
2.提供的额外的API资源仅针对礼品卡、Multipass、用户。
3.提供的 Script Editor 仅针对结账体验。

## Shopify app

Shopify app分为：

+ public app，适用于任意 store，分为 Shopify 自研和第三方开发者。主要列在 Shopify app store 里，这些 app 需要通过 Shopify 的信息审查
+ custom app，专为你的 store 定制的 app，不需要开通店铺 API 权限或者 Shopify admin 权限
+ private app，也是针对你的 store 开发的 app，可以用来给你的 Shopify admin 添加功能，通过 Shopify API 访问你店铺的数据

只有 store owner 可以创建、管理 private app。非试用期的 store 可以创建任意数量的 private app。

开发 Shopify app 需要开通一个 Shopify partners 账号，授权和测试 app 需要一个 Shopify Development store。

此外还有Standalone apps（独立应用可以完全在您的网站上运行）、embedded apps（嵌入式应用可以更深入地集成到Shopify admin中）。当Shopify商家在Shopify管理员中打开独立应用程序时，它将在新的浏览器标签中打开。嵌入式应用使用 Shopify App Bridge，这是一个JavaScript库，使应用程序可以与Shopify的UI连接，此外，还可以使用 app extensions。

### 使用React技术栈进行开发

Node.js、React、Next.js（客户端路由、SSR）、GraphQL（连接 Shopify API，用于查询和改变shop data）、Apollo（快速构建一个可通过GraphQL获取数据的React UI，是行业标准的GraphQL实现）、Polaris（Shopify 的 React 组件库，当开发 embedded app 时，因其直接出现在Shopify admin里，官方建议使用这个组件库）。

商户在授权安装 app 时，需要提供 HTTPS 地址（安装完毕重定向到此页面），使用 ngrok 可以将本地 localhost 映射成一个地址。

使用 Webhooks 监听和响应店铺发生的指定事件，Webhooks是“用户定义的HTTP回调”。它们通常是由某些事件触发的，例如将代码推送到存储库或将评论发布到博客。发生该事件时，源站点向为 Webhook 配置的URL发出HTTP请求。

## Shopify partners

作为 Shopify 合作伙伴，可以创建不限数量的开发商店。开发商店是附有少量限制的免费 Shopify 账户。可以使用开发商店测试创建的任何模板或应用，或用于为客户创建 Shopify 账户。

以上很重要，一般 Shopify 账户“在 Shopify 上创建商店，前 14 天免费试用。”

具体功能和限制看[官方文档](https://help.shopify.com/zh-CN/partners/dashboard/managing-stores/development-stores?itcat=partner_dashboard&itterm=recommendation#part-9a6d18dea8526614)

But!无法使用该商店安装付费应用（部分合作伙伴友好型应用除外）。

## Shopify Scripts

Scripts 为商店提供了一种编写可在 Shopify 服务器上运行的自定义 Ruby 的方法，并从根本上影响**购物车**。

+ 工作方式是接收一个 input 购物车，对订单项执行转换，然后返回 output 购物车
+ Scripts 是独立的，无法进行任何外部 API 或数据库调用来获取其他信息
+ 只有 Shopify Plus 商家可以在生产环境中使用
+ Shopify partners 可以在创建的任何开发商店中对其进行测试

可见官方出于安全考虑，开放出来的权限非常有限。

[官方博客](https://www.shopify.com/partners/blog/109804486-getting-started-with-shopify-scripts-a-practical-walkthrough)

## Shopify API

一些“奇技淫巧”：
### 获取未取消订单数据

  https://*.myshopify.com/admin/orders.json

发现一个有意思的点，即使用这种方式拿到别人订单的 token，访问 `https://<店铺前台域名>/<storeId>/orders/<token>`，页面上也读不到订单的 id 等信息。

访问自己的订单状态页，如果在 Settings-》Checkout-〉Order processing-》Additional scripts 里使用了 Shopify liquid 变量取数，渲染的页面上 Shopify.Checkout 才会有值（如果：订单 id）。

### 获取店铺商品总数

  https://*.myshopify.com/admin/products/count.json


## 开发工具

### Shopify App CLI

-》安装 shopify 命令行工具
-〉创建新项目

  shopify create node

-》开启本地开发服务器

  shopify serve

-〉终端里另打开一个tab页，自动完成浏览器打开app，并安装进开发店铺

  shopify open

谷歌搜索 Shopify GraphiQL App，安装给指定店铺，方便进行调试。

### Shopify GraphiQL App

安装地址：https://shopify-graphiql-app.shopifycloud.com/

如果 Shopify account 绑定多家店铺，建议使用无痕浏览模式打开此链接。

在安装页输入需要绑定的店铺 url，为避免后续 access denied，勾选所有 access scoped 的 read 权限。

### VS Code配置

建议安装的 Extensions：[sissel.shopify-liquid 代码高亮、formatting](https://marketplace.visualstudio.com/items?itemName=sissel.shopify-liquid&ssr=false#overview)

Mac快捷键：Shift + command + L

默认对整个文件进行格式化。

如果格式化不生效，看下settings.json中的这些配置：

```json
{
  "[html]": {
    "editor.defaultFormatter": "sissel.shopify-liquid"
  },
  "files.associations": {
    "*.liquid": "html"
  },
}
```

## 其他实用tips

- 在 Shopify admin 右上角点头像-》Your Profile，可以更改 admin 后台显示语言。
- 官方提供在线的[Shopify Admin API GraphiQL explorer](https://shopify.dev/tools/graphiql-admin-api)，这是个只读的 demo，可以大概看下 api 结构。实际使用需要在店铺安装 Shopify GraphiQL app。
- liquid 模板中可用的 Shopify 标签，变量和属性的完整列表，看这里[Shopify Cheat Sheet](https://www.shopify.com/partners/shopify-cheat-sheet)
- 多店铺使用统一主题，只维护一个中心主题，保持 brand uniformity 品牌统一，同时节省时间。有工具（如 PageFly）可以在多个Shopify店铺之间导出/导入模版。
- 在 liquid 里无法读取优惠券的详细信息
{% endraw %}
