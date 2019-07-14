class UsersController < ApplicationController  

   get '/login' do
        if logged_in?
            redirect '/cups'
        else
            erb :'/users/login'
        end
   end

   post '/login' do
        login(email: params[:email], password: params[:password])
        redirect '/cups'
   end

   get '/signup' do
        if logged_in?
            redirect '/cups'
        else
            erb :'/users/signup'
        end
   end

    post '/signup' do
        user = User.new(params)

        if user.save
            flash[:message] = "You successfully created an account!"
        else
            flash[:message] = "That email has already been taken."
            redirect '/signup'
        end

        login(email: user.email, password: user.password)
        
        redirect '/cups'
    end

    get '/logout' do
        if logged_in?
            erb :'/users/logout'
        else
            redirect '/login'
        end
    end

    post '/logout' do
        session.clear
        redirect '/login'
    end

    get '/users/:slug' do
        if logged_in?
            @user = User.find_by_slug(params[:slug])
            erb :'/users/show'
        else
            redirect '/login'
        end
    end

end
