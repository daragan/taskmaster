class UserController < ApplicationController
  enable :sessions

  get '/users/:id' do
    redirect_if_not_logged_in
    @user = Users.find_by(id: session[:user_id])
    erb :'/users/show'
  end

  get '/user/signup' do
    if !logged_in?
      erb :'/user/signup'
    else
      redirect to '/home'
    end
  end

  post '/user/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/user/signup'
    elsif Users.all.find { |user| user.username == params[:username] }
      flash[:message] = "This username already belongs to another account" #have to add alerts, flash isnt working
      redirect to '/user/signup'
    elsif Users.all.find { |user| user.email == params[:email] }
      flash[:message] = "This email already belongs to another account"
      redirect to '/user/signup'
    else
      @user = Users.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user_id
      flash[:message] = "You have succesfully registered!"
      redirect to '/user/login'
    end
  end

  get '/user/login' do
    if !logged_in?
      erb :'/user/login'
    else
      redirect to '/'
    end
  end

  post '/user/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password]) && user.password == nil
      session[:user_id] = user.id
      redirect to '/user/login'
    else
      redirect to '/'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      flash[:message] = "You have succesfully logged out!"
      redirect to '/home'
    else
      redirect '/books'
    end
  end

end
