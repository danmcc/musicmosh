class Venue < ActiveRecord::Base
  has_many :show

  reverse_geocoded_by :latitude, :longitude

  validates :name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true

  def encoded_name
    CGI.escape(self.name)
  end

end
