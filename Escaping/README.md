# HTML 转义

> 为安全起见，Handlebars表达式中的一些HTML字符将被转义，如果你不想让Handlebars转义字符，使用三个花括号&#123;&#123;&#123;&#125;&#125;&#125;

```html
<div class="entry">
  <h1>{{title}}</h1>
  <div class="body">
    {{{body}}}
  </div>
</div>
```

> 定义如下的上下文:

```javascript
{
  "title": "All about <p> Tags",
  "body": "<p>This is a post about &lt;p&gt; tags</p>"
}
```

> 结果如下:

```html
<div class="entry">
  <h1>All About &lt;p&gt; Tags</h1>
  <div class="body">
    <p>This is a post about &lt;p&gt; tags</p>
  </div>
</div>
```

> Handlebars不会转义Handlebars.SafeString，如果你想写一个输出自身HTML的helper，你可以使用这个方法，用来手动的输出需要转义的参数。

```javascript
Handlebars.registerHelper('link', function(text, url) {
  text = Handlebars.Utils.escapeExpression(text);
  url  = Handlebars.Utils.escapeExpression(url);

  var result = '<a href="' + url + '">' + text + '</a>';

  return new Handlebars.SafeString(result);
});
```

> This will escape the passed in parameters, but mark the response as safe, so Handlebars will not try to escape it even if the "triple-stash" is not used.
