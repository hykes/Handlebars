# Helpers

> Helpers是Handlebars中最重要的概念，它能大大扩展Handlebars的使用范围，Helper自定义函数的形式将所需要的功能注册为表达式，然后可以在Handlebars中使用。

> Handlebars提供了Handlebars.registerHelper方法来自定义Helper，同时也提供了一些常用的内建Helper。

> 块级 helpers 使用自定义的迭代器，其他的 helpers 都可以使用一个新的上下文来执行内部的代码块。
基础

> 先定义一个简单的块级 helper，它只是简单的执行一下这块代码，就跟没有用这个helper一样。

```html
<div class="entry">
  <h1>{{title}}</h1>
  <div class="body">
    {{#noop}}{{body}}{{/noop}}
  </div>
</div>
```

> 这个 noop helper 接受一个 options 对象。这个对象有一个叫 options.fn 的方法，这个方法的用法就跟普通的编译过的 Hanldebars 模板的用法一样。所不同的就是，这个函数执行时会带有一个上下文，并且会返回一个字符串。

```javascript
Handlebars.registerHelper('noop', function(options) {
  return options.fn(this);
});
```

> Handlebars 在执行 helpers 的时候，总是会将 this 指向当前的上下文，所以，你只需用 this 来调用这一块代码，就可以在当前的上下文中求值了。

> 比如有如下模板：

```html
<div class="post">
  <h1>By {{fullName author}}</h1>
  <div class="body">{{body}}</div>

  <h1>Comments</h1>

  {{#each comments}}
  <h2>By {{fullName author}}</h2>
  <div class="body">{{body}}</div>
  {{/each}}
</div>
```

> 其中上下文和helper如下：

```javascript
var context = {
  author: {firstName: "Alan", lastName: "Johnson"},
  body: "I Love Handlebars",
  comments: [{
    author: {firstName: "Yehuda", lastName: "Katz"},
    body: "Me too!"
  }]
};

Handlebars.registerHelper('fullName', function(person) {
  return person.firstName + " " + person.lastName;
});
```

> 输出结果如下：

```html
<div class="post">
  <h1>By Alan Johnson</h1>
  <div class="body">I Love Handlebars</div>

  <h1>Comments</h1>

  <h2>By Yehuda Katz</h2>
  <div class="body">Me Too!</div>
</div>
```

> Helpers还可以接受块级元素当前的上下文，就像函数中的this上下文一样。

```html
<ul>
  {{#each items}}
  <li>{{agree_button}}</li>
  {{/each}}
</ul>
```

> 上下文及helper如下：

```javascript
var context = {
  items: [
    {name: "Handlebars", emotion: "love"},
    {name: "Mustache", emotion: "enjoy"},
    {name: "Ember", emotion: "want to learn"}
  ]
};

Handlebars.registerHelper('agree_button', function() {
  return new Handlebars.SafeString(
    "<button>I agree. I " + this.emotion + " " + this.name + "</button>"
  );
});
```

> 输出结果如下：

```html
<ul>
  <li><button>I agree. I love Handlebars</button></li>
  <li><button>I agree. I enjoy Mustache</button></li>
  <li><button>I agree. I want to learn Ember</button></li>
</ul>
```

> 空白管理

>模板中的空白可以忽略，mustache声明的两边都可以，只需添加一个 ~字符即可。写了这个之后，这一边的所有空白都会被移除，直到最近的Handlebars表达式或这一边的非空白字符。


```html
{{#each nav ~}}
  <a href="{{url}}">
    {{~#if test}}
      {{~title}}
    {{~^~}}
      Empty
    {{~/if~}}
  </a>
{{~/each}}
```

> 用这个上下文：

```javascript
{
  nav: [
    {url: 'foo', test: true, title: 'bar'},
    {url: 'bar'}
  ]
}
```

> 得出的结果没有换行，也没有格式化用的空白符：

```html
<a href="foo">bar</a><a href="bar">Empty</a>
｀｀｀
