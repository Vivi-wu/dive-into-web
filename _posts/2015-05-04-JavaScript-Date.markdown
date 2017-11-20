---
title:  "JavaScript Dates"
category: JavaScript
---
Date 对象用来与年月日时分秒毫秒打交道的。

## 创建 Date 对象

有**4种**初始化日期对象的方式：

`new Date()`，根据系统设定以 **current date and time**创建一个新的日期对象。（本地时区）

`new Date(milliseconds)`，按照 <span class="t-blue">zero time</span>（01 January 1970 00:00:00 UTC）加上参数创建新的日期对象。JS一天包含 86,400,000 millisecond

`new Date(dateString)`，按指定的日期字符串创建一个新的日期对象，dateString 格式参考下面讲的 Date formats

`new Date(year, month, date, hours, minutes, seconds, milliseconds)`，至少指定 year 和 month。如果其他参数都省略，则 date 为 1，剩下都为 0。

<!--more-->

## Date formats

通常JS有**4种**日期格式：

1.**ISO Dates**，ISO 8601 是用于表示日期和时间的国际标准，syntax (YYYY-MM-DD)。

缺省 month 和 date 比如 (YYYY-MM)，(YYYY) 也是允许的。

上面说了完整的日期对象有7个参数，这里**缺省的参数**将**按照最小值算**，date 为 1，剩下都为 0。

设定**完整**的日期时间 (YYYY-MM-DDTHH:MM:SS)

    var d = new Date("2015-03-25T12:00:00");    //Wed Mar 25 2015 20:00:00 GMT+0800 (CST)

日期和时间字符串中间的 _T_ 表示 **UTC time**. 北京时间（UTC+8）需要在这个时间上加8小时。

**Note**: _UTC_ (Universal Time Coordinated)  is the **same** as _GMT_ (Greenwich Mean Time).

2.**Long Dates**，通常写为 "MMM DD YYYY" 或者 "DD MMM YYYY"，月份可以是完整的英文单词，也可以是缩写。（January 和 Jan 都可以）。

+ 月份的英文字母**大小写不敏感**
+ commas are ignored，年月日之间可以加逗号分隔

3.**Short Dates**，通常写为 "MM/DD/YYYY" 或者 "YYYY/MM/DD"，记住一点，_月份 MM 必须写在 DD 几号前面_

4.**Full Format**

JS会忽略掉 day name（星期几）和 time 括号里面的错误，随便写，帮你更正。

```js
var d = new Date("Wed Mar 25 2015 09:56:24 GMT+0100 (W. Europe Standard Time)");
```

### 时区

设定日期时，如果不指定 time zone，JS会使用浏览器的时区。同理，获取日期时，如果不指定时区，结果会被转换成浏览器的时区。

## 显示日期

无论以何种日期格式输入，默认输出格式都是 full text string 格式：Sun May 04 2014 08:00:00 GMT+0800 (CST)

<span class="t-blue">Date objects are **static**, not dynamic. The computer time is ticking, but date objects, once created, are not.</span> 日期对象是静态的，一旦创建，就是一个常量，不会自己更新。

+ `toString()`，输出日期会自动转为一个字符串，不写也行。(_Tue Oct 18 2016 19:46:01 GMT+0800 (中国标准时间)_)
+ `toTimeString()`，把日期对象的时间部分转为字符串（_19:46:01 GMT+0800 (中国标准时间)_）
+ `toLocaleString()`，使用本地转换法，把日期对象转为字符串（_2016/10/18 下午7:46:01_）
+ `toLocaleTimeString()`，使用本地转换法，把日期对象的时间部分转为字符串（_下午7:46:01_）
+ `toLocaleDateString()`，使用本地转换法，把日期对象的日期部分转为字符串（_2016/10/18_）
+ `toISOString()`，使用 ISO 标准将日期对象转为字符串。格式为（_YYYY-MM-DDTHH:mm:ss.sssZ_），其时区 **always zero** UTC offset, 末尾的"Z"表示UTC时间.
+ `toJSON()`，将日期对象转为 <strong>JSON 日期格式</strong>的字符串（_2016-10-18T11:46:01.970Z_），格式同 toISOString()（ISO-8601 standard）.
+ `toUTCString()`，`toGMLString()`，根据世界时间将日期对象转为字符串（_Tue, 18 Oct 2016 11:46:01 GMT_）
+ `toDateString()`，converts the date (not the time **不含时间**) of a Date object into a readable string (结果为 _Tue Oct 18 2016_)

## Get Date

<table>
<thead>
  <tr>
    <th>方法</th>
    <th>描述</th>
  </tr>
</thead>
<tbody>
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
  <td>Date.UTC(year,month,date,hours,minutes,seconds,milliseconds)</td>
  <td>前三个参数是 required 的，该方法根据世界时间，返回自从1970年1月1日午夜开始到指定日期的毫秒数</td>
</tr>
</tbody></table>

In JavaScript, <span class="t-blue">the first (0) of the <em>week</em> means "Sunday"</span>，JS中的星期是<b>从星期天开始</b>。

`getDay()` 方法获得的是表示星期的数字，如果希望显示名称，可以这样做：

```js
var d = new Date();
var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
document.getElementById("demo").innerHTML = days[d.getDay()];
```

<span class="t-blue">JS中表示 <em>month</em> 的数字也是从 0 开始的</span>，January 一月对应数字是 0，December 十二月是 11。

## Set Date

通常拿到一个日期对象，改变这个日期的一部分。

<table>
<thead>
  <tr>
    <th>方法</th>
    <th>描述</th>
  </tr>
</thead>
<tbody>
<tr>
  <td>setDate()</td>
  <td>Set the day as a number (1-31)。输入值为整数，return <b>指定日期</b>与1970年1月1日0时0分0秒之间的<b>毫秒数</b>.</td>
</tr>
<tr>
  <td>setFullYear(year,month,date)</td>
  <td>Set the year (<b>optionally month and date</b>) 参数均为数字</td>
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

`setDate(n)` method can also be used to add days to a date. If adding days, **shifts the month or year**, the **changes are handled automatically by the Date object**. 计算距离指定日期**多少天以后**是几月几号星期几，JS会自动帮你跨月份甚至跨年份。

### Parsing Date

如果你有一个有效格式的日期字符串，使用 `Date.parse(dateString)` 方法可以得到距离 zero time 的毫秒数，然后使用 `new Date(milliseconds)` 就可以得到想要的日期对象了。

但是这种方法是 strongly **discouraged** due to browser differences and inconsistencies。

### Compare Dates

JS两个日期对象可以直接进行比较大小。

```js
function validDate (date) { // 判断输入的日期是否晚于今天
  var today = new Date(), tmp = new Date(date)
  return tmp > today
}
```

但是**不能**使用 `==` 操作符判断日期是否相等，因为 JS Object 的比较要check reference，不同日期对象的 reference 一定不相等。

解决办法：

```js
tmp <= today && tmp >= today // 相交的闭区间
tmp.getTime() === today.getTime() // 转成距离0时的毫秒数

```
