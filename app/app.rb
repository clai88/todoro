require "./config/dependencies"

class App < Sinatra::Base
  # YOU NEED DIS
  set :public_folder, File.dirname(__FILE__) + '/assets'
  # AND DIS
  use Rack::MethodOverride

  get "/" do
    erb :"homepage.html"
  end

  get "/lists" do
    
  end

  post "/lists" do

  end

  get "/lists/:name/items" do

  end

  post "/lists/:name/items" do
  end

  patch "/lists/:name/items" do

  end

  delete "/items/:id" do

  end

  get "/next" do

  end

  get "/search?q=" do

  end


  run! if app_file == $PROGRAM_NAME
end
