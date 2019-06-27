class Coffee < ActiveRecord::Base
    belongs_to :roaster
    has_many :cups 
    has_many :users, through: :cups 
end