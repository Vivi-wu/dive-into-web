---
title:  "JavaScript Errors and Debugging"
category: JavaScript
---
JS中的错误可能是程序员代码的错误，也可能使错误的输入或其他不可预见的原因导致的。

### JavaScript try and catch

The **try** statement 用于检查这块代码执行时是否有错误出现。

The **catch** statement 在 try 部分有错误出现时，执行此处的代码。

The **finally** statement 定义了不论 try 和 catch 的结果如何，在他们之后要执行的代码。

<!--more-->

```js
try {
    // Block of code to try
}
catch(err) {
    // Block of code to handle errors
}
finally {
    // Block of code to be executed regardless of the try / catch result
}
```

JS的 `try` 和 `catch` come in pairs 是**成对出现**的。

当使用 `JSON.parse()` 解析未知数据时，用上 try catch。

### Raise Errors

当遇到错误时，JS会停下来，生成一个error message，raise (or throw) an exception。

The **throw** statement 用来定义自己的错误信息。

```html
<p>Please input a number between 5 and 10:</p>
<input id="demo" type="text">
<button type="button" onclick="myFunction()">Test Input</button>
<p id="message"></p>
<script>
function myFunction() {
    var message, x;
    message = document.getElementById("message");
    message.innerHTML = "";
    x = document.getElementById("demo").value;
    try {
        if(x == "") throw "empty";
        if(isNaN(x)) throw "not a number";
        x = Number(x);
        if(x > 10) throw "too high";
        if(x < 5) throw "too low";
    }
    catch(err) {
        message.innerHTML = "Input is " + err + ".";
    }
    finally {
        document.getElementById("demo").value = "";
    }
}
</script>
```

上例中，无论是否出错，最终都会清空输入框里用户键入的值。

### JS Debugging

查找代码里的错误称为调试。所有现代浏览器都有内置调试器。比一般的 `console.log()` 看起来高级的用法：

+ `console.info(obj/msg)` 自动换行打印，FF和Chrome中每条信息开头有一个“！”图标
+ `console.log('%o', DOMnode)` 打印DOM节点，`console.log('%O', DOMnode)` 像JS对象那样访问DOM元素，可查看DOM元素的属性
+ `console.dir(obj)` 打印对象所有的属性和方法

The **debugger** keyword stops the execution of JavaScript, and calls (if available) the debugging function. 效果跟在浏览器调试器里设置 breakpoint 一样。
