require './config/environment'
require 'rack-flash'
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

      def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end

      def logged_in?
        !!current_user
      end

      def redirect_if_not_logged_in
        if !logged_in?
          #env['x-rack.flash']flash[:notice] = "You must be logged in to view that page."
          redirect to '/user/login'
        end
      end

    end
  end
