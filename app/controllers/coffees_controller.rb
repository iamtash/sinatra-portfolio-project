class CoffeesController < ApplicationController
    get '/coffees' do 
        if logged_in?
            @coffees = Coffee.all
            erb :'/coffees/index'
        else
            redirect '/login'
        end
    end

    get '/coffees/new' do 
        if logged_in?
            @roasts = Coffee.roasts
            @roasters = Roaster.all
            erb :'/coffees/new'
        else
            redirect '/login'
        end
    end

    post '/coffees' do 
        @coffee = Coffee.find_or_create_by(params[:coffee])

        if params[:roaster][:name] != ""
            @coffee.update(roaster: Roaster.find_or_create_by(params[:roaster]))
        end

        redirect "/coffees/#{@coffee.slug}"
    end

    get '/coffees/:slug' do 
        if logged_in?
            @coffee = Coffee.find_by_slug(params[:slug])
            erb :'/coffees/show'
        else
            redirect '/login'
        end
    end
end