require "./config/dependencies"
require 'better_errors'

class App < Sinatra::Base
  # YOU NEED DIS
  set :public_folder, File.dirname(__FILE__) + '/assets'
  # AND DIS
  use Rack::MethodOverride
  configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

  get "/" do
    @lists = List.all

    erb :"homepage.html"
  end

  get "/lists" do
    erb :"homepage.html"
  end

  post "/lists" do
    List.create(params["list"])
    redirect to('/')
  end

  get "/lists/:name" do
      @lists = List.all
      @current_list_name= params["name"]
        @tasks = Task.all
    erb :"taskpage.html"
  end

  post "/lists/:name/items" do
    Task.create(params["task"])
    redirect to('/lists/#{@current_list_name}')
  end


  delete "/items/:id" do

  end

  get "/next" do

  end

  get "/search?q=" do

  end


  run! if app_file == $PROGRAM_NAME
end
