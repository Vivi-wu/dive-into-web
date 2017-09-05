---
title:  "Webpack从入门到放弃"
category: JavaScript
---
1. Webpack怎么编译、打包Sass文件（`.scss`）？安装 style-loader 即可
2. 管理项目本地图片的版本（构建后的图片名称加hash）和引用路径：

    // 模板
    '<img src="'+ Logo +'">'
    // js
    import Logo from 'PATH_TO_FILE/logo.jpg'
