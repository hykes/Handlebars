# Handlebars Paths

> 和Mustache一样，Handlebars支持简单的路径。

```html
<p>{{name}}</p>
```

> Handlebars还支持嵌套的路径，可以在当前上下文中寻找嵌套的属性。

```html
<div class="entry">
  <h1>{{title}}</h1>
  <h2>By {{author.name}}</h2>

  <div class="body">
    {{body}}
  </div>
</div>
```

> 其对应的上下文如下：

```javascript
var context = {
  title: "My First Blog Post!",
  author: {
    id: 47,
    name: "Yehuda Katz"
  },
  body: "My first post. Wheeeee!"
};
```

> 因此Handlebars模板能支持更多原始的JSON对象。

> 嵌套的handlebars路径可以包含../字符段，可以将路径定位到父级上下文中。

```html
<h1>Comments</h1>

<div id="comments">
  {{#each comments}}
  <h2><a href="/posts/{{../permalink}}#{{id}}">{{title}}</a></h2>
  <div>{{body}}</div>
  {{/each}}
</div>
```

> 在这个例子中，post是comments的父级上下文，虽然a标签处于comments的上下文里，但permalink可以上溯到post上下文中。

> 更严密的讲，../路径指的是父级模板的作用域，而不是高一级的上下文，这是因为块级helper能调用任何上下文，所以“上一级”的概念在这里并不适合。


