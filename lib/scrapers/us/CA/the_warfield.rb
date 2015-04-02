require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module CA
        class TheWarfield
          def run
            json_data = KimonoHelper.fetch('8qo1ve06')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'The Warfield'
            venue[:city] = 'San Francisco'
            venue[:state] = 'CA'
            venue[:country] = 'US'
            venue[:latitude] = 37.782739
            venue[:longitude] = -122.410156
            return venue
          end
        end
      end
    end
  end
end