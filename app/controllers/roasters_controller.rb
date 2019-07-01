class RoastersController < ApplicationController
    get '/roasters' do 
        if logged_in?
            @roasters = Roaster.all
            erb :'/roasters/index'
        else
            redirect '/login'
        end
    end

    get '/roasters/new' do 
        if logged_in?
            erb :'/roasters/new'
        else
            redirect '/login'
        end
    end

    post '/roasters' do
        
    end

    get '/roasters/:slug' do 
        if logged_in?
            @roaster = Roaster.find_by_slug(params[:slug])
            erb :'/roasters/show'
        else
            redirect '/login'
        end 
    end
end