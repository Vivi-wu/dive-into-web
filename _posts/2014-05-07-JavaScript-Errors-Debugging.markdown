---
title:  "JavaScript Errors and Debugging"
category: JavaScript
---
JS中的错误可能是程序员代码的错误，也可能使错误的输入或其他不可预见的原因导致的。

### JavaScript try and catch

The **try** statement allows you to define a block of code to be tested for errors while it is being executed. 用于检查这块代码执行时是否有错误出现。

The **catch** statement allows you to define a block of code to be executed, if an error occurs in the try block. 当 try 部分有错误出现时，执行此处的代码。

The **finally** statement lets you execute code, after try and catch, regardless of the result。定义了不论try和catch的结果如何，在他们之后要执行的代码。

    try {
        Block of code to try
    }
    catch(err) {
        Block of code to handle errors
    }
    finally {
        Block of code to be executed regardless of the try / catch result
    }

JS的 `try` 和 `catch` **come in pairs** 是成对出现的。

<!--more-->

### Raise Errors

当遇到错误时，JS会停下来，生成一个error message，raise (or throw) an exception。

The **throw** statement allows you to **create a custom error**。该语句用来定义自己的错误信息。

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
            if(x == "") throw "is empty";
            if(isNaN(x)) throw "is not a number";
            x = Number(x);
            if(x > 10) throw "is too high";
            if(x < 5) throw "is too low";
        }
        catch(err) {
            message.innerHTML = "Error: " + err + ".";
        }
        finally {
            document.getElementById("demo").value = "";
        }
    }
    </script>

上例中，无论是否出错，最终都会清空输入框里用户键入的值。

### JS Debugging

查找代码里的错误称为调试。所有现代浏览器都有内置调试器。

Use `console.log()` to display JavaScript values in the debugger window. 使用该语句在浏览器调试器里查看JS的值。

The **debugger** keyword stops the execution of JavaScript, and calls (if available) the debugging function. 效果跟在浏览器调试器里设置 breakpoint 一样。

If no debugging is available, the debugger statement has no effect. 如果没有可用的 debugging，这个关键字没有什么效果。
