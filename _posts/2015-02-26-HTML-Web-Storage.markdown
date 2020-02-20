---
title:  "HTML Web Storage"
categories: [HTML, JavaScript]
---
浅谈 Web 前端 Client side storage。更新参考这篇[An Overview of Client-Side Storage](https://bitsofco.de/an-overview-of-client-side-storage/)。

目前有四种 active 的方式：Cookies，Local Storage，Session Storage，IndexedDB。

## Cookies

Cookies 是一种经典地存储简单 string 数据的方式。由 server 发给 client，然后 client 保存在本地，下次请求再传回 server。这样 server 可以管理帐户 session，追踪用户信息。

<!--more-->

它也可以用来存储纯客户端的数据，比如用户偏好。具体操作见 JS BOM 章节 Cookies 部分。

优势：

1. 可用于与 server 的通信
2. 可设置自动过期时间，不需要手动删除

劣势：

1. 存储数据量小（大约4KB多数据）
2. 只能存 string
3. 潜在安全问题[Cookies and security](https://www.nczonline.net/blog/2009/05/12/cookies-and-security/)
4. 自从 Web Storage API 出来它不再是推荐的客户端存储方法

## Local Storage

_window.localStorage_ 是 H5 Web Storage API 之一，区别于 Cookies，存储的数据不会发给 server，可以被同源的每个窗口或标签页共享。

可以省略 window 对象使用，因为 storage 对象可以从默认的页面上下文中获得。

存储的数据不会因为浏览器关闭而删除，如没有干预，将一直有效。

例外：如果用户使用“私有/隐私保护”模式的进行浏览，那么在浏览器关闭后，_localStorage_ 中的值将不会保存。因为**使用了这种模式的用户已经明确选择不留痕迹**。

操作方法：

```javascript
const user = { name: 'Vivienne', age: 25 }

// Create
localStorage.setItem('user', JSON.stringify(user));

// Read (Single)
JSON.parse(localStorage.getItem('user'))
// 如果 key 不存在，返回 null 

// 也可以使用以下方法 create／read
localStorage.lastname = "Smith";  
localStorage['lastname'] = "Smith"; 

// Update
const updatedUser = { name: 'Vivienne', age: 24 }  
localStorage.setItem('user', JSON.stringify(updatedUser));

// Delete
localStorage.removeItem('user');

// 获取所有key名
Object.keys(localStorage)
```

优势：与 Cookies 对比

1. 更简单直观地操作接口
2. 更安全（数据不会在网络上传输）
3. 存储更多数据（至少5MB）

劣势：

<span class="t-red">只允许存储 String</span>，但我们可以存储 stringified JSON，实现存储复杂数据。

## Session Storage

_window.sessionStorage_ 是 H5 Web Storage API 第二种类型，用法、优劣势、支持性都同 localStorage。区别：数据只为 browser tab session 存储（即数据只在构建它们的窗口或标签内可见）。

补充：

+ clear() 函数删除存储列表中所有的数据，空的 Storage 对象调用此函数也是安全的，只是不执行任何操作。 
+ 如果用户已关闭了网站的存储，或存储达到其最大的容量，此时设置数据将抛出 QUOTA_EXCEEDED_ERR 错误。
+ 只要有同源的 Storage 事件发生（包括 SessionStorage 和 LocalStorage 触发的事件），已注册的所有事件侦听器作为事件处理程序就会接到相应的 Storage 事件。该事件中包含与存储变化有关的信息。如果是新添加的数据，则 oldValue 属性值为 null；如果是被删除的数据，则 newValue 属性值为 null。
+ 关闭当前tab可以自动清除sessionStorage，但登出操作在同一个tab页进行，故需要手动清除.

## IndexedDB

目前支持性不如 Web Storage API。

优势：

1. 可处理更复杂、结构化的数据
2. 可拥有多个 databases，每个数据库里可有多个 tables
3. 存储更多数据
4. 更多交互上的控制

劣势：

比 Web Storage API 用起来复杂。
