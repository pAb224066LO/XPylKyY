# 代码生成时间: 2025-10-14 01:40:28
# 使用Sinatra框架的拖拽排序组件示例
require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'

# 配置路由和视图
get '/' do
  erb :index
end

post '/sort' do
  # 解析请求体中的JSON数据
  items = JSON.parse(request.body.read)
  # 错误处理：检查items是否为数组
  halt 400, "Invalid data: items should be an array." unless items.is_a?(Array)
  # 拖拽排序逻辑
  sorted_items = items.sort_by { |item| item['order'].to_i }
  # 返回排序后的数据
  content_type :json
  sorted_items.to_json
end

__END__

@@ index
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Drag and Drop Sorting</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
  <script>
    $(document).ready(function() {
      // 拖拽排序的初始化
      $('#sortable').sortable()
      .disableSelection()
      .todon(function() {
        // 当排序完成后，发送请求到服务器更新排序结果
        var sorted = $(this).sortable('toArray').map(function(item) {
          return {id: item, order: $(item).index() + 1}
        });
        $.ajax({
          url: '/sort',
          type: 'POST',
          data: JSON.stringify(sorted),
          contentType: 'application/json',
          success: function(response) {
            // 处理成功的响应
            console.log('Items sorted successfully!', response);
          },
          error: function() {
            // 处理错误响应
            console.error('Error sorting items!');
          }
        });
      });
    });
  </script>
  <style>
    #sortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
    #sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; }
    #sortable li span { position: absolute; margin-left: -1.3em; }
  </style>
</head>
<body>
  <ul id="sortable">
    <li class="ui-state-default" id="item-1"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 1</li>
    <li class="ui-state-default" id="item-2"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 2</li>
    <li class="ui-state-default" id="item-3"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 3</li>
  </ul>
</body>
</html>
