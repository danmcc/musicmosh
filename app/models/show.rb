class Show < ActiveRecord::Base
  belongs_to :artist
  belongs_to :venue
end
