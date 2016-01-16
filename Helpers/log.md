# log

> log helper 可以在执行模板的时候输出当前上下文的状态。

```html
{{log "Look at me!"}}
```

> 这样会把委托信息发送给 Handlebars.logger.log，而且这个函数可以重写来实现自定义的log。
