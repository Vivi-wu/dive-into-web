---
title:  "Angular JS 复习笔记"
category: Other
---
## isolate Scope

使用 directive 的 _scope_ 选项，defines a set of local scope properties derived from attributes on the directive's element,为 app 可重用 component 创建一个隔离区域 **isolate scope**，这样父 scope 无法渗入到 directive 中。

    HTML：
    <my-customer info="naomi"></my-customer>
    JS：
    // controller 中
    $scope.naomi = { name: 'Naomi', address: '1600 Amphitheatre' };
    // 自定义 directive 中
    scope: {
      customerInfo: '=info'
    }
    HTML2:
    Name: {{customerInfo.name}}

<!--more-->

1. 使用 `=attr` set up a bidirectional binding between a local scope property and an expression passed via the attribute attr. 通过 directive 的 attr **属性的值**在局部 scope 的属性和父 scope 属性名之间建立双向绑定。以上面代码的例子表示 isolate scope 中的属性 customerInfo 从实际使用指令上的 _info_ 特性接受 data-binding。
2. 使用 `&attr` provides a way to execute an expression in the context of the parent scope. 当希望你的 directive 给绑定行为暴露一个API时，（在父 scope 的上下文中执行一个表达式）。
3. 使用 `@attr` bind a local scope property to the value of DOM attribute, <span class="t-blue">把 DOM attr 的值，直接赋予局部 scope 某特性，注意与下面第4种的区别。</span>

    用来访问 directive 外部环境定义的**字符串值**。这种绑定是**单向**的，即父 scope 的绑定变化，directive 中的 scope 的属性会同步变化，而隔离 scope 中的绑定变化，父 scope 是不知道的。
4. 使用 `<attr` set up a one-way binding (**单向**绑定) between a local scope property and an **expression** passed via the attribute attr <span class="t-blue">建立局部 scope 中某特性和 attr 传递过来的表达式之间的单向绑定</span>.

    One-way binding does not copy the value from the parent to the isolate scope, it simply sets the same value. That means if your bound value is an object, changes to its properties in the isolated scope will be reflected in the parent scope (because both reference the same object).

### transclude

Extract the contents of the element where the directive appears and make it available to the directive. 

用法：在 directive 中设置该属性值为 true，然后在 directive 定义中把需要替换的元素添加 `ng-transclude` 特性。

### ngBindHtml

Evaluates the expression and inserts the resulting HTML into the element in a secure way. 该指令用来评估一个表达式，然后以安全的方式，把运算出的结果 HTML 内容插入到元素中。

项目中基于 AngularStrap 的 _bs-collapse_ 指令写自己的插件，需要根据对象中的属性值，动态插入 content。把数值传入 template，单纯用 `{{ ctrl.content }}`，结果把 html 标记语言当作纯字符串输出了。

借助 `ng-bind-html` 解决，用法如下：

    <ANY
      ng-bind-html="expression">
    ...
    </ANY>
    <div ng-bind-html="ctrl.content"></div>

### ngChange

用来作为 input change 的 react。该指令用来代替 `$watch` 用来监视 obj 的状态，考虑到 Angular 2 不再使用 `$watch`。

该指令需要 ngModel to be present
