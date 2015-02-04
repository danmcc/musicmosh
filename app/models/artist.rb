class Artist < ActiveRecord::Base
  has_many :shows

  validates :name, presence: true

  def encoded_name
    CGI.escape(self.name)
  end

end