class VenuesController < ApplicationController

  def show
    @venue = Venue.find_by(name: CGI.unescape(params[:id]))
  end

end