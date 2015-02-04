class Show < ActiveRecord::Base
  belongs_to :artist
  belongs_to :venue

  validates :artist, presence: true
  validates :venue, presence: true

  def show_date
    date.strftime("%A, #{date.day.ordinalize} of %B %Y") + (time.nil? ? "" : time.strftime("%l:%M %p"))
  end
end
