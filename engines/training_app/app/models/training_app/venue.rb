module TrainingApp
  class Venue < ActiveRecord::Base
    #attr_accessible :name, :address, :city, :blurb
    has_many :courses

    geocoded_by :address
    after_validation :geocode
    
    before_validation :normalize_address
    validates :address, uniqueness: true, presence: true

    def map_url
      # address.titleize
      # <iframe width="300" height="250" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?q=1675+Owens+Street+San+Francisco,+CA+94143-3008&amp;oe=UTF-8&amp;ie=UTF8&amp;hq=&amp;ampgl=us&amp;t=h&amp;z=14&amp;ll=37.767832,-122.394186&amp;output=embed"></iframe>
    end

    private

    def normalize_address
      self.address = self.address.split(" ").join(" ").downcase if self.address.present?
    end

  end
end

