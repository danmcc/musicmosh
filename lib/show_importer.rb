require 'hash_validator'
require 'countries'
require 'youtube_video_fetcher'

class ShowImporter

  def self.import(shows)
    show_validation = {
      artist_name: 'string',
      venue: {
        name:    'string',
        city:    'string',
        state:   lambda { |s| s.is_a?(String) && s.length == 2 },
        country: lambda { |c| ! Country.new(c).nil? },
      },
      date: 'time'
    }

    errors = []
    imported_shows = 0
    shows.each do |show|

      validator = HashValidator.validate(show, show_validation)
      if validator.valid?

        next unless Artist.new({:name => show[:artist_name]}).valid?

        next unless YoutubeVideoFetcher.fetch(show[:artist_name]).count > 0

        artist = Artist.find_or_create_by!(
          name: show[:artist_name]
        )

        venue  = Venue.find_or_create_by!(
          name: show[:venue][:name],
          city: show[:venue][:city],
          state: show[:venue][:state],
          latitude: show[:venue][:latitude],
          longitude: show[:venue][:longitude],
          country: show[:venue][:country]
        )

        conditions = {
          :artist_id => artist.id,
          :venue_id => venue.id,
          :date => show[:date].to_date
        }

        unless Show.exists?(conditions)
          Show.create(
            artist_id: artist.id,
            venue_id:  venue.id,
            url: show[:url],
            date: show[:date]
          )
          imported_shows += 1
        end

      else
        errors.push( validator.errors )
      end
    end

    return errors.any? ? [imported_shows, errors] : imported_shows
  end

end

