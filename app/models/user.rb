class User < ActiveRecord::Base
    has_secure_password
    has_many :cups 
    has_many :coffees, through: :cups
    before_validation :normalize_name
    validates :email, {presence: true, uniqueness: { case_sensitive: false }}
    validates :name, :password, presence: true

    def slug
        self.name.downcase.strip.gsub(' ', '-').gsub('&', 'and').gsub(/[^\w-]/, '')
    end
    
    def self.find_by_slug(slug)
        self.all.find {|user| user.slug == slug}
    end

    private
        def normalize_name
            self.name = name.split(' ').map {|w| w.downcase.capitalize}.join(' ')
        end
end