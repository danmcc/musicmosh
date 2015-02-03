class Venue < ActiveRecord::Base
  belongs_to :shows

  def encoded_name
    CGI.escape(self.name)
  end

end
