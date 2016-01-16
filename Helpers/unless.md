# unless

> unless helper 和 if helper　是正好相反的，当表达式返回假值时就会渲染其内容：

```html
<div class="entry">
  {{#unless license}}
  <h3 class="warning">WARNING: This entry does not have a license!</h3>
  {{/unless}}
</div>
```

> 如果在当前上下文中查找 license 返回假值，Handlebars 就会渲染这段警告信息。反之，就什么也不输出。
