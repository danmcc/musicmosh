class Venue < ActiveRecord::Base
  has_many :shows

  validates :name, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true

  def encoded_name
    CGI.escape(self.name)
  end

end
