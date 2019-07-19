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
        if logged_in?
            if params[:roaster][:name] == ""
                if params[:coffee][:roaster_id] == ""
                    redirect "/coffees/new"
                end
                @coffee = Coffee.find_or_initialize_by(name: normalize(params[:coffee][:name]), roast: params[:coffee][:roast], roaster_id: params[:coffee][:roaster_id]) 
            else
                roaster = Roaster.find_or_initialize_by(name: normalize(params[:roaster][:name]))
                @coffee = nil
                if roaster.persisted?
                    @coffee = roaster.coffees.find_by(name: normalize(params[:coffee][:name]), roast: params[:coffee][:roast])
                end
                if @coffee.nil?
                    @coffee = roaster.coffees.build(params[:coffee])
                end 
            end

            if @coffee.save
                flash[:message] = "You successfully posted a new Coffee!"
            end
            redirect "/coffees/#{@coffee.roaster.slug}/#{@coffee.slug}"
        else 
            redirect '/login'
        end
    end

    get '/coffees/:roaster/:slug' do 
        if logged_in?
            @roaster = Roaster.find_by_slug(params[:roaster])
            @coffee = @roaster.coffees.find_by_slug(params[:slug])
            
            erb :'/coffees/show'
        else
            redirect '/login'
        end
    end
end