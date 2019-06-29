class Coffee < ActiveRecord::Base
    belongs_to :roaster
    has_many :cups
    has_many :users, through: :cups

    ROASTS = ['light', 'medium', 'dark']

    def self.roasts
      ROASTS
    end
end
