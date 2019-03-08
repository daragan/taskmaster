class TaskController < ApplicationController

  get '/tasks' do
    redirect_if_not_logged_in
    @tasks = Task.all
    erb :'/tasks/tasks'
  end

  get '/tasks/new' do
    redirect_if_not_logged_in
    erb :'/tasks/new'
  end

  post '/tasks' do
    if logged_in?
      if params["task"]["name"] == "" || params["task"]["content"] == ""
      #  flash[:message] = "Please fill in all required fields."
        redirect to '/tasks/new'
      else
        @user = current_user
        @task = Task.create(name: params["task"]["name"], content: params["task"]["content"], user_id: session[:user_id])
        if @task.save
          @user.tasks << @task
          redirect to '/tasks'
        else
          redirect to '/tasks/new'
        end
      end
    else
      redirect to '/user/login'
    end
  end

  get '/tasks/:id' do
    redirect_if_not_logged_in
    @task = Task.find_by(id: params[:id])
    erb :'/tasks/show'
  end

  get '/tasks/:id/edit' do
    redirect_if_not_logged_in
    @task = Task.find_by(id: params[:id])
    if @task && @task.user == current_user
      erb :'/tasks/edit'
    else
      redirect to '/tasks'
    end
  end

  patch '/tasks/:id' do
  redirect_if_not_logged_in
    if params["task"]["name"] == "" || params["task"]["content"] == ""
      redirect to '/books/:id/edit'
    else
      @task = Task.find_by(id: params[:id])
      if @task && @task.user == current_user
        if @task.update(name: params["task"]["name"], content: params["task"]["name"])
          #flash[:message] = "Book sucessfully updated."
          redirect to '/tasks'
        else
          redirect to '/tasks'
        end
      end
    end
  end

  delete '/books/:id/delete' do
    redirect_if_not_logged_in
    @task = Task.find_by(id: params["id"])
      if @task && @task.user == current_user
        @task.clear
      end
    #flash[:message] = "Your book has been deleted."
    redirect to '/tasks'
  end

end
