class User < ActiveRecord::Base
    has_secure_password
    has_many :cups 
    has_many :coffees, through: :cups
    validates :name, :email, :password, presence: true
end