class Roaster < ActiveRecord::Base
    has_many :coffees
    before_validation :normalize_name
    validates :name, presence: true#, uniqueness: { case_sensitive: false } 

    def slug
        self.name.downcase.strip.gsub(' ', '-').gsub('&', 'and').gsub(/[^\w-]/, '')
    end
    
    def self.find_by_slug(slug)
        self.all.find {|roaster| roaster.slug == slug}
    end

    private
        def normalize_name
            self.name = name.split(' ').map {|w| w.downcase.capitalize}.join(' ')
        end
end