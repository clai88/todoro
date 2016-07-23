require "./config/dependencies"
require 'better_errors'

class App < Sinatra::Base
  # Expose any file stored in this folder to the internet
  # http://localhost:4567/css/example.css
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
    @current_list = List.find_by(name: params["name"])
    @current_list_name= @current_list.name
    @tasks = @current_list.tasks

    erb :"taskpage.html"
  end

  post "/lists/:name/items" do
    @current_list = List.find_by(name: params["name"])
    @current_list_name = params["name"]
    current = Task.create(params["task"])
    current.update(list_id: @current_list.id)

    redirect to("/lists/#{params["name"]}")
  end

  patch "/items/:id" do
    @task = Task.find(params["id"])
    @task.update(params["task"])

    list_id = @task.list_id
    list_name = ""

    List.all.each do |list|
      if list_id == list.id
        list_name = list.name
      end
    end
    # binding.pry
    redirect to("/lists/#{list_name}")
  end

  delete "/items/:id" do
    @task = Task.find(params["id"])
    @task.destroy

    list_id = @task.list_id
    list_name = ""

    List.all.each do |list|
      if list_id == list.id
        list_name = list.name
      end
    end
    redirect to("/lists/#{list_name}")
  end

  get "/next" do
    task = Task.all
    @random_task = task[rand(0..task.length-1)]
        
    erb :"randompage.html"
  end

  get "/search?q=" do

  end


  run! if app_file == $PROGRAM_NAME
end
