# 代码生成时间: 2025-09-24 12:11:04
# NetworkChecker class to check the connection status of a given URL
class NetworkChecker
  # Check if a URL is reachable
# NOTE: 重要实现细节
  # @param url [String] The URL to check
  # @return [Boolean] True if the URL is reachable, false otherwise
  def self.check_url(url)
    begin
      # Try to make a HTTP HEAD request to the URL
      Net::HTTP.start(url, 80) do |http|
        http.head('/')
      end
      true
    rescue StandardError
      # If any error occurs during the request, the URL is not reachable
      false
    end
  end
end

# Sinatra application to handle HTTP requests
class NetworkCheckerApp < Sinatra::Application
  # Endpoint to check the network connection status
  get '/check' do
    # Get the URL from the request query parameters
    url = params['url']
    # Check if the URL parameter is present and not empty
    if url.nil? || url.empty?
# NOTE: 重要实现细节
      # Return an error message if the URL is missing or empty
      content_type :json
      status 400
      {"error": "URL parameter is missing or empty"}.to_json
# 优化算法效率
    else
# NOTE: 重要实现细节
      # Check the network connection status and return the result
      status = NetworkChecker.check_url(url)
      content_type :json
      {
        "url": url,
        "reachable": status
      }.to_json
    end
  end
end

# Run the Sinatra application if this file is executed directly
if __FILE__ == $0
  run! if Sinatra::Application.registered?(NetworkCheckerApp)
end