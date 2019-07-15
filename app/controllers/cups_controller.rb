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
            @brews = Cup.brews
            erb :'/cups/new'
        else
            redirect '/login'
        end
    end

    post '/cups' do
        if logged_in?
            if params[:roaster][:name] == ""
                if !params[:coffee][:roaster_id]
                    redirect "/cups/new"
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
            
            @cup = @coffee.cups.build(params[:cup])
            @cup.user = current_user
            if @cup.save
                flash[:message] = "Your cup has been posted!"
            end
            redirect "/cups/#{@cup.id}"
        else
            redirect '/login'
        end
    end

    get '/cups/:id/edit' do
        if logged_in?
            if @cup = Cup.find_by(id: params[:id])
                @roasts = Coffee.roasts
                @roasters = Roaster.all
                @brews = Cup.brews - [@cup.brew] 
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

        if params[:cup][:brew]=="" || params[:coffee][:name]==""
            redirect "/cups/#{@cup.id}/edit"
        end

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
        flash[:message] = "Your cup has been updated!"
        redirect "/cups/#{@cup.id}"
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
        flash[:message] = "Your cup has been deleted!"
        redirect '/cups'
    end

end
