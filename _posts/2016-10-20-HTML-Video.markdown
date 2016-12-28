---
title:  "HTML Video"
category: HTML
---
IE9以下浏览器不支持 `<video>` Tant pis.

## 音频和视频

1. 视频文件（视频容器）包含了音频轨道、视频轨道和其他一些元数据（包含该视频的封面、标题、子标题、字幕等相关信息）。

2. 主流视频容器支持视频格式：Audio Video Interleave(.avi)、Flash Video(.flv)、MPEG 4(.mp4)、Matroska(.mkv)、Ogg(.ogv)

3. HTML5 Video 限制：全屏视频无法通过脚本控制。从安全性角度看，让脚本元素控制全屏操作是不合适的。如果要让用户在全屏方式下播放视频，浏览器可以提供其他控制手段。

4. 浏览器支持性检测：

        var hasVideo = !!(document.createElement('video').canPlayType);  // 动态创建一个video元素，然后检测 canPlayType()函数是否存在。

    通过‘!!'运算符将结果转换成布尔值。

5. 在 `<video>` 标签之间为不支持 HTML5 媒体多浏览器提供备选内容，如一段说明文字或其他插件方式播放视频。

<!--more-->

6. 对于来源，浏览器会按照声明顺序判断，如果支持其中不止一种，那么浏览器会选择支持的第一个来源。因此注意来源列表到排放顺序，按用户体验**由高到低**或服务器消耗由低到高大顺序列出。

7. 为 `<source>` 元素添加 _type_ 特性。如 type＝“audio/mpeg”。如果 type 特性中指定的类型与源文件不匹配，浏览器可能会拒绝播放。因为一个媒体容器可能支持多种类型的编解码器，声明的源文件扩展名可能会让浏览器误以为自己支持或不支持某种类型。

    举例：在 Ogg 容器中的 Theora 视频和 Vorbis 音频， type＝“video/ogg;codecs=‘heora, vorbis’“

8. 当视频加载完毕，准备开始播放的时候，会出发 `oncanplay` 函数执行预设的动作。

9. canvas 的绘图程序可以将视频源当做图像或者图案进行处理，当使用视频作为绘制来源时，画出来的只是当前播放的帧。

### 一个问题引发的学习

之前有用到觉得比较简单，一直没总结，今天老大问怎么避免 iPhone Safari 中全屏播放视频，谷歌找了下解决办法，亲自试验，得出了当前可行的 solution。

针对 iOS9（只测试了手上的iPhone4s），借助 [这个插件](https://github.com/bfred-it/iphone-inline-video){:target="_blank"}。

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

+ _autoplay_，值与属性同名，可不赋值。视频就绪马上播放。通常这样做有两个用途：制造背景氛围、强制用户接收广告。

	如果开发人员有足够的理由对页面的音频或视频使用 autoplay，一定要确保明确提供关闭自动播放的功能。

+ _controls_，值与属性同名，可不赋值。显示播放控件，如：播放、停止、跳播以及音量控制。

	如果不设置这个特性，对于音频，页面上将不会出现任何信息（因为音频元素的唯一可视化信息就是它对应的控制界面，此时可以用自从开发的控制界面来控制音频的播放）；对于视频，视频内容会照常显示。

+ _loop_，值与属性同名，可不赋值。文件播放到尾部时自动 seek back 到开始部分。
+ _muted_，值与属性同名，可不赋值。设置视频的音频输出为静音。
+ _poster_，值为 url。视频下载时或用户点击播放按钮前显示的图像。如果没有设置该特性，那么直到第一帧可用前，视频元素区域显示 nothing（空白），之后第一帧会作为 poster frame 显示。
+ _preload_，值与属性同名，可不赋值。视频在页面加载时进行加载，并预备播放。可取值为 `none` 不预加载，`metadata` 只获取基本信息如 length等，`auto` 下载完整视频文件，`""` 同 auto。

    **如果设定了 _autoplay_，则该属性失效**。

+ _src_，值为播放视频的 url。可以不指定，在 video 元素内嵌 `<source>` 元素，提供多视频源（为了兼容各种浏览器，至少需要提供 `.ogg` 和 `.mp4` 两种格式的视频源文件）。
+ _height_、_width_，取值为**数字**，以 CSS pixel 为单位（如果设置的宽度与视频本身大小不匹配，可能导致居中显示，上下或左右出现黑色条状区域）。

### HTML Video 对象的属性和方法

[属性列表](http://www.w3school.com.cn/jsref/dom_obj_video.asp)

只读的媒体特性：

+ _duration_（以 s 为单位，如果无法获取时长，则返回 `NaN`），
+ _paused_（如果媒体文件当前被暂停，返回 true。如果还未开始播放，**默认**返回 true），
+ _currentSrc_（以字符串形式返回当前正在播放或已加载到文件，对应于浏览器在 source 元素中选择的文件），
+ _ended_，
+ _startTime_（最早的播放起始时间，一般是 0.0，除非是缓冲过的媒体文件，并且一部分内容已经不在缓冲区），
+ _error_（出错时返回错误代码）

方法较少这里记一下：

+ `addTextTrack()`，给视频添加文本轨道
+ `canPlayType()`，检查浏览器可以播放的视频类型。
+ `load()`，重新加载视频。
+ `play()`，加载（有必要的话）并播放音频/视频文件。除非音频/视频已经暂停在其他位置，否则默认从开头播放。
+ `pause()`，暂停视频播放。
