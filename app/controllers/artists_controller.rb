require 'youtube_video_fetcher'

class ArtistsController < ApplicationController

  def show
    @artist = Artist.find_by(name: CGI.unescape(params[:id]))
    @videos = YoutubeVideoFetcher.fetch(@artist.name)

    @upcoming_shows = Show.joins(:venue).where('artist_id = :artist AND date >= :date',
                        {
                          artist: @artist.id,
                          date: Date.new(2001,2,3)
                        })
  end

end