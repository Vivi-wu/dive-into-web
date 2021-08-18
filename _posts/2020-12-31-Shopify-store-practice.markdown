---
title:  "Shopify独立站实践"
category: Other
---

### Shopify 主题

Shopify 的主题是由模板文件创建的目录。这些文件是 Shopify 基于 Ruby 的开源模板语言 Liquid 编写的。不同于 app 是运行在开发者的 infrastructure 上，主题运行在 Shopify 的 servers 上。

主题目录被打包成 zip 文件进行分发。商家可以通过 Shopify admin 上传。

无论是 free 还是 paid 的主题，由于与主题或 Shopify admin 相关的限制，某些自定义设置是不支持的。

尽管 Shopify Support 能够支持各种基本自定义，但是官方给出 Design Policy，列出了一些列他们不会提供支持的 [task](https://help.shopify.com/en/manual/online-store/os/using-themes/theme-support#shopify-design-policy)

[主题开发者文档](https://shopify.dev/docs/themes)

在 Shopify 主题里引入 JS 的[“黄金法则”](https://shopify.dev/tutorials/include-javascript-in-shopify-themes)

<!--more-->

### Shopify API

Shopify 开发预判需要使用哪些 api，可以先看下[这里](https://shopify.dev/docs)

除了官方支持的苦（Ruby、Ruby on Rails和 Python），官方也列里第三方库（目前仅 Node），可以用来进行身份验证并与Shopify API进行交互

地址：https://shopify.dev/tools/supported-libraries

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

React教程：Node.js、React、Next.js（客户端路由、SSR）、GraphQL（连接 Shopify API，用于查询和改变shop data）、Apollo（
快速构建一个可通过GraphQL获取数据的React UI，是行业标准的GraphQL实现）、Polaris（Shopify 的 React 组件库，当开发 embedded app 时，因其直接出现在Shopify admin里，官方建议使用这个组件库）

商户在授权安装 app 时，需要提供 HTTPS 地址（安装完毕重定向到此页面），使用 ngrok 可以将本地 localhost 映射成一个地址

授权和测试app需要一个 Shopify Development stores。

使用 Webhooks 监听和响应店铺发生的指定事件，Webhooks是“用户定义的HTTP回调”。它们通常是由某些事件触发的，例如将代码推送到存储库或将评论发布到博客。发生该事件时，源站点向为 Webhook 配置的URL发出HTTP请求。

又看到两个新概念：Standalone apps、embedded apps。独立应用可以完全在您的网站上运行，而嵌入式应用可以更深入地集成到Shopify admin中。

当Shopify商家在Shopify管理员中打开独立应用程序时，它将在新的浏览器标签中打开。嵌入式应用使用 Shopify App Bridge，这是一个JavaScript库，使应用程序可以与Shopify的UI连接，此外，还可以使用 app extensions。

App extensions，通过为您的应用程序使用应用程序扩展，可以为用户现有的 Shopify 工作流程中的提供价值。对于商家需要快速、频繁操作的 app 很有用。

官方提供在线的[Shopify Admin API GraphiQL explorer](https://shopify.dev/tools/graphiql-admin-api)，这是个只读的 demo，可以大概看下 api 结构。实际使用需要在店铺安装 Shopify GraphiQL app


推荐对象仅在通过HTTP请求呈现给<base_url>？section_id = <section_id>＆product_id = <product_id>的主题部分中使用时才返回产品。 section_id是正在使用推荐对象的部分的ID，product_id是要为其显示推荐产品的产品的ID。要确定base_url，请使用routes.product_recommendations_url属性。使用路由对象而不是硬编码URL可确保产品推荐在正确的语言环境中加载。

shopify 的 recommendation 仅在商品和collection页显示？

## Shopify partners

作为 Shopify 合作伙伴，可以创建不限数量的开发商店。开发商店是附有少量限制的免费 Shopify 账户。可以使用开发商店测试创建的任何模板或应用，或用于为客户创建 Shopify 账户。

以上很重要，一般Shopify账户“在 Shopify 上创建商店，前 14 天免费试用。”

具体功能和限制看[官方文档](https://help.shopify.com/zh-CN/partners/dashboard/managing-stores/development-stores?itcat=partner_dashboard&itterm=recommendation#part-9a6d18dea8526614)

But!无法使用该商店安装付费应用（一系列的合作伙伴友好型应用除外）

所幸的是 LimeSpot Personalizer 这款需要调研的app是 Partner-friendly apps。在开发商店里不会向您收取测试费用。Regular charges will apply once the store is switched over to a paid plan.

添加商品，Shopify上传商品图片比较方便，提供了通过 URL 添加媒体（图片、YouTube视频）。可使用富文本编辑器写商品description。

在右上角点头像-》Your Profile里可以更改 admin 后台语言。

第三方插件说：The products in the recommendation boxes within the Box Designer are random sample products from your store. On your live store, the actual calculated recommended items will show in the Intelligent Recommendation Boxes.

商品详情页：

1. "PUT https://storefront.personalizer.io/v1/userAuthentication?t=*"，是 LimeSpot 这个插件提供的开发API平台。根据[文档说明-sample flow](https://personalizer.io/help)，用户开启一个新session时，第一步是获取auth（响应里有用户id、contextId、token和过期时间），请求头会带上[X-Personalizer-Context-ID]
2. "GET https://storefront.personalizer.io/v1/youmaylike?fallbackToRelatedItemIdentifiers=6429681385621&fallbackToPopular=true&excludedItemIdentifiers=6429681385621&host=Product&limit=20&fields=Identifier,Title,Vendor,DisplayUrl,Price,OriginalPrice,ImageUrl&t=1611727479897" 第二步返回“You May Like”的商品
3. "POST https://storefront.personalizer.io/v1/activityLogs?batch=true&t=1611727479926" 第三步埋点，他们有加一个request payload（event名称、来源、商品id）

## 实践

以 section 方式引入页面的模块，在主题编辑器 sidebar 里会自动生成一个卡片，标题为 section 的文件名称

### Shopify Scripts

Scripts 为商店提供了一种编写可在 Shopify 服务器上运行的自定义 Ruby 的方法，并从根本上影响购物车。

+ 工作方式是接收一个 input 购物车，对订单项执行转换，然后返回 output 购物车。
+ Scripts 是独立的，无法进行任何外部 API 或数据库调用，来获取其他信息。
+ 只有 Shopify Plus 商家可以在生产环境中使用
+ Shopify partners可以您创建的任何开发商店中对其进行测试

[官方博客](https://www.shopify.com/partners/blog/109804486-getting-started-with-shopify-scripts-a-practical-walkthrough)

在 theme.liquid 文件里加一个 `{{ template }}` 全局变量，可以在页面上输出渲染所采用的 template 名称（不含文件后缀 .liquid）

liquid 模板中可用的 Shopify 标签，变量和属性的完整列表，看这里[Shopify Cheat Sheet](https://www.shopify.com/partners/shopify-cheat-sheet)

using a Shopify app to dynamically add content to your store https://www.littlestreamsoftware.com/labs/add-content-to-a-shopify-template-through-the-api/

sync content between your stores

### snippet

+ 用于代码复用的 chunk
+ 以 `.liquid` 为文件后缀名
+ 使用 `{% render "snippet-filename" %}` 引入 template，不含文件后缀名
+ 可用于条件加载
+ 命名规范：所有snippets文件都放在“snippets”目录下，因此以它们的功能作为前缀。如：collections-coffee-cups.liquid

#### handle

Shopify liquid 中每个 object 都有唯一的 _handle_。默认情况下，handle 是对象的标题，URL-safe的表现形式。全小写，空格和特殊字符均用连字符（-）代替。

因为唯一，可以方便地在模版里用于比较。

`product` 的 handle 以商品标题自动创建。

### 获取未取消订单数据

  https://*.myshopify.com/admin/orders.json

发现一个有意思的点，即使用这种方式拿到别人订单的 token，访问 `https://<店铺前台域名>/<storeId>/orders/<token>`，页面上也读不到订单的 id 等信息。

访问自己的订单状态页，如果在 Settings-》Checkout-〉Order processing-》Additional scripts 里使用了 Shopify liquid 变量取数，渲染的页面上 Shopify.Checkout 才会有值（如果：订单 id）。

### Liquid实现功能

#### 控制商品 color 显示个数

当商品有很多 color 时，在商品列表里颜色 swatch 会换行，看起来不整齐。

以下 snippet 提供了一个通用解决方案：支持在 theme editor 里开启/关闭 swatch limit 功能；可设置最多显示多少种颜色；see more 显示剩余的 color 数量，点击 see more 跳转至商品详情页面。

```liquid
{%- liquid
  assign get_color = 'color,colors,couleur,colour'
  assign pr_options_name = product.options
  for option_name in pr_options_name
	  assign name = option_name | downcase
	  if get_color contains name
	    assign color_index = forloop.index
	    break
	  endif
  endfor
  assign n_option = 'option'| append: color_index
  assign pr_variants = product.variants
  assign color_variants = pr_variants | map: n_option | uniq
  if settings.enable_swatch_limit
    assign swatch_limit = settings.swatch_limit
  else
    assign swatch_limit = 1000
  endif
-%}

{%- if product.options.size > 0 and product.variants.size > 1-%}
  {%- for color in color_variants limit:swatch_limit -%}
    {%- assign color_handle = color | handleize -%}
    {%- assign img_arry = pr_variants | where: n_option, color -%}
    {%- assign variant = img_arry[0]  -%}
    <img src="{{ variant.image.src | product_img_url: grid_image_width }}" alt="{{color}} thumbnail" />
  {%- endfor -%}
  {%- assign color_size = color_variants | size -%}
  {%- if settings.enable_swatch_limit and color_size > swatch_limit %}
    <span title="See More">
      <a href="{{ product.url | within: collection }}">+{{ color_size | minus: swatch_limit }}</a>
    </span>
  {% endif -%}
{%- endif -%}
```

#### 翻译商品 option 名称

在对应语言的 locale 文件里，按这个路径添加翻译词条。

```liquid
{%- for option in product.options_with_values -%}
  {%- assign name = option.name | downcase -%}
  {%- assign t_name = name | prepend: "products.product.option_name." | t -%}
  <span style="text-transform:uppercase;">{{t_name}}</span>
{%- endfor -%}
```

#### script标签 js 代码里读当前店铺货币符号

直接用 currency.symbol 是不行的，因为店铺可以有多种currency。如果输出值类型为 string，则必须使用 json filter 进行 stringify.

```liquid
<script>
const currency_symbol = {{cart.currency.symbol | json}}
</script>
```

### Shopify App CLI

-》安装 shopify 命令行工具
-〉创建新项目

  shopify create node

-》开启本地开发服务器

  shopify serve

-〉终端里另打开一个tab页，自动完成浏览器打开app，并安装进开发店铺

  shopify open

谷歌搜索 Shopify GraphiQL App，安装给指定店铺，方便进行调试。

## 多店铺使用统一主题

只维护一个中心主题，保持brand uniformity品牌统一，同时节省时间。

有工具（如 PageFly）可以在多个Shopify店铺之间导出/导入模版。

## 安装 Shopify GraphiQL App

安装地址：https://shopify-graphiql-app.shopifycloud.com/

如果Shopify account绑定多家店铺，建议使用无痕浏览模式打开此链接。

在安装页输入需要绑定的店铺url，为避免后续 access denied，勾选所有 access scoped 的 read 权限

## 多语言

普通plan店铺最多可以published 5 个 locales，plus店铺最多可支持20种语言。官方文档：https://help.shopify.com/en/manual/cross-border/multilingual-online-store

划重点：If your Shopify store is on the Shopify plan, the Advanced Shopify plan, or the Shopify Plus plan, then you need to assign newly published languages to a domain in your online store for them to appear on your storefront. 我们plus的店铺需要把新增的语言assign给店铺的domain，才能出现在店面。You must complete this task even if you're only using a single domain. 即便只使用一个domain，也必须要完成这个操作。

[可以翻译的资源类型](https://shopify.dev/docs/admin-api/graphql/reference/translations/translatableresourcetype)，如：商品信息、email通知

### 关于locale

属性name和endonym_name的区别：`locale.name` 会随当前语言改变（以当地语言显示）。

```
{% for locale in shop.published_locales %}
  {{ locale.name }} - {{ locale.endonym_name }} ({{ locale.iso_code }})
{% endfor %}
```

当前语言选英语时，输出：

```
English - English (en) French - français (fr)
```

当前语言选法语时，输出：

```
anglais - English (en) français - français (fr)
```

### url

当通过 Shopify admin API 发布一个locale，Shopify自动为这个locale创建一个path。如："店铺域名/fr/pages/contact-us"。Liquid生成的route包含了locale，官方建议避免在主题里hardcoding url。

### SEO

当发布一个local，Shopify通过 `{{ content_for_header }}` 自动插入 hreflang tags。搜索引擎使用 hreflang 标记，根据搜索者的语言偏好，在搜索结果中提供正确语言的URL。如果搜索者的语言偏好没有匹配上任何一个 hreflang 标记，则使用店铺的primary locale

## VS Code配置

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

## Online Store 2.0

### 升级主题结构

sections：

每个页面的section新的工作方式：每一种类型的页面都可以使用一个JSON模版文件来渲染。这个文件列出页面的sections，商家添加或编辑的任何附加sections相关的设置数据。

店铺可以拥有多个模版文件，以匹配不同的商品、collection、blog post和自定义的页面。

theme app extensions

解决当前apps很难构建在所有主题中都能一致运行并且在世界任何地方都可以快速运行的功能。

1.app blocks标志着应用被添加进主题方式的根本性变化（app开发者现在可以通过theme editor直接添加、移除和配置UI组建），这意味着uninstall也是更加干净的。通过Shopify CLI轻松地创建、发布和更新（带版本号）
2.app支持性的资源文件添加进theme app extensions（放在Shopify的CDN上），在app block中可以方便第引用。

### 灵活的店铺内容

metafields

升级后的theme editor允许商家无需使用APIs或代码来添加metafields和属性。现在可以通过metafields（元字段）添加任何不太可能出现在核心商店编辑器中的内容，如一个尺码标、配料表

+ 更加灵活的类型系统，它会随着时间的推移而增长以更加适合商业数据
+ 引入标准元字段，这使得自定义主题在不同垂直市场的商店中开箱即用变得更加简单
+ 可以向元字段添加演示提示，允许 Storefront API 和 Liquid 以商家预期的方式呈现商家数据

File picker

元字段现在支持图片、pdf的资源，通过文件选择器可以在商品页面轻松地实现上传、选择资源文件（所有资源都保存在Settings/Files空间）

File API

新的文件API使得开发者也能获取Settings/Files中的内容访问权限。apps同理可以通过这个api，将与商品没有直接关系而在主题里使用到的图片存储到这个空间。

### 主题编辑器的增强

现在编辑器在侧边栏中以树视图显示页面上所有内容，使商家方便地更新页面的层级结构。

新的Liquid输入设置将允许商家从编辑器里直接给也没添加custom liquid代码。开发者可以给section或block添加这个设置。（给运营赋能过多，对于由开发团队来维护和定制店铺主题，最终主题代码的权限还是收口在开发手里，所以这个新功能很鸡肋）

### 新的开发者工具

Shopify GitHub integration

为了让主题的开发和维护更容易追踪和管理，通过连接GitHub用户账号或organization账号到在线店铺，GitHub repo的改变与所选主题当前的state同步。
开发者现在可以实施工作流程：在代码发布到live主题之前，必须在 GitHub 上审查和合并更改。
结合git subtrees可以执行theme check（linting）、编译scss等任务。

Shopify CLI

之前这个工具主要用来快速开发app和app插件，现在也包括theme了。
两个比较实用的点：
+ 可以使用官方的Dawn主题初始化新的主题项目
+ 向主题推送测试数据，如商品、客户和草稿订单
+ 在development themes里开发、预览和测试变更

Development themes

与Shopify store连接、暂时隐藏的主题，用来在本地开发实时查看changes，同时可以使用theme editor进行交互/配置。

使用 `shopify theme serve` 在当前工作店铺里自动创建测试主题.

+ 在admin-》themes页面不可见，不用担心其他人修改
+ 不算入店铺主题limit里
+ 7天不活跃则被删除，也可以运行命令删掉

Theme Check

一个帮助debug主题问题，显示error提示的公交，与Shopify CLI捆绑在一起。可以与vscode集成，标示Liquid语法错误、templates缺失、性能问题等。

### 新的初始主题Dawn

Dawn 主题伴随 Online Store 2.0 一起发布，不再依赖polyfills和外部库，在所有浏览器里创造优良体验，比Debut主题快35%。

### 主题和app更新到OS 2.0

到今年年底，Shopify 主题商店中的所有主题和 Shopify 应用商店中的apps都将需要使用新的基础架构。

商家现有的主题在今年之后可以继续使用，但要通过主题编辑器访问新的 Online Store 2.0 功能，需要确保这些的主题与 Online Store 2.0 兼容。
