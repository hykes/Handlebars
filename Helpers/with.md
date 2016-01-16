# with

> 一般情况下，Handlebars 模板在计算值时，会把传递给模板的参数作为上下文。

```javascript
var source   = "<p>{{lastName}}, {{firstName}}</p>";
var template = Handlebars.compile(source);
template({firstName: "Alan", lastName: "Johnson"});
```

> 结果如下：

```html
<p>Johnson, Alan</p>
```

> 不过也可以在模板的某个区域切换上下文，使用内置的 with helper即可。

```html
<div class="entry">
  <h1>{{title}}</h1>

  {{#with author}}
  <h2>By {{firstName}} {{lastName}}</h2>
  {{/with}}
</div>
```

> 在使用下面数据作为上下文时：

```javascript
{
  title: "My first post!",
  author: {
    firstName: "Charles",
    lastName: "Jolley"
  }
}
```

> 会得到如下结果：

```html
<div class="entry">
  <h1>My first post!</h1>

  <h2>By Charles Jolley</h2>
</div>
```

> helpers 可以接受参数，并且对参数的求值就跟直接使用 &#123;&#123;mustache&#125;&#125; 表达式一样一样地。

```javascript
Handlebars.registerHelper('with', function(context, options) {
  return options.fn(context);
});
```
> helpers 接受参数的顺序跟传递进来的顺序相同。
