---
title:  "Shopify独立站实践（2）"
category: Other
---
{% raw %}
## Shopify Liquid

先了解一些知识点，然后总结了一些使用 Shopify Liquid 实现的功能。

### liquid objects

在 theme.liquid 文件里加一个 `{{ template }}` 全局变量，可以在页面上输出渲染所采用的 template 名称（不含文件后缀 .liquid）

### snippet

+ 用于代码复用的 chunk
+ 以 `.liquid` 为文件后缀名
+ 使用 `{% render "snippet-filename" %}` 引入 template，不含文件后缀名
+ 可用于条件加载
+ 命名规范：所有 snippets 文件都放在“snippets”目录下，因此以它们的功能作为前缀。如：collections-coffee-cups.liquid

### handle

Shopify liquid 中每个 object 都有唯一的 _handle_。默认情况下，handle 是对象的标题。以 URL-safe 的表现形式：全小写，空格和特殊字符均用连字符（-）代替。

因为 handle 的唯一性，可以方便地在模版里用于比较。

商品 `product` 的 handle 是根据商品标题自动创建的。

### 控制商品 color 显示个数

当商品有很多 color 时，在商品列表里颜色 swatch 会换行，看起来不整齐。

以下 snippet 提供了一个通用解决方案：支持在 theme editor 里开启/关闭 swatch limit 功能；可设置最多显示多少种颜色；see more 显示剩余的 color 数量，点击 see more 跳转至商品详情页面。

```liquid
{%- liquid
  assign color_count = 0
  assign color_name = "color,couleur,colour,farbe"
  for option in product.options_with_values
    assign name = option.name | downcase
    if color_name contains name
      assign color_count = option.values.size
      if settings.show_color_type == '2'
        assign nt_option = 'option'| append: forloop.index
        assign color_variants = product.variants | where: "available" | map: nt_option | uniq
        assign color_count = color_variants.size
      endif
      break
    endif
  endfor
  assign img_variants = product.variants | where: "featured_image"
  if settings.enable_swatch_limit
    assign swatch_limit = settings.swatch_limit
  else
    assign swatch_limit = 1000
  endif
-%}

{%- unless color_count > 0 -%}{% continue %}{%- endunless -%}
<div>
{%- if img_variants.size > 0 -%}
  {%- for color in color_variants limit:swatch_limit -%}
    {%- assign img_arr = img_variants | where: nt_option, color -%}
    {%- assign cl_handle = color | handle -%}
    {%- assign image = img_arr[0].featured_image -%}
    <div>
      <img src="{{ image | img_url: '100x' }}" alt="{{color}} thumbnail" />
    </div>
  {%- endfor -%}

  {%- if settings.enable_swatch_limit and color_count > 6 %}
    <div>
      <a href="{{ product.url | within: collection }}">+{{ color_size | minus: swatch_limit }}</a>
    </div>
  {% endif -%}
{%- endif -%}
```

### 翻译商品 option 名称

```liquid
{%- for option in product.options_with_values -%}
  {%- assign name = option.name | downcase -%}
  {%- assign t_name = name | prepend: "products.product.option_name." | t -%}
  <span>{{t_name}}</span>
{%- endfor -%}
```
然后在对应语言的 locale 文件里，按这个路径添加翻译词条。

### 多国家

获取当前店铺货币符号、国家代码、语言标识：

```liquid
<script>
var CURRENT_CURRENCY_SYMBOL = {{ cart.currency.symbol | json}}
var CURRENT_COUNTRY_CODE = {{ localization.country.iso_code | json }};
var CURRENT_LANGUAGE_CODE = {{ request.locale.iso_code | json }};
</script>
```

直接用 currency.symbol 是不行的，因为店铺可以有多种currency。如果输出值类型为 string，则必须使用 json filter 进行 stringify.

对于 Shopify Plus 用户，Shopify 使用 geolocation 检测用户地理位置，自动选择商家 enabled 的可选国家/地区里最接近的。如：通过英国IP访问支持多国的美国店铺，country select组件默认选中英国。

通过 localization liquid 对象得到当前选择的国家代码，形如：'GB'。

### 多语言

普通 plan 店铺最多可以 published 5 个 locales，Shopify plus 店铺最多可支持**20**种语言。[官方文档](https://help.shopify.com/en/manual/cross-border/multilingual-online-store)

划重点：If your Shopify store is on the Shopify plan, the Advanced Shopify plan, or the Shopify Plus plan, then you need to assign newly published languages to a domain in your online store for them to appear on your storefront. plus 的店铺需要把新增的语言 assign 给店铺的 domain 才能出现在店面。

You must complete this task even if you're only using a single domain. 即便只使用一个domain，也必须要完成这个操作。

[可以翻译的资源类型](https://shopify.dev/docs/admin-api/graphql/reference/translations/translatableresourcetype)，如：商品信息、email通知。

#### 关于locale

属性 name 和 endonym_name 的区别：`locale.name` 会随当前语言改变（以当地语言显示）。

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

#### url

当通过 Shopify admin API 发布一个 locale，Shopify 自动为这个 locale 创建一个path。如："店铺域名/fr/pages/contact-us"。Liquid 生成的 route 包含了locale，官方建议避免在主题里 hardcoding url 的值。

#### SEO

当发布一个local，Shopify通过 `{{ content_for_header }}` 自动插入 hreflang tags。搜索引擎使用 hreflang 标记，根据搜索者的语言偏好，在搜索结果中提供正确语言的URL。如果搜索者的语言偏好没有匹配上任何一个 hreflang 标记，则使用店铺的 primary locale。

### 自定义section

官方文档 https://www.shopify.com/partners/blog/how-to-create-your-first-shopify-theme-section

手动改template的json文件可以正常渲染，但是在online theme editor里点 "add section" 却找不到自定义好的section？

解决：在 section 文件的 schema tag 的 json 对象里添加：

```json
"presets": [
  {
    "name": "自定义section的名称",
    "category": "Custom"
  }
]
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