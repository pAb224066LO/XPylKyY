# 代码生成时间: 2025-09-24 00:55:40
# 数据库配置
configure do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///sinatra_activerecord_test')
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :port     => db.port,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

# 数据模型
class User < ActiveRecord::Base
  # 用户模型
end

# 路由
get '/' do
  # 列出所有用户
  @users = User.all
  erb :index
end

get '/users/:id' do
  # 根据ID查找用户
  @user = User.find(params[:id])
  if @user
    erb :show
  else
    # 如果未找到用户，返回404错误
    halt 404, 'User not found'
  end
end

# 错误处理
error Sinatra::NotFound do
  'This page was not found'
end

__END__

@@ index
<!DOCTYPE html>
<html>
<head>
  <title>Users List</title>
</head>
<body>
  <h1>Users List</h1>
  <ul>
    <% @users.each do |user| %>
      <li><%= user.id %> - <%= user.name %></li>
    <% end %>
  </ul>
</body>
</html>

@@ show
<!DOCTYPE html>
<html>
<head>
  <title>User Details</title>
</head>
<body>
  <h1>User Details</h1>
  <p>ID: <%= @user.id %></p>
  <p>Name: <%= @user.name %></p>
</body>
</html>