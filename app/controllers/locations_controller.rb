class LocationsController < ApplicationController

	def show
		shows = Show.order(date: :asc).joins(:venue).joins(:artist).where(
			'shows.date >= :date AND venues.country = :country AND venues.state = :state AND venues.city = :city',
			{
				date: Date.today,
				country: params[:country],
				state: params[:state],
				city: CGI.unescape(params[:city])
			}
		).to_a.uniq!{ |s| s.artist_id }

		# if there isn't any artist key, assume it's 1
		current_artist = (params.has_key?(:artist) ? params[:artist].to_i : 1)

		# if the next artist does not exist, go back to the first
		@next_artist = (shows[current_artist + 1].nil? ? 1 : current_artist + 1)

		@show = shows[current_artist - 1]

		@next_show = shows[@next_artist - 1]

	end

end
