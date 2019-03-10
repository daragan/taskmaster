class TaskController < ApplicationController

  get '/tasks' do
    redirect_if_not_logged_in
    @user = current_user
    @projects = @user.projects
    erb :'tasks/show'
  end

  #new
  get '/tasks/new' do
    redirect_if_not_logged_in
    @user = current_user
    @projects = Project.all
    erb :'/tasks/new'
  end

  post '/tasks/new' do
    Task.create(:title => params[:title], :about => params[:about], :project_id => params[:project_id])
    redirect '/tasks'
  end

  #builds task correlated with project_id
  get 'tasks/new/:id' do
    redirect_if_not_logged_in
    @project = Project.find_by_id(params[:id])
    erb :'/tasks/new_project'
  end

  post '/tasks/new/:id' do
    @project = Project.find_by_id(params[:id])
    Task.create(:name => params[:name], :content => params[:content], :project_id => params[:id])
    redirect '/tasks'
  end

  #task editing
  get '/taks/new/:id'do
    @project = Project.find_by_id(params[:id])
    erb :'/taks/edit'
  end

  patch '/tasks/:id' do
    @task = Task.find_by_id(params[:id])
    @task.name = params[:name]
    @task.content = prams[:content]
    @task.save
    redirect '/tasks'
  end

  #deletion!
  get '/tasks/:id/delete' do
    @task = Task.find_by_id(params[:id])
    erb :'/tasks/delete'
  end

  delete '/tasks/:id' do
    @task = Task.find_by_id(params[:id])
    @task.destroy
    redirect '/tasks'
  end

end



#have to refactoR ALL OF THIS CODE
#  get '/tasks' do
#    redirect_if_not_logged_in
#    @tasks = Task.all
#    erb :'/tasks/tasks'
#  end

#  get '/tasks/new' do
#    redirect_if_not_logged_in
#    erb :'/tasks/new'
#  end

#  post '/tasks' do
#    if logged_in?
#      if params["task"]["name"] == "" || params["task"]["content"] == ""
      # env['x-rack.flash']flash[:notice] = "Please fill in all required fields."
#        redirect to '/tasks/new'
#      else
#        @user = current_user
#        @task = Task.create(name: params["task"]["name"], content: params["task"]["content"], user_id: session[:user_id])
#        if @task.save
#          @user.tasks << @task
#          redirect to '/tasks'
#        else
#          redirect to '/tasks/new'
#        end
#      end
#    else
#      redirect to '/user/login'
#    end
#  end

#  get '/tasks/:id' do
#    redirect_if_not_logged_in
#    @task = Task.find_by(id: params[:id])
#    erb :'/tasks/show'
#  end

#  get '/tasks/:id/edit' do
#    redirect_if_not_logged_in
#    @task = Task.find_by(id: params[:id])
#    if @task && @task.user == current_user
#      erb :'/tasks/edit'
#    else
#      redirect to '/tasks'
#    end
#  end

#  patch '/tasks/:id' do
#  redirect_if_not_logged_in
  #  if params["task"]["name"] == "" || params["task"]["content"] == ""
  #    redirect to '/tasks/:id/edit'
  #  else
  #    @task = Task.find_by(id: params[:id])
  #    if @task && @task.user == current_user
  #      if @task.update(name: params["task"]["name"], content: params["task"]["content"])
        #  env['x-rack.flash']flash[:notice] = "Your task has been updated."
  #        redirect to '/tasks'
  #      else
  #        redirect to '/tasks'
  #      end
  #    end
#    end
#  end

#  delete '/tasks/:id/delete' do
  #  redirect_if_not_logged_in
#    @task = Task.find_by(id: params["id"])
  #    if @task && @task.user == current_user
  #      @task.destroy
  #    end
  #  env['x-rack.flash']flash[:notice] = "Your task has been deleted."
  #  redirect to '/tasks'
#  end
