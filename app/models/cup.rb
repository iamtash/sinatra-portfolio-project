class Cup < ActiveRecord::Base
    belongs_to :user
    belongs_to :coffee
    before_validation :normalize_brew
    validates :brew, :coffee, :user, presence: true
    validates_associated :coffee

    BREWS = ['Drip', 'Latte', 'Iced latte', 'Cappuccino', 'Iced coffee', 'Cold brew', 'Pourover', 'Americano', 'Espresso shot', 'Macchiato', 'Cortado', 'Flat white', 'Aeropress', 'Mocha', 'French press']

    def self.brews
      BREWS
    end
    
    def sip_time
        self.created_at.strftime("%A, %B %-d, %Y at %l:%M%P UTC")
    end

    def sip_date
        self.created_at.strftime("%A, %B %-d, %Y")
    end

    def a_or_an
        brew.start_with?(/[aeiou]/) ? 'an' : 'a'
    end

    private
        def normalize_brew
            self.brew = brew.split(' ').map {|w| w.downcase}.join(' ')
        end

end
