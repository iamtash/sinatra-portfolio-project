class Cup < ActiveRecord::Base
    belongs_to :user 
    belongs_to :coffee
end