require './config/environment'

class ApplicationController < Sinatra::Base

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
    def empty_fields?(inputs)
        inputs.any? {|input| input==""}
    end

    def login(email, password)
        user = User.find_by(email: email)
        if user && user.authenticate(password)
          session[:user_id] = user.id
        else
          redirect '/login'
        end
    end

    def current_user
      User.find_by(email: session[:email]) if session[:email]
    end

    def logged_in?
      !!current_user
    end
end

end
