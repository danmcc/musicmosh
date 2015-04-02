require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module CA
        class DolbyTheatre
          def run
            json_data = KimonoHelper.fetch('6urbqxam')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Dolby Theatre'
            venue[:city] = 'Los Angeles'
            venue[:state] = 'CA'
            venue[:country] = 'US'
            venue[:latitude] = 34.0694333
            venue[:longitude] = -118.339521
            return venue
          end
        end
      end
    end
  end
end