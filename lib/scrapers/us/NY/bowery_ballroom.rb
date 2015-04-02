require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module NY
        class BoweryBallroom
          def run
            json_data = KimonoHelper.fetch('88z1k95e')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Bowery Ballroom'
            venue[:city] = 'New York'
            venue[:state] = 'NY'
            venue[:country] = 'US'
            venue[:latitude] = 40.720406
            venue[:longitude] = -73.993358
            return venue
          end
        end
      end
    end
  end
end