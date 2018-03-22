---
title:  "Vue开发tips"
category: JavaScript
---
## Vue.js 2.2+

+ Windows系统文件名**不区分大小写**，当发生“can't find module xxx”错误时，检查下module引用的文件路径、文件名拼写、文件名大小写是否正确。
+ 通过Ajax请求新数据前，reset结果数据。
+ 如果使用vue绑定按钮的 _disabled_ 属性，则不要同时使用 HTMLElement.disabled，否则两者冲突，导致禁止失效。
+ 子组件的数据由 props 设定（或依赖props传递的值），数值在子组件内部变更后，通过 `emit()` 事件把新的值向上传给父组件，由父组件更新相应的值。
+ Vue 不能检测以下变动的数组：

    vm.items[indexOfItem] = newValue
    // 解决办法：使用 Array.prototype.splice
    example1.items.splice(indexOfItem, 1, newValue)

<!--more-->

+ 项目主要元素的css样式放在 app.vue 文件的 `<style>` 标签里维护。让webpack处理样式的提取、打包和加时间戳。
+ HTML 元素的 _autofocus_ 特性在页面reload后执行一次，对于single page app不同tab页面里的输入域，如果希望切换tab时自动focus，则需要自定义指令：

    directives: {
      focus: {
        // 指令的定义---
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

+ Vue devtool inspection 在生产环境默认 disabled，所以在线上开发者工具里看不到 Vue devtool
+ 在 HTML 中侦听 Vue 事件，event name 必须是 camel-case，如 `@set-data`
+ 获取当前组件绑定的 HTMLElement 的方法： `this.$el`
+ Vue 实现深度 copy 对象型数组的方法：

    JSON.parse(JSON.strigify(myArray))

+ select 元素值为 primitive values, 而 option 的值是 object 时，通过绑定 select 的值回填数据的方法不起作用。解决办法：在 option 元素上给 _selected_ 特性绑定 method，通过判断对象某属性的值是否与默认值一致，设置该 `<option>` 的 _selected_ 特性值为 `true`
+ 在 data 初始化绑定时，对 object 型数组中 item 进行深层对象声明，避免加载时 console 报错
+ 列表过渡时，使用 `<transition-group>` 元素作为 `v-for` 列表的父元素
+ 使用 v-move 或定义对应的 css 样式，使得过渡平滑
+ 通用组件设计思路：入参配置初始值，输出值交由外部组件做业务逻辑
+ pug 模板中自定义 vue 指令不能单独写，需指定空值：`v-table-has-sticky-thead=''`。如果不指定，则会被 pug 编译成 `v-table-has-sticky-thead='v-table-has-sticky-thead'`，导致 console 报错
+ emit事件传递多个参数：[链接](https://jsfiddle.net/50wL7mdz/30115/)

    // 子组件
    this.$emit('emission', 1, 2, 3);
    // 父组件
    <component @emission="hearEmission">
    // 父组件如果希望新增额外参数，在 .vue 文件里支持spread syntax实现
    <component @emission="hearEmission('extra', ...arguments)">

+ vue 项目里使用 debounce 的方法 [官方用法](https://cn.vuejs.org/v2/guide/migration.html#%E5%B8%A6%E6%9C%89-debounce-%E7%9A%84-v-model%E7%A7%BB%E9%99%A4)
+ props 作为子组件 data 的初始值，当 props 状态更新时，需要通过 watch 方法来个更新 data，否则 data 不能自动更新。
+ filter 注册写在 vue 实例初始化之后，刷新页面总数报 “can't resolve filter” 错，需要写在前面
+ `.sync` 修饰符减少父组件更新代码，但不要滥用

    // 子组件
    this.$emit('update:isShown', false)
    // 父组件
    <popover :isShown.sync='isShown'></poopover>

+ Vue 不能检查到已创建的对象实例动态增加/减少 root-level 属性，即在 data 中初始值为 `{}` 的属性，空对象里加减属性，都不会触发视图更新。解决办法：

    // 针对单个属性的添加
    Vue.set( target, key, value )
    // 针对单个属性的删除
    Vue.delete( target, key )
    // 批量新增属性
    this.someObject = Object.assign({}, this.someObject, { a: 1, b: 2 })
    // 子组件内使用 vm.$set，vm.$delete方法, 它们是 global Vue.set, Vue.delete 的 alias

## vue-router

+ 在路由改变后获取数据的方法：

    watch: {
      // 如果路由有变化，会再次执行该方法
      '$route': 'fetchData'
    }
+ vue-router 中路由的 name 必须唯一，不区分父路由、子路由。
+ 只有 router-view 直接对应的组件内支持 `beforeRouteEnter()` 方法读取路由信息对象
+ 点击“面包屑”返回前，从 vuex 中取出当前列表查询参数对象，赋值给路由对象的 `query` 属性。这样返回列表查询页后，根据 URL 的 query string 可以回填历史查询、排序参数，reload 页面页不会因为 vuex 状态丢失这些参数。
+ 使用 `router.go(-1)` 实现返回上一页的功能
+ 问题：使用 v-if 控制显示的 input 框输入值没有重置，好像直接被复用。解决： Vue 会使用一种最大限度减少动态元素并且尽可能的尝试修复/再利用相同类型元素的算法。在元素上使用 `key`，它会基于 key 的变化重新排列元素顺序，并且会移除 key 不存在的元素。
+ 路由信息对象 `this.$route` 对每个路由视图子组件都是可见的
+ router-link 绑定原生 click 事件处理函数：

    router-link(:to='{ name: "to-request-bill" }' @click.native='gtagTest') 请款

## Vuex

+ 默认情况下，vuex模块内部的 action、mutation 和 getter 是注册在全局命名空间的
+ 逻辑上应该相同的状态存放在不同组件里，将很难保证数据一致。如果由于某种 bug 导致某个组件中某状态与其他组件里该状态不一致，就会出现问题。于是 Flux、Redux之类提出 store 的概念，依靠全局状态作为唯一可靠数据源。
+ 利用 prop 在组件之间传递数据的问题：组件结构在三级或以上，底层组件想传数据给最底层组件，需通过多个中间组件。而这些中间组件可能根本不需要这个 prop，这样违反了低耦合的设计要求。
+ 子组件访问全局 getters 时使用 `rootGetters`

## Webpack

+ 在 'config/index' 中配置prod环境静态资源公共路径 assetsPublicPath 时记得在末尾加 `/`，否则页面上使用 import 管理的静态资源路径会变成 '/productStatic/...', 而不是 '/product/Static/...'
