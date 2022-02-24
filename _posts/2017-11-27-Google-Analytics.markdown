---
title:  "Google Analytics 埋点"
category: Other
---
几个术语：

- **pageview**，也称page tracking hit，一个页面只要在浏览器中被 loaded 或 reloaded 一次，就算为一个 pageview。
- 会话(**session**)，指用户在网站或 app 上 active 的时间 period。如果用户超过30分钟 inactive，之后的行为归于新的 session 中。30分钟内离开又返回，归于 original session。ga统计维度中的 Sessions，代表了网站所有用户触发的独立会话数
- **unique pageview**，合并了一个相同的用户在同一个会话中的 pageview。（取决于用户数、会话数）
- **users**，在给定日期范围中，一个用户触发的 initial session 视为一个 additional session 以及一个 additional user. Any future sessions from the same user during the selected time period are counted as additional sessions, but not as additional users.
- 活跃用户数，一般定义有关键动作或者行为达到某个要求时的用户为活跃用户；每个网站应该根据自身的产品特定定义活跃用户。比如社交应用，必须登录进去才能算活跃，因为如果用户停留在登录界面，实际上是没有任何意义的。
- sampling（采样），ga通过对子集采样，以较小的计算负担和减少的处理时间，分析生成与全集相似的结果。

活跃用户用于分析网站真正掌握了多少有价值用户。常见的有 DAU 日活用户数、MAU 月活用户数

官方文档[gtag.js](
https://developers.google.com/analytics/devguides/collection/gtagjs/)

<!--more-->

### 如何识别用户

gtag.js uses cookies to identify unique users across browsing sessions.

```js
gtag('config', 'GA_TRACKING_ID', {
  'cookie_name': '_ga',
  'cookie_domain': auto,
  'cookie_expires': 63072000 // two years, in seconds
});
```
cookie必须设置在当前域名的祖先域名下。

For example, if your domain is **one.two.three.root.com**, you may configure the cookie to be set on **root.com**

Setting an incorrect cookie domain will result in no hits being sent to Google Analytics.

一般无需单独设置，用户访问被ga追踪的网站时，会被自动种入cookie，来标识唯一身份。

用于标示用户唯一身份的 cookie 值 _ga、 _gid。区别：前者有效期2年，后者为24小时。https://developers.google.com/analytics/devguides/collection/gtagjs/cookie-usage

关于 `_ga=GA1.2.769523605.1615186022` [值构成的解释](https://stackoverflow.com/a/16107194)

### Page tracking

衡量某个页面被浏览的次数。默认全局设置的 tacking snippet会自动 sends a pageview to the Google Analytics。

可自定义的参数如下：

```js
gtag('config', 'GA_TRACKING_ID', {
  'page_title': 'homepage',
  'page_location': 'http://foo.com/home',
  'page_path': '/home'
});
```

因为当前项目主要是[SPA](https://developers.google.com/analytics/devguides/collection/gtagjs/single-page-applications)，where the site loads new page content dynamically rather than as full page loads, the gtag.js snippet code only runs once.

This means subsequent (virtual) pageviews must be tracked manually as new content is loaded. 当新内容加载时要手动跟踪。

When your application loads content dynamically and updates the URL in the address bar, the page URL stored with gtag.js should be updated as well.

```js
gtag('config', 'GA_TRACKING_ID', {'page_path': '/new-page.html'});
```

## Event tracking

用法：

```js
gtag('event', 'event_name', {
  // Event parameters
  'parameter_1': 'value_1',
  'parameter_2': 'value_2',
  // ...
})
```

参数：

- action，必选，**事件操作**，默认为 event_name，即 type of event。要与 report 数据相关；集合或区分 interface
- event_category，**事件类别**，理解为 web object，
- event_label，**事件标签**，可选，建议设置，提供 event 的 additional 信息
- value，为非负整数（上面都为string）

注意：

+ Many browsers stop executing JavaScript as soon as the page starts unloading, which means your gtag.js commands to send events may never run.
+ 事件衡量会将两个不同类别中具有**相同操作名称**的指标**合并**在一起。如果您将操作名称“Click”同时用于“Downloads”类别和“Videos”类别，那么“热门操作”报告中有关“Click”的指标会同时包含使用该名称标记的所有互动。
+ 为了汇总或区分用户互动，在使用操作名称时注意全局性。例如：使用操作名称来区分不同的播放器界面，而无需创建单独的视频类别。这样报告就可以区分两个播放器，同时仍然保留了显示网站上所有视频汇总数据这一优势。
+ 维度，类似特质、属性、分类，通常会出现在表格最左边的纵轴栏位，用来区隔数据。
+ 指标，则类似数值、数字，通常会是表格最上方的横轴栏位，就是行为数据本身。

```js
// Adds a listener for the "submit" event.
form.addEventListener('submit', function(event) {

  // Prevents the browser from submitting the form
  // and thus unloading the current page.
  event.preventDefault();

  // Sends the event to Google Analytics and
  // resubmits the form once the hit is done.
  gtag('event', 'signup_form_complete', {
    'event_callback': function() {
      form.submit();
    }
  });
});
```

Whenever you put critical site functionality inside the event callback function, you should always use a timeout function to handle cases where the gtag.js library fails to load.
当你把重要的功能写在callback函数里时，需要设置timeout，以防gtag函数库加载失败

### 会话数计算

在GA 中，会话结束包括两种方法：

- 基于时间的到期：30min 不活跃（持续30min 用户与网站无interaction），end of day 凌晨12点
- 基于 Compaign (traffic source)的改变

如果当前session还未过期，用户通过 search engine 或者 referral website 再次来到网站上时，前一次 session 将结束，并将开启一次新的 session。当然，如果用户是通过一个新的 compaign 再次来到网站，那么也会开启一次新的 session。而如果用户第二次的 source 为 direct 时，当前的 session 将不会结束。

之所以要设定好这些规则是为了归因分析。试想，一个用户如果通过搜索引擎（付费或者非付费的方式）来到该站点，存为书签离开了网站。在30min内，再次通过书签访问了这个网站，接着产生了转化行为。显然，用户这次的转化应该归功于session 刚开始的那个来源，即来自搜索引擎。

同样的，如果一个用户通过A 广告来到网站，30min内又通过B广告来到了网站，然后产生了转化行为。因为GA 中归因采用的是last click模型，如果用户通过B广告来到网站时，当前归属于A广告的session不结束，那么这次转化行为将归属于A广告，从用户实际是通过B广告到来后才产生转化的角度来看，将这次转化归因于A广告显然是不合理的。

#### 实践

统计login成功：同一台手机，30min内多次登录（case 1相同账号，case 2不同账号，case 3不同子域名/不同环境），活跃用户数始终为 1，事件数等于具体操作数，**与设备有关**，与账号无关，与测试环境无关。

### 数据视图

查看数据视图所显示数据的对应时区。左侧菜单栏底部“管理”-》展开页面内容选右侧的“数据视图设置”-》在“时区所在国家或地区”可见。

该设置用作报告的每日起止时间的国家/地区和时区，与数据来源于何处无关。例如，如果选择了美国洛杉矶时间，则无论命中是来源于纽约、伦敦还是莫斯科，每天的开始时间和结束时间都会按照洛杉矶时间来计算。

更改时区只会影响未来的数据，不会影响以前的数据。在更新完设置后，报告数据可能会在短期内继续采用旧时区，直到ga的服务器处理完更改。

## analytics.js是如何工作的？

最近需要给对接大数据的功能埋点，由于追踪脚本异步加载，会出现上报代码执行时脚本还没有加载完毕，导致部分事件漏上报。参考下ga实现来解决。官方[文档](https://developers.google.com/analytics/devguides/collection/analyticsjs/how-analyticsjs-works)

### 原理

define 一个全局的 `ga()` 函数，作为 command queue（指令队列），不会立即执行收到的命令，而是将它们添加到一个队列中，该队列会延迟执行，直到 analytics.js 库加载完毕。

在 JavaScript 中，函数也是对象，可以包含属性。 Google Analytics tag 将 ga 函数对象上的 `q` 属性定义为空数组。在加载 analytics.js 库之前，调用 ga() 函数会**将传递给 ga() 函数的参数列表附加到 q 数组的末尾**。

analytics.js 库加载完成后，检查 `ga.q` 数组的内容并按顺序执行每个命令。然后 redefine `ga()` 函数，后续调用会立即执行。

这提供了一个简单的、看起来是同步的接口，开发者书写上报代码时，无需考虑脚步的加载。

### 实现

第一个参数是 command（标识特定 analytics.js 方法的字符串）

特定命令所指的方法可以是全局方法，例如 `create`，ga 对象上的方法，也可以是跟踪器对象上的实例方法，例如 `send`。如果 ga() 命令队列接收到它无法识别的命令，直接忽略

新建 tracker 对象的实例，在 constructor 里依次执行 `q` 队列里的命令（第一条必须是 `create`，即初始化 Trace 对象，包含通用底层逻辑），然后 redefine 全局打点函数。

tracker 对象关键代码如下：

```js
init () {
  this.traceInstance = new Trace()
  window.wlt = this._bindThis(this.main, this)
}
_bindThis (fn: Function, obj: object) {
  return function() {
    fn.apply(obj, arguments)
  }
}
main (command: string, param: any) {
  switch(command) {
    case 'track':
      let p = { et: param, ...arguments[2] }
      this.traceInstance.Track(p)
      break
    case 'create':
      this.init(param)
      break
    default:
      break
  }
}
```

一个 Google Analytics Setup 官方推荐实践
https://philipwalton.com/articles/the-google-analytics-setup-i-use-on-every-site-i-build/

If performance is your primary concern, you could wait until your page has reached a key user moment (such as after the critical content has loaded) before adding async scripts.
如果性能是最关心的问题，可以等到页面到达一个关键用户时刻（例如加载关键内容之后），再添加异步脚本。
