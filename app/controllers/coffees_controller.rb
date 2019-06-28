class CupsController < ApplicationController
    get '/coffees' do 
        erb :'/coffees/index'
    end
end