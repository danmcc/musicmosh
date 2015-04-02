require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module NY
        class BarclaysCenter
          def run
            json_data = KimonoHelper.fetch('6hjoi9yi')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Barclays Center'
            venue[:city] = 'New York'
            venue[:state] = 'NY'
            venue[:country] = 'US'
            venue[:latitude] = 40.682524
            venue[:longitude] = -73.975013
            return venue
          end
        end
      end
    end
  end
end