---
title:  "Vue开发tips"
category: JavaScript
---
Vue.js 可以把数据绑定到 DOM 文本或特性，还可以绑定到 DOM 结构。通过添加事件监听器，处理用户输入。

通过所有的 DOM 操作都由 Vue 来处理，开发者只需编写处理逻辑层的代码。

Vue 组件类似于自定义元素——它是 Web 组件规范的一部分，因为 Vue 的组件语法部分参考了该规范。

<!--more-->

## Vue.js 2.2+

+ Windows系统文件名**不区分大小写**，当发生“can't find module xxx”错误时，检查下module引用的文件路径、文件名拼写、文件名大小写是否正确。
+ 通过Ajax请求新数据前，reset结果数据。
+ 如果使用vue绑定按钮的 _disabled_ 属性，则不要同时使用 HTMLElement.disabled，否则两者冲突，导致禁止失效。
+ Vue 不能检测以下变动的数组：

    vm.items[indexOfItem] = newValue
    // 解决办法：使用 Array.prototype.splice
    example1.items.splice(indexOfItem, 1, newValue)

+ HTML 元素的 _autofocus_ 特性在页面reload后执行一次，对于single page app不同tab页面里的输入域，如果希望切换tab时自动focus，则需要自定义指令：

    directives: {
      focus: {
        // 当绑定元素插入到 DOM 中。
        inserted: function (el) {
          // 聚焦元素
          el.focus()
        }
      }
    }

+ Vue 指令的预期值是**单个JS表达式**。当表达式的值改变时，响应式地**作用于DOM**。
+ 自定义指令通过 `binding.arg` 获取传给**指令的参数**（`v-my-directive:*` 冒号后面等号前面的内容）。

    div(v-translate:检查结果：需求数|个，|个符合条件，|个不符合条件='lang')

+ 在 HTML 中侦听 Vue 事件，事件名称必须是 camel-case，如 `@set-data`
+ 通过 `this.$el` 获取当前组件绑定的 HTMLElement
+ select 元素值为 primitive values, 而 option 的值是 object 时，通过绑定 select 的值，回填数据的方法不起作用。解决办法：在 option 元素上给 _selected_ 特性绑定 method，通过判断对象某属性的值是否与默认值一致，设置该 `<option>` 的 _selected_ 特性值为 `true`
+ 在 data 初始化时，对 object 型数组中 item 进行深层对象声明，避免加载时 console 报错【难道不能尝试换一种数据类型？？
+ 子组件 data 初始值依赖 props 传入的值：当 props 状态更新时，需要通过 watch 方法来更新 data，否则 data 不能自动更新。
+ Vue 不能检查到已创建的对象实例动态增加/减少 root-level 属性，即在 data 中初始值为 `{}` 的属性，空对象加减属性，都不会触发视图更新。解决办法：

    // 针对单个属性的添加
    Vue.set( target, key, value )
    // 针对单个属性的删除
    Vue.delete( target, key )
    // 批量新增属性
    this.someObject = Object.assign({}, this.someObject, { a: 1, b: 2 })
    // 子组件内使用 vm.$set，vm.$delete方法, 它们是 global Vue.set, Vue.delete 的 alias

+ 列表过渡时，使用 `<transition-group>` 元素作为 `v-for` 列表的父元素
+ 使用 v-move 或定义对应的 css 样式，使得过渡平滑
+ 通用组件设计思路：入参配置初始值，输出值交由外部组件做业务逻辑
+ pug 模板中自定义 vue 指令不能单独写，需指定空值：`v-table-has-sticky-thead=''`。如果不指定，则会被 pug 编译成 `v-table-has-sticky-thead='v-table-has-sticky-thead'`，导致 console 报错
+ emit事件传递多个参数：[链接](https://github.com/vuejs/vue/issues/5527)

    // 子组件
    this.$emit('emission', 1, 2, 3);
    // 父组件
    <component @emission="hearEmission">
    // 父组件如果希望新增额外参数，在 .vue 文件里支持spread syntax实现
    <component @emission="hearEmission('extra', ...arguments)">

+ vue 项目里使用 debounce 的方法 [官方用法](https://cn.vuejs.org/v2/guide/migration.html#%E5%B8%A6%E6%9C%89-debounce-%E7%9A%84-v-model%E7%A7%BB%E9%99%A4)
+ filter 注册写在 vue 实例初始化之后，刷新页面总数报 “can't resolve filter” 错，改为写在前面解决
+ 使用 `.sync` 修饰符减少父组件更新代码，但不要滥用

    // 子组件
    this.$emit('update:isShown', false)
    // 父组件
    <popover :isShown.sync='isShown'></poopover>

+ 通过 _ref_ 注册子组件信息，可以在父组件里通过 _$refs_ 调用子组件的方法。1.必须在子组件渲染后才有效；2. ref 用在单独的 DOM 元素或子组件上时，指向 DOM 元素或子组件实例；3.用作 v-for 上，则是包含 DOM 节点或子组件实例的数组。
+ `this.$refs[name]` 返回值为 Vue.component 或 [Vue.component] 组成的数组
+ this.$refs[name].data 可以获取子组件状态的实时值
+ Vue.js 异步执行 DOM 更新；当观察到数据变化时，Vue 将开启一个队列，并缓冲在同一事件循环中发生的所有数据改变。如果同一个 watcher 被多次触发，**只有一次**会推入到队列中。然后，在下一个的事件循环“tick”中，Vue 刷新队列并执行实际（已去重的）工作。Vue 在内部尝试对异步队列使用原生的 Promise.then 和 MutationObserver，如果执行环境不支持，会采用 setTimeout(fn, 0) 代替。
+ 让 Vue 忽略（console 不报 warning）自定义 HTML tag 的方法：

    Vue.config.ignoredElements = ['content-placeholder'] // 数组里是自定义tag名称

+ 在一个元素上同时使用 v-for 和 v-if，前者比后者有 higher priority，[详细解释](https://vuejs.org/v2/style-guide/#Avoid-v-if-with-v-for-essential)。如果希望有条件地**跳过**循环的执行，那么将 v-if 置于外层元素 (或 `<template>`)上
+ 使用 v-if 控制显示的 input 框输入值没有 reset。原因： Vue 会使用一种最大限度减少动态元素并且尽可能的尝试修复/再利用相同类型元素的算法。解决：在元素上加属性 `key`，它会基于 key 的变化重新排列元素顺序，并且会移除 key 不存在的元素。
+ 表格中一行的 button 按钮 disabled 属性值为 true，它上一行为 false，如果删除上一行，本行的按钮 disabled 也会变成 false，尽管 vue 状态没变。解决：在本行按钮元素上加 key
+ 在 .vue 文件的模板中书写图片等资源路径使用 webpack 配置的 alias 的[方法](https://github.com/vuejs/vue-loader/issues/193):

    <img src="~images/logo.png">
+ .vue 文件引入其他sass文件，注意不要忘记行尾的分号。

    @import '~scss/_variables.scss';

+ 表格组件纯文本展示时，可以提供一个配置字典，thead 和 tbody 都根据此配置有序输出。比分别提供thList，再一个td一个写要方便、安全（避免字段对错）。
+ 多个子组件调用同一个接口提交数据时，可以把各自的reset函数也通过 $emit 事件传给父组件，在ajax响应成功后执行。

```js
/**
 * 提交更改基本信息
 * @param {object} data - 更新的数据
 * @param {function} fn - 回调函数 reset子组件状态
 */    
submit (data, fn) {
  axios.post(apiUrl, data)
  .then(res => {
    if (res.status !== 200) return
    fn()
  })
}
```
+ 涉及DOM操作，且组件内有模板更新，使用 vm.$nextTick() 
+ axios.catch().then()，跟在catch后面的then相当于 Promise 的 always
+ 打开弹窗时获取数据

```js
watch: {
  'isShown': 'initModal'
},
methods: {
  /**
   * 初始化弹窗
   * @param {boolean} val - 是否显示弹窗
   */
  initModal (val) {
    if (val) {
      this.fetchData()
    } else {
      // 重置状态
    }
  },
}
```
+ 支持 /deep/ 选择器，在父组件里设置子组件样式 [vue-loader](https://github.com/vuejs/vue-loader/issues/661)
+ 列表检索页loading和结果区域显示呈互斥关系，但不要用 v-if/v-else，会重复渲染组件。
+ 翻页、切换tab时要重置表格列 checkbox 的状态
+ 父组件里对 $emit 事件处理函数追加变量，通过 `$event` 访问到被子组件抛出的值

    // 子组件
    this.$emit('my-event', 'test')
    // 父组件：index为父组件变量，$event = 'test'
    @my-event='handler(index, $event)'

+ vm.$on(event, callback) 用来监听当前实例上的自定义事件。事件可以由vm.$emit触发。
+ 在 destroy() 勾子函数里执行 `window.removeEventListener`，对于侦听页面 onresize、onscroll事件

## vue-router

+ 在路由改变后获取数据的方法：

    watch: {
      // 如果路由有变化，会再次执行该方法
      '$route': 'fetchData'
    }
+ vue-router 中路由的 name 必须唯一，不区分父路由、子路由。
+ 只有 router-view 直接对应的组件内支持 `beforeRouteEnter()` 方法读取路由信息对象
+ 符合动态路由匹配（路由路径如 `/user/:username`）的 router-view 的子组件里，可以 watch route 变化执行一些操作。普通路由对应的 router-view 的子组件不行。采用动态路由的页面切换，两个路由都渲染同个组件，是直接复用。而普通路由的页面切换，是销毁再创建，因此注册在子组件的watch函数，永远不会执行。
+ 点击“面包屑”返回前，从 vuex 中取出当前列表查询参数对象，赋值给路由对象的 `query` 属性。这样返回列表查询页后，根据 URL 的 query string 可以回填历史查询、排序参数，reload 页面页不会因为 vuex 状态丢失这些参数。
+ 使用 `router.go(-1)` 实现返回上一页的功能
+ 路由信息对象 `this.$route` 对每个路由视图子组件都是可见的
+ router-link 绑定原生 click 事件处理函数：**通过.native**绑定原生事件

    router-link(:to='{ name: "to-request-bill" }' @click.native='gtagTest') 请款

+ `afterEach()` 全局后置钩子函数执行时 _location.href_ 还没有更新。
+ 使用路由名称进行跳转。

## Vuex

+ 默认情况下，vuex模块内部的 action、mutation 和 getter 是注册在全局命名空间的
+ 逻辑上应该相同的状态存放在不同组件里，将很难保证数据一致。如果由于某种 bug 导致某个组件中某状态与其他组件里该状态不一致，就会出现问题。于是 Flux、Redux之类提出 store 的概念，依靠全局状态作为唯一可靠数据源。
+ 利用 prop 在组件之间传递数据的问题：组件结构在三级或以上，底层组件想传数据给最底层组件，需通过多个中间组件。而这些中间组件可能根本不需要这个 prop，这样违反了低耦合的设计要求。
+ 子组件访问全局 getters 时使用 `rootGetters`
+ action只能接收最多2个参数，第二个参数 payload 可选，用户自定义传入数据。

## 构建

vue 有两种构建方式：独立构建和运行时构建。区别是“独立构建”包含模板编译器，而“运行时构建”不包含。模板编译器的职责是将模板字符串编译为纯 JavaScript 的渲染函数。

+ 独立构建支持 template 选项。 它也依赖于浏览器的接口的存在，所以不能用来做服务器端渲染
+ 运行时构建不支持 template 选项，只能用 render 选项。但即使使用运行时构建，在 .vue 单文件组件中依然可以写模板。因为单文件组件的模板会在构建时预编译为 render 函数
+ 运行时构建比独立构建要轻量
