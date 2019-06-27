class CupsController < ApplicationController
    get '/cups' do 
        erb :'/cups/index'
    end
end