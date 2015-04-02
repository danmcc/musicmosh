require 'facebook_events_fetcher'

module MusicMosh
  module Scrapers
    module US
      module CA
        class BottomOfTheHill
          def run
            shows = FacebookEventsFetcher.fetch('bottomofthehill')
            venue_hash = self.venue
            shows.each do |show|
              next if show[:artist_name].nil?

              split_multiple_artists(show, shows, venue_hash)

              show[:venue] = venue_hash
            end
          end

          def split_multiple_artists(show, shows, venue_hash)
            multiple_artists = show[:artist_name].split(' ~ ')

            if multiple_artists.length > 1
              show[:artist_name] = multiple_artists[0].to_s.strip

              for i in 1..multiple_artists.length
                shows << {
                  artist_name: multiple_artists[i].to_s.strip,
                  url: show[:url],
                  venue: venue_hash,
                  date: show[:date]
                }
              end
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Bottom Of The Hill'
            venue[:city] = 'San Francisco'
            venue[:state] = 'CA'
            venue[:country] = 'US'
            venue[:latitude] = 37.76499
            venue[:longitude] = -122.396435
            return venue
          end
        end
      end
    end
  end
end