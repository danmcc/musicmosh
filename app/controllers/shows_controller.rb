require 'youtube_video_fetcher'

class ShowsController < ApplicationController

  def location

    artists_to_skip = []

    unless current_user.nil?
      artists_to_skip = current_user.artists_to_skip
    end

    shows = Show.order(date: :asc).joins(:venue).joins(:artist).where(
      'shows.date >= :date AND venues.country = :country AND venues.state = :state AND venues.city = :city AND shows.artist_id NOT IN (:artists_to_skip)',
      {
        date: Date.today,
        country: params[:country],
        state: params[:state],
        city: CGI.unescape(params[:city]),
        artists_to_skip: artists_to_skip << 0 #append 0 to ensure we are passing a valid array
      }
    ).to_a.uniq! { |s| s.artist_id }

    raise ActionController::RoutingError.new('Not Found') if shows.nil?

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

    @link_to_next_show = view_context.link_to "Next Artist: " + next_show.artist.name, show_location_path(
                                                                                       :country => params[:country],
                                                                                       :state => params[:state],
                                                                                       :city => params[:city],
                                                                                       :position => next_position
                                                                                     ), class: "btn btn-default", id: "next-show-link"

    @videos = YoutubeVideoFetcher.fetch(@show.artist.name)

  end

end
