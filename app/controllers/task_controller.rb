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
        #flash[:message] = "Please fill in all required fields."
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



end
