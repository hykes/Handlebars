# each

> 你可以使用内置的 each helper 来循环一个列表，循环中可以使用 this 来代表当前被循环的列表项。

```html
<ul class="people_list">
  {{#each people}}
  <li>{{this}}</li>
  {{/each}}
</ul>
```

> 使用这个上下文：

```javascript
{
  people: [
    "Yehuda Katz",
    "Alan Johnson",
    "Charles Jolley"
  ]
}
```

> 在这里的情况下，我们希望对 people 数组的每一项都执行 传递给 each 的这一块代码。

```javascript
Handlebars.registerHelper('each', function(context, options) {
  var ret = "";

  for(var i=0, j=context.length; i<j; i++) {
    ret = ret + options.fn(context[i]);
  }

  return ret;
});

> 会得到：

```html
<ul class="people_list">
  <li>Yehuda Katz</li>
  <li>Alan Johnson</li>
  <li>Charles Jolley</li>
</ul>
```

> 事实上，可以使用 this 表达式在任何上下文中表示对当前的上下文的引用。

> 还可以选择性的使用 else ，当被循环的是一个空列表的时候会显示其中的内容。

```html
{{#each paragraphs}}
  <p>{{this}}</p>
{{else}}
  <p class="empty">No content</p>
{{/each}}
```

> 在使用 each 来循环列表的时候，可以使用 {{@index}} 来表示当前循环的索引值。

```html
{{#each array}}
  {{@index}}: {{this}}
{{/each}}
```

> 对于 object 类型的循环，可以使用 {{@key}} 来表示：

```html
{{#each object}}
  {{@key}}: {{this}}
{{/each}}
```
