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
        if params[:coffee][:name] == ""
            redirect "/cups/new"
        end
        if params[:roaster][:name] == ""
            if !params[:coffee][:roast] || !params[:coffee][:roaster_id]
                redirect "/cups/new"
            end
            @coffee = Coffee.find_or_initialize_by(name: normalize(params[:coffee][:name]), roast: params[:coffee][:roast], roaster_id: params[:coffee][:roaster_id]) 
        else
            roaster = Roaster.find_or_initialize_by(name: normalize(params[:roaster][:name]))
            if roaster.persisted?
                if @coffee = roaster.coffees.find_by(name: normalize(params[:coffee][:name]), roast: params[:coffee][:roast])
                else
                    @coffee = roaster.coffees.build(params[:coffee]) 
                end
            else
                @coffee = roaster.coffees.build(params[:coffee])
            end 
        end
        
        @cup = @coffee.cups.build(params[:cup])
        @cup.user = current_user
        @cup.save
        
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

        if params[:roaster][:name] == ""
            @coffee = Coffee.find_or_initialize_by(name: normalize(params[:coffee][:name]), roast: params[:coffee][:roast], roaster_id: params[:coffee][:roaster_id]) 
        else
            roaster = Roaster.find_or_initialize_by(name: normalize(params[:roaster][:name]))
            if roaster.persisted?
                if @coffee = roaster.coffees.find_by(name: normalize(params[:coffee][:name]), roast: params[:coffee][:roast])
                else
                    @coffee = roaster.coffees.build(params[:coffee]) 
                end
            else
                @coffee = roaster.coffees.build(params[:coffee])
            end 
        end

        @cup.update(coffee: @coffee)

        erb :'cups/show'
    end

    get '/cups/:id' do
        if logged_in?
            if @cup = Cup.find_by(id: params[:id])
                erb :'/cups/show'
            else
                redirect '/cups'
            end
        else
            redirect '/login'
        end
    end

    delete '/cups/:id' do
        cup = Cup.find_by(id: params[:id])
        cup.destroy
        redirect '/cups'
    end

end
