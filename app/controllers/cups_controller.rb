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
end