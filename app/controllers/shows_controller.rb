require 'youtube_video_fetcher'

class ShowsController < ApplicationController

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
		current_position = (params.has_key?(:position) ? params[:position].to_i : 1)

		# cycle through the artists
		next_position = (shows[current_position + 1].nil? ? 1 : current_position + 1)

		# subtract 1 from the position to match the array, which is starts at 0
		@show = shows[current_position - 1]

		next_show = shows[next_position - 1]

		@link_to_next_show = view_context.link_to "Next Artist: " + next_show.artist.name, show_location_path(
																											:country => 'US',
																											:state => 'NY',
																											:city => 'New+York',
																											:position => next_position
																										), class: "btn btn-default"

		@videos = YoutubeVideoFetcher.fetch(@show.artist.name)

	end

end
