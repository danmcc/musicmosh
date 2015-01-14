class Show < ActiveRecord::Base
  belongs_to :artist
  belongs_to :venue

  def show_date
    date.strftime("%A, #{date.day.ordinalize} of %B %Y") + (time.nil? ? "" : time.strftime("%l:%M %p"))
  end
end
