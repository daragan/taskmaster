class ProjectController < ApplicationController

  get '/projects' do
    redirect_if_not_logged_in
    @projects = Project.all
    erb :'/project/projects'
  end

  get '/project/new' do
    redirect_if_not_logged_in
    erb :'/project/new'
  end

  post '/projects' do
    if logged_in?
      if params["project"]["title"] == ""
      # env['x-rack.flash']flash[:notice] = "Please fill in all required fields."
        redirect to '/project/new'
      else
        @user = current_user
        @project = Project.create(title: params["project"]["title"],  user_id: session[:user_id])
        if @project.save
          @user.projects << @project
          redirect to '/projects'
        else
          redirect to '/project/new'
        end
      end
    else
      redirect to '/user/login'
    end
  end

end
