# if

> if 表达式可以选择性的渲染一些区块。如果它的参数返回 false, undefined, null, "" 或 []（译注：还有 0）（都是JS中的“假”值），Handlebars 就不会渲染这一块内容：

```javascript
Handlebars.registerHelper('if', function(conditional, options) {
  if(conditional) {
    return options.fn(this);
  }
});
```

> Handlebars 以 options.inverse 的形式来支持 else 块中的代码。如果模板没有提供条件取反的模板，Handlebars会自动的创建一个 空函数，这样你就不必去检查 inverse 是否存在了。

```javascript
Handlebars.registerHelper('if', function(conditional, options) {
  if(conditional) {
    return options.fn(this);
  } else {
    return options.inverse(this);
  }
});
```

```html
<div class="entry">
  {{#if author}}
  <h1>{{firstName}} {{lastName}}</h1>
  {{/if}}
</div>
```

> 当时用一个空对象（{}）作为上下文时，会得到：

```html
<div class="entry">
</div>
```

> 在使用 if 表达式的时候，可以配合 {{else}} 来使用，这样当参数返回 假 值时，可以渲染 else 区块：

```html
<div class="entry">
  {{#if author}}
    <h1>{{firstName}} {{lastName}}</h1>
  {{else}}
    <h1>Unknown Author</h1>
  {{/if}}
</div>
```
