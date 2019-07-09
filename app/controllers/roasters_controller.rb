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
        @roaster = Roaster.find_or_initialize_by(name: normalize(params[:name]))
        @roaster.save
        flash[:message] = "You successfully posted a new Coffee Roaster!"
        redirect "/roasters/#{@roaster.slug}"
    end

    get '/roasters/:slug/edit' do
        if logged_in?
            @roaster = Roaster.find_by_slug(params[:slug])
            @roasts = Coffee.roasts
            erb :'/roasters/edit'
        else
            redirect '/login'
        end
    end

    patch '/roasters/:slug' do
       @roaster = Roaster.find_by_slug(params[:slug])
        coffee = Coffee.find_or_initialize_by(name: normalize(params[:coffee][:name]), roast: params[:coffee][:roast])
        @roaster.coffees << coffee 
        flash[:message] = "You successfully added a Coffee to #{@roaster.name}!"
        redirect "/roasters/#{@roaster.slug}"
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