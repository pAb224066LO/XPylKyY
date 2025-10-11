# 代码生成时间: 2025-10-11 20:53:26
# Probability Calculator using Ruby and Sinatra framework

require 'sinatra'
require 'json'

# Define a helper method to calculate the expected value
helpers do
def calculate_probability(distribution)
  raise ArgumentError, 'Distribution must be a hash with values summing to 1' unless distribution.values.sum == 1
  distribution
end

# Route to handle GET requests to calculate the probability distribution
get '/calculate' do
  # Parse the query parameters to get the distribution
  params = JSON.parse(params['distribution'])
  
  # Calculate the probability distribution
  begin
# 扩展功能模块
    result = calculate_probability(params)
    # Return the result as JSON
    content_type :json
    {filename: "probability_calculator.rb", code: "#{result.to_json}"}.to_json
  rescue ArgumentError => e
    # Handle errors and return a JSON error message
    content_type :json
    {error: e.message}.to_json
  end
end
