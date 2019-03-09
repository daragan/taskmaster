class ProjectController < ApplicationController

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




end
