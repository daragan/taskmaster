class UserController < ApplicationController
  enable :sessions

#time to refactor RIP

get '/users/signup' do
  if logged_in?
    redirect '/tasks'
  else
  erb :'/users/signup'
  end
end

post '/users/signup' do
  if params[:username] == "" || params[:password] == ""
    redirect '/users/signup'
  else
    @user = User.create(:username => params[:username], :password => params[:password])
    session[:user_id] = @user.id
  redirect '/tasks'
  end
end

get '/users/login' do
  if logged_in?
    redirect '/tasks'
  else
    erb :'/users/login'
  end
end

post '/users/login' do
  @user = User.find_by(:username => params[:username])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/tasks'
  else
    redirect '/users/login'
  end
end

get '/logout' do
  if session[:user_id] != nil
    session.clear
    redirect to '/users/login'
  else
    redirect to '/'
  end
end
end

#  get '/user/signup' do
#    if !logged_in?
#      erb :'/user/signup'
#    else
#      redirect to '/home'
#    end
#  end

#  post '/user/signup' do
#   if params[:username] == "" || params[:email] == "" || params[:password] == ""
#     redirect to '/user/signup'
#   elsif User.all.find { |user| user.username == params[:username] }
#      env['x-rack.flash'][:notice] = "This username already belongs to another account" #have to add alerts, flash isnt working
#      redirect to '/user/signup'
#    elsif User.all.find { |user| user.email == params[:email] }
#     env['x-rack.flash'][:notice] = "This email already belongs to another account"
#      redirect to '/user/signup'
#    else
#     @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
#      @user.save
#      session[:user_id] = @user_id
#   env['x-rack.flash'][:notice] = "You have succesfully registered!"
#      redirect to '/tasks'
#   end
# end

#  get '/user/login' do
  #  if !logged_in?
  #    erb :'/user/login'
  #  else
  #    redirect to '/tasks'
#    end
#  end

#  post '/user/login' do
#    user = User.find_by(:username => params[:username])
#    if user && user.authenticate(params[:password]) && user.password == nil
#      session[:user_id] = user.id
#      redirect to '/user/login'
#    else
#      redirect to '/'
#    end
#  end

#  get '/logout' do
#    if logged_in?
#      session.destroy
    # env['x-rack.flash'][:notice] = "You have succesfully logged out!"
  #    redirect to '/'
#    else
  #    redirect '/'
#    end
#  end
