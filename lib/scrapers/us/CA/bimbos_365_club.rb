require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module CA
        class Bimbos365Club
          def run
            json_data = KimonoHelper.fetch('1yn4ckom')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Bimbo\'s 365 Club'
            venue[:city] = 'San Francisco'
            venue[:state] = 'CA'
            venue[:country] = 'US'
            venue[:latitude] = 37.803756
            venue[:longitude] = -122.415525
            return venue
          end
        end
      end
    end
  end
end