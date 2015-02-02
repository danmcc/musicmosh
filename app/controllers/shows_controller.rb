require 'youtube_video_fetcher'

class ShowsController < ApplicationController

  def location
		shows = Show.order(date: :asc).joins(:venue).joins(:artist).where(
			'shows.date >= :date AND venues.country = :country AND venues.state = :state AND venues.city = :city',
			{
				date: Date.today,
				country: params[:country],
				state: params[:state],
				city: CGI.unescape(params[:city])
			}
		).to_a.uniq!{ |s| s.artist_id }

		if shows.nil?
			#TODO - change the abort call with a view
			abort('This location has no shows yet')
    end

		# if there isn't any artist key, assume it's 1
		current_position = (params.has_key?(:position) ? params[:position].to_i : 1)

		# cycle through the artists
		next_position = (shows[current_position + 1].nil? ? 1 : current_position + 1)

		# subtract 1 from the position to match the array, which is starts at 0
		@show = shows[current_position - 1]

    unless current_user.nil?
      @favorite = Favorite.where(
        user_id: current_user.id,
        show_id: @show.id
      ).first
    end

		next_show = shows[next_position - 1]

		@link_to_next_show = view_context.link_to "Next Artist: " + next_show.artist.name, show_location_path(
																											:country => params[:country],
																											:state => params[:state],
																											:city => params[:city],
																											:position => next_position
																										), class: "btn btn-default", id: "next-show-link"

		@videos = YoutubeVideoFetcher.fetch(@show.artist.name)

	end

end
