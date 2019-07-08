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
        if !empty_fields?(params)
            @roaster = Roaster.find_or_initialize_by(name: normalize(params[:name]))
            @roaster.save
            erb :'/roasters/show'
        else
            redirect '/roasters/new'
        end
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