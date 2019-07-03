class Cup < ActiveRecord::Base
    belongs_to :user 
    belongs_to :coffee

    validates :brew, :coffee, :user, presence: true

    def sip_time 
        self.created_at.strftime("%A, %B %-d, %Y at %l:%M%P UTC")
    end

    def sip_date
        self.created_at.strftime("%A, %B %-d, %Y")
    end

end