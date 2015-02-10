require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module NY
        class BeaconTheatre
          def run
            #kimono not working properly yet
            return []
            json_data = KimonoHelper.fetch('ab9shpq4')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Beacon Theatre'
            venue[:city] = 'New York'
            venue[:state] = 'NY'
            venue[:country] = 'US'
            return venue
          end
        end
      end
    end
  end
end