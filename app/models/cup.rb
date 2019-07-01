class Cup < ActiveRecord::Base
    belongs_to :user 
    belongs_to :coffee

    validates :name, :brew, presence: true

    def sip_time 
        self.created_at.strftime("%A, %B %-d, %Y at %l:%M%P UTC")
    end

end