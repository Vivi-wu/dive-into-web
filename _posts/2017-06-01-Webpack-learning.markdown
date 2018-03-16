---
title:  "Webpack从入门到放弃"
category: JavaScript
---
1. Webpack怎么编译、打包Sass文件（`.scss`）？安装 style-loader 即可
2. 管理项目本地图片的版本（构建后的图片名称加hash）和引用路径：

```js
// 模板
var tpl = `<img src="${Logo}">`
// js
import Logo from 'PATH_TO_FILE/logo.jpg'
```

3. vue单文件中style模块使用 sass 等语言编写时引用全局的 variable 配置文件的方法：

```html
<style lang="scss" scoped>
@import '~@/assets/scss/_variables.scss';

.badge-cf {
  background-color: $brand-color;
}
</style>

```

注意：需要在文件路径前加 `~` 标记，才能被webpack识别，使用relative路径解析。