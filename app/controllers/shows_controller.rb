require 'youtube_video_fetcher'

class ShowsController < ApplicationController

  def location

    artists_to_skip = []

    unless current_user.nil?
      artists_to_skip = current_user.artists_to_skip
    end

    artists_to_skip += Report.all.includes(:show => :artist).pluck(:artist_id)

    if params[:lat].nil?
      geocoder_query = CGI.unescape(params[:city]) + ', ' + params[:state] + ', ' + params[:country]
    else
      geocoder_query = [params[:lat], params[:lon]]
    end

    shows = Venue.near(geocoder_query, 20, :select => 'venues.*, shows.*, artists.name as artist_name').joins(:show => :artist).order('date ASC').where(
      'shows.date >= :date AND shows.artist_id NOT IN (:artists_to_skip)',
      {
        date: Date.today,
        artists_to_skip: artists_to_skip << 0 #append 0 to ensure we are passing a valid array
      }
    ).to_a.uniq! { |s| s.artist_id }

    return render "shows/no_shows" if shows.nil?

    # if there isn't any artist key, assume it's 1
    current_position = (params.has_key?(:position) ? params[:position].to_i : 1)

    # cycle through the artists
    next_position = (shows[current_position + 1].nil? ? 1 : current_position + 1)

    # subtract 1 from the position to match the array, which starts at 0
    @show = shows[current_position - 1]

    raise ActionController::RoutingError.new('Not Found') if @show.nil?

    unless current_user.nil?
      @favorite = Favorite.where(
        user_id: current_user.id,
        show_id: @show.id
      ).first_or_initialize

      @thumbs_down = ThumbsDown.where(
        user_id: current_user.id,
        show_id: @show.id
      ).first_or_initialize

      @report = Report.where(
        user_id: current_user.id,
        show_id: @show.id
      ).first_or_initialize
    else
      @favorite = Favorite.new(
        show_id: @show.id
      )

      @thumbs_down = ThumbsDown.new(
        show_id: @show.id
      )

      @report = Report.new(
        show_id: @show.id
      )
    end

    next_show = shows[next_position - 1]

    if params[:lat].nil?
      @link_to_next_show = view_context.link_to "Next Artist: " + next_show.artist_name, show_location_path(
                                                                                         :country => params[:country],
                                                                                         :state => params[:state],
                                                                                         :city => params[:city],
                                                                                         :position => next_position
                                                                                       ), class: "btn btn-default", id: "next-show-link"
    else
      @link_to_next_show = view_context.link_to "Next Artist: " + next_show.artist_name, show_location_coordinates_path(
                                                                                         :lat => params[:lat],
                                                                                         :lon => params[:lon],
                                                                                         :position => next_position
                                                                                       ), class: "btn btn-default", id: "next-show-link"
    end


    @videos = YoutubeVideoFetcher.fetch(@show.artist_name)

  end

end
