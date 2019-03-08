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


end
