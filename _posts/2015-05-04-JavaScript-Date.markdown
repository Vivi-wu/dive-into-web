---
title:  "JavaScript Dates"
category: JavaScript
---
Date 对象用来与年月日时分秒毫秒打交道的。

## 创建 Date 对象

有**4种**初始化日期对象的方式：

`new Date()`，创建一个新的日期对象 with **current date and time**，当前的日期和时间

`new Date(milliseconds)`，按照 <span class="blue-text">zero time</span>（01 January 1970 00:00:00 UTC）加上参数创建新的日期对象。JS一天包含 86,400,000 millisecond

`new Date(dateString)`，按指定的日期字符串创建一个新的日期对象，dateString格式参考下面讲的 Date formats

`new Date(year, month, day, hours, minutes, seconds, milliseconds)`，按7个参数的顺序创建指定日期和时间的日期对象。

<!--more-->

## Date formats

通常JS有**4种**日期格式：

1.**ISO Dates**，ISO 8601 是用于表示日期和时间的国际标准，syntax (YYYY-MM-DD)。JS prefer 这种格式，当然缺省 month 和 day 比如 (YYYY-MM)，(YYYY) 也是允许的。

上面说了完整的日期对象有7个参数，这里缺省的参数将按照最小值算。没有指定 day，就算 1号，没有指定 month，就是 1月1日。

设定完整的日期时间 (YYY-MM-DDTHH:MM:SS)

    var d = new Date("2015-03-25T12:00:00");    //Wed Mar 25 2015 20:00:00 GMT+0800 (CST)

The _T_ in the date string, between the date and time, indicates UTC time.

**Note**: _UTC_ (Universal Time Coordinated)  is the **same** as _GMT_ (Greenwich Mean Time).

2.**Long Dates**，通常写为 "MMM DD YYYY" 或者 "DD MMM YYYY"，月份可以是完整的英文单词，也可以是缩写。（January 和 Jan 都可以）。

+ 月份的英文字母**大小写不敏感**
+ commas are ignored，年月日之间可以加逗号分隔

3.**Short Dates**，通常写为 "MM/DD/YYYY" 或者 "YYYY/MM/DD"，记住一点，_月份 MM 必须写在 DD 几号前面_

4.**Full Format**

JS会忽略掉 day name（星期几）和 time 括号里面的错误，随便写，帮你更正。

    var d = new Date("Wed Mar 25 2015 09:56:24 GMT+0100 (W. Europe Standard Time)");

### 时区

设定日期时，如果不指定 time zone，JS会使用浏览器的时区。同理，获取日期时，如果不指定时区，结果会被转换成浏览器的时区。

## 显示日期

无论以何种日期格式输入，默认输出格式都是 full text string 格式：Sun May 04 2014 08:00:00 GMT+0800 (CST)

<span class="blue-text">Date objects are **static**, not dynamic. The computer time is ticking, but date objects, once created, are not.</span> 日期对象是静态的，一旦创建，就是一个常量，不会自己更新。

+ `toString()`，输出日期会自动转为一个字符串，不写也行。
+ `toTimeSting()`，把日期对象的时间部分转为字符串（_15:19:06 GMT+0800 (CST)_）
+ `toLocaleSting()`，使用本地转换法，把日期对象转为字符串（_2015/05/04 下午3:20:54_）
+ `toLocaleTimeSting()`，使用本地转换法，把日期对象的时间部分转为字符串（_下午3:21:58_）
+ `toLocaleDateSting()`，使用本地转换法，把日期对象的日期部分转为字符串（_2015/05/04_）
+ `toISOSting()`，使用 ISO 标准将日期对象转为字符串。格式为（_YYYY-MM-DDTHH:mm:ss.sssZ_）
+ `toJSON()`，将日期对象转为 JSON 日期格式的字符串（_2015-05-04T07:23:23.047Z_），格式同上。
+ `toUTCString()`，根据世界时间将日期对象转为字符串（_Sun, 04 May 2015 07:29:18 GMT_）
+ `toDateString()`，converts the date (not the time) of a Date object into a readable string (结果为 _Sun May 04 2014_)

## Get Date

<table>
<tbody>
<tr>
  <th>Method</th>
  <th>Description</th>
</tr>
<tr>
  <td>getDate()</td>
  <td>Get the day as a number 一个月中的 (1-31) 几号</td>
</tr>
<tr>
  <td>getDay()</td>
  <td>Get the weekday as a number (<b>0-6</b>) 星期几</td>
</tr>
<tr>
  <td>getFullYear()</td>
  <td>Get the four digit year (yyyy) 哪一年</td>
</tr>
<tr>
  <td>getHours()</td>
  <td>Get the hour (0-23)</td>
</tr>
<tr>
  <td>getMilliseconds()</td>
  <td>Get the milliseconds (0-999)</td>
</tr>
<tr>
  <td>getMinutes()</td>
  <td>Get the minutes (0-59)</td>
</tr>
<tr>
  <td>getMonth()</td>
  <td>Get the month (<b>0-11</b>) 几月</td>
</tr>
<tr>
  <td>getSeconds()</td>
  <td>Get the seconds (0-59)</td>
</tr>
<tr>
  <td>getTime()</td>
  <td>Get the time (milliseconds since January 1, 1970)</td>
</tr>
<tr>
  <td>Date.now()</td>
  <td>返回自从 January 1, 1970 00:00:00 UTC 到现在的毫秒数</td>
</tr>
<tr>
  <td>Date.UTC(year,month,day,hours,minutes,seconds,milliseconds)</td>
  <td>前三个参数是 required 的，该方法根据世界时间，返回自从1970年1月1日午夜开始到指定日期的毫秒数</td>
</tr>
</tbody></table>

In JavaScript, <span class="blue-text">the first (0) of the <em>week</em> means "Sunday"</span>，JS中的星期是<b>从星期天开始</b>。

`getDay()` 方法获得的是表示星期的数字，如果希望显示名称，可以这样做：

    var d = new Date();
    var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
    document.getElementById("demo").innerHTML = days[d.getDay()];

<span class="blue-text">JS中表示 <em>month</em> 的数字也是从 0 开始的</span>，January 一月对应数字是 0，December 十二月是 11。

## Set Date

通常拿到一个日期对象，改变这个日期的一部分。

<table>
<tbody><tr>
  <th>Method</th>
  <th>Description</th>
</tr>
<tr>
  <td>setDate()</td>
  <td>Set the day as a number (1-31)</td>
</tr>
<tr>
  <td>setFullYear(year,month,day)</td>
  <td>Set the year (<b>optionally month and day</b>) 参数均为数字</td>
</tr>
<tr>
  <td>setHours()</td>
  <td>Set the hour (0-23)</td>
</tr>
<tr>
  <td>setMilliseconds()</td>
  <td>Set the milliseconds (0-999)</td>
</tr>
<tr>
  <td>setMinutes()</td>
  <td>Set the minutes (0-59)</td>
</tr>
<tr>
  <td>setMonth()</td>
  <td>Set the month (0-11)</td>
</tr>
<tr>
  <td>setSeconds()</td>
  <td>Set the seconds (0-59)</td>
</tr>
<tr>
  <td>setTime()</td>
  <td>Set the time (milliseconds since January 1, 1970)</td>
</tr>
</tbody></table>

`setDate()` method can also be used to add days to a date. If adding days, **shifts the month or year**, the **changes are handled automatically by the Date object**. 比如计算距离今天多少天以后是几月几号星期几。JS会自动帮你跨月份甚至跨年份。

### Parsing Date

如果你有一个有效格式的日期字符串，使用 `Date.parse(dateString)` 方法可以得到距离 zero time 的毫秒数，然后使用 `new Date(milliseconds)` 就可以得到想要的日期对象了。

### Compare Dates

JS两个日期对象可以直接进行比较大小。
