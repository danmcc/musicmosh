require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module CA
        class Echoplex
          def run
            json_data = KimonoHelper.fetch('cexfpirg')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Echoplex'
            venue[:city] = 'Los Angeles'
            venue[:state] = 'CA'
            venue[:country] = 'US'
            venue[:latitude] = 34.077657
            venue[:longitude] = -118.260479
            return venue
          end
        end
      end
    end
  end
end