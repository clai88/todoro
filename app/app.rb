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


  def find_list_name(task)
    (List.all.select { |list| task.list_id == list.id })[0].name
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

    list_name = find_list_name(@task)
    # binding.pry
    redirect to("/lists/#{list_name}")
  end

  delete "/items/:id" do
    @task = Task.find(params["id"])
    @task.destroy

    list_name = find_list_name(@task)

    redirect to("/lists/#{list_name}")
  end

  get "/next" do
    task = Task.all
    @empty_task = false
    if task == []
      @empty_task = true
    else
      @random_task = task[rand(0..task.length-1)]
      @r_task_name = find_list_name(@random_task)
    end

    erb :"randompage.html"
  end

  get "/search" do
    @query = params[:q]
    @lists = List.all
  
    @matched_list_items = List.all.select { |i| i.name.include? @query }
    @matched_task_items = Task.all.select { |i| i.name.include? @query }

    # binding.pry
    erb :"searchpage.html"
  end

  run! if app_file == $PROGRAM_NAME
end
