# 块级表达式

> Block expressions allow you to define helpers that will invoke a section of your template with a different context than the current. These block helpers are identified by a # preceeding the helper name and require a matching closing mustache, /, of the same name.

> 块级表达式能让你定义块级helpers，它能调用模板的一部分，并且使用与当前不同的上下文。下面以一个输出HTML列表的helper为例：

```html
{{#list people}}{{firstName}} {{lastName}}{{/list}}
```

> 定义如下的上下文

```javascript
{
  people: [
    {firstName: "Yehuda", lastName: "Katz"},
    {firstName: "Carl", lastName: "Lerche"},
    {firstName: "Alan", lastName: "Johnson"}
  ]
}
```

> 我们可以创建一个名为list的helper来生成HTML列表，这个helper接受people和options参数，options包含fn属性，可以调用上下文。

```javascript
Handlebars.registerHelper('list', function(items, options) {
  var out = "<ul>";

  for(var i=0, l=items.length; i<l; i++) {
    out = out + "<li>" + options.fn(items[i]) + "</li>";
  }

  return out + "</ul>";
});
```

> 执行后，生成如下html

```html
<ul>
  <li>Yehuda Katz</li>
  <li>Carl Lerche</li>
  <li>Alan Johnson</li>
</ul>
```

> 块级helper包含更多的特性，如创建一个else部分（在内建的if helper里有用到）。

>当调用options.fn(context)时内部的内容已经被转义，因此Handlebars不会转义块级helper的结果，否则会出现两次转义。[了解更多块级helper](http://handlebarsjs.com/block_helpers.html)。





