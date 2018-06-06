---
title:  "Webpack从入门到放弃"
category: JavaScript
---
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

3. 借助 node.js 内置 path 插件，在指定路径下创建名为 css 的文件夹，把 css 文件放在此文件夹内。

```js
plugins: [
  new MiniCssExtractPlugin({
    // Options similar to the same options in webpackOptions.output
    // both options are optional
    // filename: "[name].css", // 打包到根路径
    filename: utils.assetsPath('css/[name].[contenthash].css'),
    chunkFilename: "[id].css"
  })
],
```

4. style-loader 把 CSS 通过 `<style>` 标签引入 DOM，production环境不要使用
5. html-webpack-plugin 可以根据提供的模板生成 HTML 文件，把所有 webpack bundle 通过 `<script>` 标签嵌入 body。
  + 通过设置 _chunks_ 属性可以在 html 中**只引入**某些 chunks
6. 对于那些「按需加载 chunk」的输出文件，使用 _output.chunkFilename_ 选项来控制输出。此选项决定了非入口(non-entry) chunk 文件的名称。
7. 通过 _optimization.splitChunks.cacheGroups_ 指定用于按需加载而 split 的 chunk。
8. Webpack v2以上 内置支持类似与 ES6 `import` 用法加载 JSON 文件的数据。

    // 不需额外安装 loader 即可引入解析好的 JSON 数据作为模块变量
    import Data from './data.json'
