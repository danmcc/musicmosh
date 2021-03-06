class UsersController < ApplicationController

  def index
    venues = Venue.select(:city, :state, :country).distinct

    @locations = []

    venues.each do |venue|
      @locations << {
        :name => venue.city + ', ' + venue.state + ', ' + venue.country,
        :url => show_location_path(venue.country, venue.state, CGI.escape(venue.city))
      }
    end
  end

  def manage
    @favorites = current_user.favorites
                   .includes(:show => :artist)
                   .includes(:show => :venue)

    @thumbs_down = current_user.thumbs_downs
                    .includes(:show => :artist)
                    .includes(:show => :venue)


  end

end
