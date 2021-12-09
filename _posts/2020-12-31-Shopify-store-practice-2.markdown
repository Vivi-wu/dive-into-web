---
title:  "Shopify独立站实践（2）"
category: Other
---
{% raw %}
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

### 获取店铺商品总数

  https://*.myshopify.com/admin/products/count.json

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

Theme Deploy

`shopify theme push -i <theme_id>`

Theme Download

`shopify theme pull -i <theme_id>`

可以看到主题配置变更是直接保存在相关页面的json文件里，如：修改商品尺码表按钮文案，改动保存在 product.json，而不是之前的 setting_data.json

### 新的初始主题Dawn

Dawn 主题伴随 Online Store 2.0 一起发布，不再依赖polyfills和外部库，在所有浏览器里创造优良体验，比Debut主题快35%。

### 主题和app更新到OS 2.0

到今年年底，Shopify 主题商店中的所有主题和 Shopify 应用商店中的apps都将需要使用新的基础架构。

商家现有的主题在今年之后可以继续使用，但要通过主题编辑器访问新的 Online Store 2.0 功能，需要确保这些的主题与 Online Store 2.0 兼容。

从2021年9月7日开始，所有提交的需要集成到主题里的新app都要使用theme app extension。
{% endraw %}