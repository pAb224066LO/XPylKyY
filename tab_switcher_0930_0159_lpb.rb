# 代码生成时间: 2025-09-30 01:59:21
# TabSwitcher is a sinatra application that serves as a simple tab switcher.
class TabSwitcher < Sinatra::Base
  # Set the views to the views folder
  set :views, 'views'

  # Define the route to show the main page
  get '/' do
    # Render the index page, where the tabs are
    erb :index
  end

  # Define the routes to handle tab switching
  ['home', 'profile', 'settings'].each do |tab|
    get "/#{tab}" do
      # Check if the tab is valid
      if ['home', 'profile', 'settings'].include?(params[:splat].first)
        # Render the corresponding tab page
        erb 