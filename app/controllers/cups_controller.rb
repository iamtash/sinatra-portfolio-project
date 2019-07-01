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
            @roasts = Coffee.roasts
            @roasters = Roaster.all
            erb :'/cups/new'
        else
            redirect '/login'
        end
    end

    post '/cups' do
        @coffee = Coffee.find_or_create_by(params[:coffee])

        if params[:roaster][:name] != ""
            @coffee.roaster = Roaster.create(params[:roaster])
        end
        
        @cup = @coffee.cups.create(params[:cup])
        @cup.update(user: current_user)

        erb :'cups/show'
    end

    get '/cups/:id/edit' do
        if logged_in? 
            if @cup = Cup.find_by(id: params[:id])
                @roasts = Coffee.roasts
                @roasters = Roaster.all
                erb :'/cups/edit'
            else
                redirect '/cups'
            end
        else
            redirect '/login'
        end
    end

    patch '/cups/:id' do
        @cup = Cup.find_by(id: params[:id])

        @cup.update(params[:cup])

        @coffee = Coffee.find_or_create_by(params[:coffee])

        if params[:roaster][:name] != ""
            @coffee.roaster = Roaster.create(params[:roaster])
        end

        @cup.update(coffee: @coffee)

        erb :'cups/show'
    end
end
