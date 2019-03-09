class ProjectController < ApplicationController

  #create
  get '/project/new' do
    redirect_if_not_logged_in
    erb :'/project/new'
  end

  post '/project/new' do
    @user = current_user
    project = @user.projects.create(:title => params[:title], :about => params[:about])
    task = project.tasks.create(:name => params[:tasks][:name], :content => params[:tasks][:content])
    redirect '/tasks'
  end

  #edit
  get '/project/:id/edit' do
    redirect_if_not_logged_in
    @project = Project.find_by_id(params[:id])
    erb :'/project/edit'
  end

  patch '/project/:id' do
    @project = Project.find_by_id(params[:id])
    @project.title = params[:title]
    @project.about = params[:about]
    @project.save
    redirect '/tasks/tasks'
  end

  #delete
  get '/project/:id/delete' do
    @project = Project.find_by_id(params[:id])
    erb :'/project/delete'
  end

  delete 'project/:id' do
    @project = Project.find_by_id(params[:id])
    @project.destroy
    redirect '/tasks/tasks'
  end


end
