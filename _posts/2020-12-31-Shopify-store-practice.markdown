---
title:  "Shopify独立站实践"
category: Other
---

文档 https://shopify.dev/docs/themes/liquid/reference/objects

<!--more-->

### 转化跟踪

GA分析、Google Ads及Facebook分析的配置，参看这篇文章[Complete Guide to Shopify Conversion Tracking](https://deepfieldinc.com/shopify-conversion-tracking/)

作者建议always使用直接来在Shopify的 Google Ads conversions，只在有必要时从 Google Analytics import conversions。如果你对同一个转化即使有了native ads追踪，又从 ga import 了，就会得到 double-counting 的结果

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
2. 在 {% javascript %} 里执行 ajax 请求（调用 Shopify 内置的读取推荐商品接口）
3. 将接口返回的（拼装好的）html 片段通过 innerHTML 的方式插入页面
4. 在 product.liquid 文件里通过 section 方式将自定义的模版 include 进来

本质上，是在产品推荐部分请求读取数据，并在页面上动态插入 response 的 markup。

此外，在版本 {% schema %} 添加配置，允许用户通过主题编辑器设置 section，比如：标题，是否显示该 section。

#### 通过 tags 匹配商品

该方式早于 `recommendations` Liquid 对象的引入，因此使用这种方式用户将无法利用由数据驱动的方法收集的分析数据。

另外，由于此方法涉及搜索所有产品以查找和显示 share 特定标签的产品，因此此查询会产生一定的性能成本。



Shopify 推荐接口以 product-recommendations.liquid 为模版，将推荐商品数据渲染进去后返回 browser。

我们自己没有 liquid 渲染机制，直接替换接口，就无法利用 liquid 模版的便捷。

Shopify 提供 Section Rendering API，通过 ajax 请求指定的 section，返回渲染好的 html markup，实现页面局部更新。问题是那个 section 里数据来源怎么搞定？

override recommendations 对象？

今日调研 Shopify Plus plan，1.是否可以 override Shopify 的 recommendations 对象？不行。2.提供的额外的API资源仅针对礼品卡、Multipass、用户。3.提供的 Script Editor 仅针对结账体验。

Shopify app 分为：
+ public app，适用于任意 store，分为 Shopify 自研和第三方开发者。主要列在 Shopify app store 里，这些 app 需要通过 Shopify 的信息审查
+ custom app，专为你的 store 定制的 app，不需要开通店铺 API 权限或者 Shopify admin 权限
+ private app，也是针对你的 store 开发的 app，可以用来给你的 Shopify admin 添加功能，通过 Shopify API 访问你店铺的数据

非试用期的 store 可以创建任意数量的 private app。

只有 store owner 可以创建、管理 private app

使用 Shopify admin 为 private app 授权。（已阅，没什么用）

阅读了 Shopify API License and Terms of Use，

Build a Shopify App with Node and 

需要开通一个 Shopify partners 账号

React教程：Node.js、React、Next.js（客户端路由、SSR）、GraphQL（用于与Shopify平台对话的查询语言）、Apollo（js库便于处理Shopify api，是行业标准的GraphQL实现）、Polaris（Shopify 的 React 组件库）

商户在授权安装 app 时，需要提供 HTTPS 地址（安装完毕重定向到此页面），使用 ngrok 可以将本地 localhost 映射成一个地址

授权和测试app需要一个 Shopify Development stores。

