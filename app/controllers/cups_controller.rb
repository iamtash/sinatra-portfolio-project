class CupsController < ApplicationController
    get '/cups' do 
        if logged_in?
            @user = current_user
            @cups = Cup.all
            erb :'/cups/index'
        else   
            redirect '/login'
        end
    end

    get '/cups/new' do 
        if logged_in?
            @user = current_user
            erb :'/cups/new'
        else
            redirect '/login'
        end
    end

    post '/cups' do 
        cup = Cup.create
    end
end