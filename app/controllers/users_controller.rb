class UsersController < ApplicationController

   get '/login' do
        erb :'/users/login'
   end

   get '/signup' do 
        erb :'/users/signup'
   end
    
    post '/signup' do
        if logged_in? 
            redirect '/cups'
        elsif empty_fields?(params.values) 
            redirect '/signup'
        else 
            user = User.create(params)
            login(user.email, user.password)
        
            redirect '/cups'
        end
    end

end