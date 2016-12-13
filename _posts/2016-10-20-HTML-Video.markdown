---
title:  "HTML Video"
category: HTML
---
IE9以下浏览器不支持 `<video>` Tant pis.

### 一个问题引发的学习

之前有用到觉得比较简单，一直没总结，今天老大问怎么避免 iPhone Safari 中全屏播放视频，谷歌找了下解决办法，亲自试验，得出了当前可行的 solution。

针对 iOS9（只测试了手上的iPhone4s），借助 [这个插件](https://github.com/bfred-it/iphone-inline-video)。

<!--more-->

```css
video {height:auto;}
/* Native play buttons will still trigger the fullscreen, so it's best to hide them */
.IIV::-webkit-media-controls-play-button,
.IIV::-webkit-media-controls-start-playback-button {
    opacity: 0;
    pointer-events: none;
    width: 5px;
}
```

```html
<video playsinline src="rose.mp4"></video>
<script src="iphone-inline-video.browser.js"></script>
```

{% highlight javascript linenos %}
var video = document.querySelector('video');
video.width = window.innerWidth;
makeVideoPlayableInline(video);
video.addEventListener('touchstart', function () {
    video.play();
});
{% endhighlight %}

缺陷是该 JS 库有已知的 issue，且不支持多视频源（video元素里内嵌 source 元素），也不能使用原生的 _controls_ 特性。

针对 iOS10 及以上则可以使用 H5 的新属性原生支持：

```html
<video controls loop playsinline>
  <source src="rose.mp4">
</video>
```

参考：[iOS10 对于 HTML video 元素的使用放开了限制](https://webkit.org/blog/6784/new-video-policies-for-ios/)

### Video 特性

+ _autoplay_，值与属性同名，可不赋值。视频就绪马上播放。
+ _controls_，值与属性同名，可不赋值。显示播放控件，如：播放按钮。
+ _loop_，值与属性同名，可不赋值。文件播放到尾部时自动 seek back 到开始部分。
+ _muted_，值与属性同名，可不赋值。设置视频的音频输出为静音。
+ _poster_，值为 url。视频下载时或用户点击播放按钮前显示的图像。如果没有设置该特性，那么直到第一帧可用前，视频元素区域显示 nothing（空白），之后第一帧会作为 poster frame 显示。
+ _preload_，值与属性同名，可不赋值。视频在页面加载时进行加载，并预备播放。可取值为 `none` 不预加载，`metadata` 只获取基本信息如 length等，`auto` 下载完整视频文件，`""` 同 auto。

    **如果设定了 _autoplay_，则该属性失效**。

+ _src_，值为播放视频的 url。可以不指定，在 video 元素内嵌 `<source>` 元素，提供多视频源（为了兼容各种浏览器，至少需要提供 `.ogg` 和 `.mp4` 两种格式的视频源文件）。
+ _height_、_width_，取值为**数字**，以 CSS pixel 为单位。

### HTML Video 对象的属性和方法

[属性列表](http://www.w3school.com.cn/jsref/dom_obj_video.asp)

方法较少这里记一下：

+ `addTextTrack()`，给视频添加文本轨道
+ `canPlayType()`，检查浏览器可以播放的视频类型。
+ `load()`，重新加载视频。
+ `play()`，播放视频。
+ `pause()`，暂停视频播放。
