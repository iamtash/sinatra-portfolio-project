class Roaster < ActiveRecord::Base
    has_many :coffees

    validates :name, presence: true, uniqueness: { case_sensitive: false } 

    def slug
        self.name.downcase.strip.gsub(' ', '-').gsub('&', 'and').gsub(/[^\w-]/, '')
      end
    
      def self.find_by_slug(slug)
        self.all.find {|roaster| roaster.slug == slug}
      end
end