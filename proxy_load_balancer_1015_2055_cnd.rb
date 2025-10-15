# 代码生成时间: 2025-10-15 20:55:41
# 负载均衡器，用于存储后端服务列表
class LoadBalancer
  attr_accessor :backends
  def initialize
    # 假设有两个后端服务
    @backends = [
      { url: 'http://backend1.example.com', weight: 1 },
      { url: 'http://backend2.example.com', weight: 1 }
    ]
  end

  # 根据权重轮询算法选择一个后端服务
# NOTE: 重要实现细节
  def next_backend
    total_weight = @backends.sum(&:weight)
    r = rand(total_weight)
    cumulative_weight = 0
# 添加错误处理
    @backends.each do |backend|
      cumulative_weight += backend[:weight]
      return backend[:url] if cumulative_weight > r
    end
    nil
  end
end

configure do
# TODO: 优化性能
  # 设置负载均衡器
  @load_balancer = LoadBalancer.new
# FIXME: 处理边界情况
end

# 代理请求到后端服务
# 增强安全性
get '/proxy/*' do
  # 从负载均衡器获取下一个后端服务的URL
  backend_url = @load_balancer.next_backend
  return 'Load balancer error' unless backend_url

  # 解析后端服务的URL
  uri = URI.parse(backend_url)

  # 构建HTTP请求
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  # 将前端请求的头部信息传递给后端服务
  request.initialize_http_header(env)

  # 发送请求并获取响应
  response = http.request(request)

  # 将后端服务的响应返回给前端
  [response.code, response.to_hash, response.body]
rescue StandardError => e
  # 错误处理
  content_type :json
  { error: 'Internal server error', message: e.message }.to_json
end
