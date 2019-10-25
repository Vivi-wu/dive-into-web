---
title:  "Google Analytics埋点"
category: Other
---
官方文档[gtag.js](
https://developers.google.com/analytics/devguides/collection/gtagjs/)

### 如何识别用户

gtag.js uses cookies to identify unique users across browsing sessions.通过cookie来识别会话的唯一用户

```js
gtag('config', 'GA_TRACKING_ID', {
  'cookie_name': '_ga',
  'cookie_domain': auto,
  'cookie_expires': 63072000 // two years, in seconds
});
```
The cookie_domain must be an ancestor of the current domain。cookie必须设置在当前域名的祖先域名下。

For example, if your domain is **one.two.three.root.com**, you may configure the cookie to be set on **root.com**

Setting an incorrect cookie domain will result in no hits being sent to Google Analytics.

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

- action，必选，默认为 event_name，即 type of event。要与 report 数据相关；集合或区分 interface
- event_category，事件类别，理解为 web object，
- event_label，事件标签，可选，建议设置，提供 event 的 additional 信息
- value，为非负整数（上面都为string）

注意：Many browsers stop executing JavaScript as soon as the page starts unloading, which means your gtag.js commands to send events may never run.

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
