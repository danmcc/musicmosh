class ShowImporter

  def self.import(shows)
    shows.each do |show|
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

    end
  end

end

