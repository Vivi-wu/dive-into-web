---
title:  "Vue开发tips"
category: JavaScript
---
## VueJS 2.0

+ Windows系统文件名字母大小写不敏感，当发生“can't find module xxx”错误时，检查下module引用的文件路径、文件名拼写、文件名大小写是否正确。
+ 通过Ajax请求新数据前，reset结果数据。
+ 如果使用vue绑定按钮的 _disabled_ 属性，则不要同时使用 HTMLElement.disabled，否则两者冲突，导致禁止失效。
+ 子组件的数据由 props 设定（或依赖props传递的值），数值在子组件内部变更后，通过 `emit()` 事件把新的值向上传给父组件，由父组件更新相应的值。
+ 两个数字相乘时，根据需求对结果进行处理（取整数？保留小数点后两位？等等）
+ Vue 不能检测以下变动的数组：

    vm.items[indexOfItem] = newValue
    // 解决办法：使用 Array.prototype.splice
    example1.items.splice(indexOfItem, 1, newValue)

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

+ Vue devtool inspection 在生产环境默认 disabled，所以在线上开发者工具里看不到 Vue devtool
+ 在 HTML 中侦听 Vue 事件，event name 必须是 camel-case，如 `@set-data`
+ 获取当前组件绑定的 HTMLElement 的方法： `this.$el`
+ Vue 实现深度 copy 对象型数组的方法：

    JSON.parse(JSON.strigify(myArray))

+ select 元素值为 primitive values, 而 option 的值是 object 时，通过绑定 select 的值回填数据的方法不起作用。解决办法：在 option 元素上给 _selected_ 特性绑定 method，通过判断对象某属性的值是否与默认值一致，设置该 `<option>` 的 _selected_ 特性值为 `true`
+ 在 data 初始化绑定时，对 object 型数组中 item 进行深层对象声明，避免加载时 console 报错

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

## Vuex

+ 默认情况下，vuex模块内部的 action、mutation 和 getter 是注册在全局命名空间的