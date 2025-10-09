# 代码生成时间: 2025-10-09 20:36:39
# 定义Sinatra应用
class UrlValidator < Sinatra::Base
  # 定义GET请求路由
  get '/validate-url' do
    # 获取URL参数
    url = params['url']

    # 校验URL是否为空
    unless url
      status 400
      json_error("URL cannot be empty")
    end

    # 验证URL格式
    begin
      uri = URI.parse(url)
    rescue URI::InvalidURIError
      json_error("Invalid URL format")
    end

    # 检查是否是HTTP或HTTPS协议
    unless ['http', 'https'].include?(uri.scheme)
      json_error("URL must be HTTP or HTTPS")
    end

    # 尝试建立连接以验证URL可达性
    begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # 禁用SSL验证以避免警告
      http.request_head('/')
      status 200
      json_success("URL is valid")
    rescue => e
      json_error("URL is not reachable: #{e.message}")
    end
  end

  # 格式化错误响应
  def json_error(message)
    content_type :json
    "{"error": ""#{message}""}"
  end

  # 格式化成功响应
  def json_success(message)
    content_type :json
    "{"success": ""#{message}""}"
  end
end

# 注册Sinatra应用
run UrlValidator