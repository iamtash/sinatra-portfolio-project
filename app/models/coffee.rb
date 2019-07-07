class Coffee < ActiveRecord::Base
    belongs_to :roaster
    has_many :cups
    has_many :users, through: :cups

    validates :name, :roast, :roaster, presence: true
    validates_associated :roaster
    #validate :coffees_with_same_name_cant_belong_to_same_roaster

    ROASTS = ['light', 'medium', 'dark']

    def self.roasts
      ROASTS
    end

    def slug
      self.name.downcase.strip.gsub(' ', '-').gsub('&', 'and').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(slug)
      self.all.find {|coffee| coffee.slug == slug}
    end

    # def coffees_with_same_name_cant_belong_to_same_roaster
    #   # if there is a duplicate coffee name, only allow it to save if ROASTER names are unique
    #   # e.g. multiple coffee roasters can produce a 'french roast' coffee
    #   if self.class.find_by(name: self.name)
    #     if Roaster.find_by(name: self.roaster.name)
    #       errors.add(:roaster, "can't have duplicate coffees from same roaster")
    #     end
    #   end
    # end

    def pretty_name
      self.name.split(' ').map {|w| w.downcase.capitalize}.join(' ')
    end
end
