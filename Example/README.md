# 完整示例
# 完整示例

```html
<!DOCTYPE html>
<html>
  <head>
    <META http-equiv=Content-Type content="text/html; charset=utf-8">
    <title>Handlebars</title>
  </head>
  <body>
    <!--基础html-->
    <table>
      <thead>
        <tr>
          <th>姓名</th>
          <th>性别</th>
          <th>年龄</th>
        </tr>
      </thead>
      <tbody id="tableList">
      </tbody>
    </table>
    <!--插件引用-->
    <script type="text/javascript" src="script/jquery.js"></script>
    <script type="text/javascript" src="script/handlebars-v4.0.5.js"></script>
    <!--Handlebars.js模版-->
    <!--Handlebars.js模版放在script标签中，保留了html原有层次结构-->
    <!--id可以用来唯一确定一个模版,type是模版固定的写法-->
    <script id="table-template" type="text/x-handlebars-template">
        <tr>
          <td>{{name}}</td>
          <td>{{sex}}</td>
          <td>{{age}}</td>
        </tr>
    </script>
    <!--进行数据处理、html构造-->
    <script type="text/javascript">
      $(document).ready(function() {
        //模拟的json对象
        var data = {"name": "李四", "sex": "0", "age": 22};
        //获取模版的html框架
        var source = $("#table-template").html();
        //注册成为Handlebars模版
        var template = Handlebars.compile(source);
        //将json对象用刚刚注册的Handlebars模版封装，得到最终的html，插入到基础table中。
        $('#tableList').html(template(data));
      });
    </script>
  </body>
</html>
```
