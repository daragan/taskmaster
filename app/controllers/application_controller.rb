require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "onepasswordtorulethemall"
  end

  get "/" do
    erb :home
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/home"
      end
    end

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= user.find_by(id: session[:user_id]) if session[:user_id] end
    end

end
