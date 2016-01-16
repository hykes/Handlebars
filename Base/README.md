# 基础语法

> Handlebars模板看起来和一般的HTML差不多，只不过是在HTML中嵌入了Handlebars的表达式。如下：

```html
<div class="entry">
  <h1>{{title}}</h1>
  <div class="body">
    {{body}}
  </div>
</div>
```

> 一个Handlebars的表达式是被{{和}}包含起来的内容。[了解更多Handlebars表达式。](http://handlebarsjs.com/expressions.html)

> 可以将模板的内容或数据放到一个&lt;script&gt;标签里，也可以直接写在javascript里：

```html
<script id="entry-template" type="text/x-handlebars-template">
  <div class="entry">
    <h1>{{title}}</h1>
    <div class="body">
      {{body}}
    </div>
  </div>
</script>
```

> 使用Handlebars.compile方法编译模板

```javascript
var source   = $("#entry-template").html();
var template = Handlebars.compile(source);
```

> It is also possible to precompile your templates. This will result in a smaller required runtime library and significant savings from not having to compile the template in the browser. This can be especially important when working with mobile devices.[了解更多预编译](http://handlebarsjs.com/precompilation.html)

> Handlebars模版接受context作为参数，用来渲染模板

```javascript
var context = {title: "My New Post", body: "This is my first post!"};
var html    = template(context);
```
> 结果如下：

```html
<div class="entry">
  <h1>My New Post</h1>
  <div class="body">
    This is my first post!
  </div>
</div>
```

> [了解更多执行函数](http://handlebarsjs.com/execution.html)
