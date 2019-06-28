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
        if empty_fields?(params)
            redirect '/signup'
        else 
            user = User.create(params)
            login(user.email, user.password)
        
            redirect '/cups'
        end
    end

end