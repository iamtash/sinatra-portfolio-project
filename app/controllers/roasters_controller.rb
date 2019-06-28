class CupsController < ApplicationController
    get '/roasters' do 
        erb :'/roasters/index'
    end
end