require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module IL
        class BottomLounge
          def run
            json_data = KimonoHelper.fetch('8pdmf368')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
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
            venue[:name] = 'Bottom Lounge'
            venue[:city] = 'Chicago'
            venue[:state] = 'IL'
            venue[:country] = 'US'
            return venue
          end
        end
      end
    end
  end
end