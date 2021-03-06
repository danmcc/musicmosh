require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module NY
        class Terminal5Music
          def run
            json_data = KimonoHelper.fetch('ab9shpq4')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Terminal 5 Music'
            venue[:city] = 'New York'
            venue[:state] = 'NY'
            venue[:country] = 'US'
            venue[:latitude] = 40.769778
            venue[:longitude] = -73.993118
            return venue
          end
        end
      end
    end
  end
end
