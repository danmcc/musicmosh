require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module CA
        class TheFillmore
          def run
            json_data = KimonoHelper.fetch('8mbsz0xs')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'The Fillmore'
            venue[:city] = 'San Francisco'
            venue[:state] = 'CA'
            venue[:country] = 'US'
            venue[:latitude] = 34.090908
            venue[:longitude] = -122.4328185
            return venue
          end
        end
      end
    end
  end
end