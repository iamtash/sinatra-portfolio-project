class Coffee < ActiveRecord::Base
    belongs_to :roaster
    has_many :cups
    has_many :users, through: :cups
    before_validation :normalize_name
    validates :name, :roast, :roaster, presence: true
    #validates_associated :roaster

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

    private
      def normalize_name
        self.name = name.split(' ').map {|w| w.downcase.capitalize}.join(' ')
      end
end
