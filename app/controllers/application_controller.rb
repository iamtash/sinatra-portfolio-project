require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    if logged_in?
      redirect '/cups'
    else
      erb :'/users/signup'
    end
  end

  helpers do
    def empty_fields?(params)
        params.any? {|k,v| v==""}
    end

    def login(email:, password:)
        user = User.find_by(email: email)
        if user && user.authenticate(password)
          session[:user_id] = user.id
        else
          redirect '/login'
        end
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def normalize(param)
        param.split(' ').map {|w| w.downcase.capitalize}.join(' ')
    end
end

end
