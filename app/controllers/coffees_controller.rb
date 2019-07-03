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
        coffee = Coffee.find_or_create_by(params[:coffee])
        
        if params[:roaster][:name] != "" && !coffee.persisted?
            roaster = Roaster.find_or_create_by(params[:roaster])
            @coffee = roaster.coffees.build(params[:coffee])
        else
            @coffee = coffee
        end

        @coffee.save

        redirect "/coffees/#{@coffee.slug}"
    end

    get '/coffees/:roasters/:slug' do 
        if logged_in?
            @roaster = Roaster.find_by_slug(params[:roasters])
            @coffee = @roaster.coffees.find_by_slug(params[:slug])
            
            erb :'/coffees/show'
        else
            redirect '/login'
        end
    end
end