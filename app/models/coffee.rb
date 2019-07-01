class Coffee < ActiveRecord::Base
    belongs_to :roaster
    has_many :cups
    has_many :users, through: :cups

    validates :name, :roast, :roaster, presence: true

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
end
