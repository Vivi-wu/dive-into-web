---
title:  "Webpack从入门到放弃"
category: JavaScript
---
Webpack 是目前流行的前端资源模块化管理和构建工具。

+ 可以将模块按照依赖和规则打包成符合不同环境部署的前端资源
+ 可以对按需加载的模块进行代码分割，实现异步加载
+ 通过指定的 loader 对模块的源代码进行转换，即引用/加载时预处理 pre-compile 文件
+ 由于 loader 仅对单个文件进行操作，使用 plugins 可在编译、chunk 生命周期执行自定义操作
 
1. 管理项目本地图片的版本（构建后的图片名称加hash）和引用路径：

```js
// 模板
var tpl = `<img src="${Logo}">`
// js
import Logo from 'PATH_TO_FILE/logo.jpg'
```

2. vue单文件中style模块使用 sass 等语言编写时引用全局的 variable 配置文件的方法：

```html
<style lang="scss" scoped>
@import '~@/assets/scss/_variables.scss';

.badge-cf {
  background-color: $brand-color;
}
</style>

```

注意：需要在文件路径前加 `~` 标记，才能被webpack识别，使用relative路径解析。

3. 借助 node.js 内置 path 插件，在指定路径下创建名为 css 的文件夹，并把构建好的 css 文件放在此文件夹内。

```js
plugins: [
  new MiniCssExtractPlugin({
    // filename: "[name].css", // 打包到根路径
    filename: path.posix.join(assetsSubDirectory, 'css/[name].[contenthash].css'),
  })
],
```

4. style-loader 把 CSS 通过 `<style>` 标签引入 DOM，production环境不要使用
5. url-loader 把文件size小于指定阈值的文件转为内联的 base64 URL 代码，从而减少小文件的 HTTP 请求
6. css-loader 会像 import/require（）一样翻译 `@import` 和 `url()` 并 resolve 它们
7. html-webpack-plugin 可以根据提供的模板生成 HTML 文件，把所有 webpack bundle 通过 `<script>` 标签嵌入 body。
  + 通过设置 _chunks_ 属性可以在 html 中**只引入**某些 chunks
  + 通过自定义变量，如引入配置里entry文件名，可实现在指定页面手动引入css

    //- 手动插入样式文件
    if enableManualInject
      each css in htmlWebpackPlugin.files.css
        if css.indexOf(htmlWebpackPlugin.options.fnPrefix) > 0
          link(href=css, rel='stylesheet')

8. 对于那些「按需加载 chunk」的输出文件，使用 _output.chunkFilename_ 选项来控制输出。此选项决定了非入口(non-entry) chunk 文件的名称。
9. 通过 _optimization.splitChunks.cacheGroups_ 指定用于按需加载而 split 的 chunk。
10. Webpack v2以上 内置支持类似与 ES6 `import` 用法加载 JSON 文件的数据。

    // 不需额外安装 loader 即可引入解析好的 JSON 数据作为模块变量
    import Data from './data.json'

11. 使用 new 创建实例来调用 plugin，可以在一个配置文件中因为不同目的而多次使用同一个插件
12. 通过 ProvidePlugin 自动加载模块，代替在各个文件里 import/require 它们。

<!--more-->

### html webpack plugin

通过插件引入 favicon，并处理 favicon 的引用路径。

看懂webpack工作原理：[这篇文章讲webpack中各种路径](https://medium.com/@tang.apollo/setup-webpack2-03-00-html-webpack-plugin-70c12aa3560d)

```js
plugins: [
  new HtmlWebpackPlugin({
    template: 'index.html',
    favicon: './favicon.ico'
  }),
]
```
```html
<link rel="shortcut icon" href="{output.publicPath}favicon.ico">
```
13. 在 'app.*.js.map'  中可以查看当前环境打包的 NODE_ENV
