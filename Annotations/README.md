# 模版注释

> 在handlebars中使用&#123;&#123;! &#125;&#125;或者&#123;&#123;!-- --&#125;&#125;来包含注释。

```html
<div class="entry">
  {{! only output this author names if an author exists }}
  {{#if author}}
    <h1>{{firstName}} {{lastName}}</h1>
  {{/if}}
</div>
```

> 如果想要注释出现可使用html的注释方式：

```html
<div class="entry">
  {{! This comment will not be in the output }}
  <!-- This comment will be in the output -->
</div>
```
