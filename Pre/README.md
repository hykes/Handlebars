# 预编译

> 静态模板文件的内容，如 Handlebars模板等，多为字符串，如果直接部署上线，则需要在线上实时编译，引入的模板引擎也需要包含编译的部分。

```
如果部署时之前先进行模板预编译，则：
1. 模板文件内容为一个预编译后生成的模板函数。
2. 线上的性能更高，因为不再需要实时编译模板。
3. 引入的模板引擎更精简，可以将编译的部分功能去掉。
```

> 使用 Handlebars 进行预编译，有几种方式。

> 首先需要安装 nodejs

> 具体安装方式可去官网查找，现在 Mac 和 Linux 版也有编译过的 Binaries 文件，不必下载源码编译安装，设置一下 PATH （增加一条，指向 $node_root/bin/），NODE_PATH （指向 $node_root/lib/node_modules/） 变量即可，非常方便。

> 安装 Handlebars

```
npm install -g handlebars 根据情况决定是否安装到全局。
```

> 编译模板文件

>按照 Handlebars 官网的说法，只需：handlebars <input> -f <output> 即可。

```
但是这种方式局限性非常大。
1. 必须在命令行直接使用 handlebars 命令，不太容易配合 build 工具
2. 生成的编译后的模板内容（函数），被直接赋值给了 Handlebars.templates 字典，且 key 被设置为 文件名 ，而非 路径名 或 模块名，容易 命名冲突！这样的话，需要后期自己处理。
这样一来，页面的引用方式会有较大变化，即：
```

```javascript
var a, b, tpl = require('./path/to/tpl.tpl');
var tpl = Handlebars.compile(tpl);
```

> 变为：

```javascript
require('./path/to/tpl.tpl');
var tpl = Handlebars.templates['tpl.tpl'];
```

> 变化太大，很难用自动化的工具还自动改变引用（除非用很强的书写约定）。

> 更好的方式：
> 写一段 compile.js 脚本：

```
var fs = require('fs');
var h = require('handlebars');

var compiledFn = h.precompile(fs.readFileSync('path/to/tpl.tpl'));
// 根据情况 可以将内容先转换为 seajs 模块，再 writeFile
var content = 'define("xx/id",[],function(){return ' + compiledFn + '});';
fs.writeFileSync('path/to/dest/tpl.tpl.js', content);
然后再引用的地方只需将 Handlebars.compile 改为 Handlebars.template 即可（根据情况，require 的路径做相应调整）：

var a,b, tpl = require('./path/to/tpl.tpl.js');
var tpl = Handlebars.template(tpl);
下面举一个实例来演示：

开发时的结构可能如下（假设与 seajs 配合）：

__index.html
  |__script
  |  |__index.js
  |__tpl
  |  |__index.tpl
  |__style
index.html 内容如下：

<scritp>
seajs.use('./index');
</script>
index.js 内容如下：

define(function(require){
    // 如果没有引入 seajs-text.js 插件，
    // 则：require('../tpl/index.tpl.js');
    var tplStr = require('../tpl/index.tpl');
    var tplFn = Handlebars.compile(tplStr);

    var context = {
        Title: 'Hi, Handlebars!'
    };
    var html = tplFn(context);
});
index.tpl 内容如下：

<div>
    <h1>{{Title}}</h1>
</div>
部署时，运行上面提到的 compile.js，之后：
index.html 不变，index.js 内容：


// 其实这里已经是编译后的函数了，而非 String
var tplStr = require('../tpl/index.tpl.js');
var tplFn = Handlebars.template(tplStr);

index.tpl.js 内容如下：

define("id",[], function(require, exports, module){
    // 或 return function (Handlebars, ...
    module.exports = function (Handlebars,depth0,helpers,partials,data) {
        this.compilerInfo = [4,'>= 1.0.0'];
        helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
        var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;

        buffer += "<div>\r\n  <p>";
        if (stack1 = helpers.Title) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
        else { stack1 = (depth0 && depth0.Title); stack1 = typeof stack1 === functionType ? stack1.call(depth0, {hash:{},data:data}) : stack1; }
        buffer += escapeExpression(stack1)
          + "</p>\r\n</div>";
        return buffer;
  }
});
```
