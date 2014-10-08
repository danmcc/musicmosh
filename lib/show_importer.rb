require 'hash_validator'
require 'countries'

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
      date: 'string'
    }

    errors = []
    shows.each do |show|

      validator = HashValidator.validate(show, show_validation)
      if validator.valid?
        artist = Artist.find_or_create_by!(
          name: show[:artist_name]
        )
        venue  = Venue.find_or_create_by!(
          name: show[:venue][:name],
          city: show[:venue][:city],
          state: show[:venue][:state],
          country: show[:venue][:country]
        )

        Show
          .create_with( url: show[:url] )
          .find_or_create_by!(
          artist_id: artist.id,
          venue_id:  venue.id,
          date: show[:date]
        )
      else
        errors.push( validator.errors )
      end
    end

    return errors.any? ? errors : nil
  end

end

