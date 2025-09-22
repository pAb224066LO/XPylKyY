# 代码生成时间: 2025-09-23 06:44:48
# 定义MathToolbox类，用于封装数学计算方法
class MathToolbox
  # 返回两个数的和
  def add(a, b)
    a + b
  end

  # 返回两个数的差
  def subtract(a, b)
    a - b
  end

  # 返回两个数的乘积
  def multiply(a, b)
    a * b
  end

  # 返回两个数的商
  def divide(a, b)
    raise 'Division by zero' if b == 0
    a.to_f / b
  end
end

# 设置Sinatra应用
get '/' do
  "Welcome to the Math Toolbox!"
end

# 添加路由处理加法请求
get '/add/:a/:b' do |a, b|
  mt = MathToolbox.new
  result = mt.add(a.to_i, b.to_i)
  "Addition result: #{result}"
end

# 添加路由处理减法请求
get '/subtract/:a/:b' do |a, b|
  mt = MathToolbox.new
  result = mt.subtract(a.to_i, b.to_i)
  "Subtraction result: #{result}"
end

# 添加路由处理乘法请求
get '/multiply/:a/:b' do |a, b|
  mt = MathToolbox.new
  result = mt.multiply(a.to_i, b.to_i)
  "Multiplication result: #{result}"
end

# 添加路由处理除法请求
get '/divide/:a/:b' do |a, b|
  mt = MathToolbox.new
  begin
    result = mt.divide(a.to_i, b.to_i)
    "Division result: #{result}"
  rescue => e
    "Error: #{e.message}"
  end
end