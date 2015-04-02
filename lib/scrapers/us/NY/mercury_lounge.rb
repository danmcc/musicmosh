require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module NY
        class MercuryLounge
          def run
            json_data = KimonoHelper.fetch('6wf16j5q')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Mercury Lounge'
            venue[:city] = 'New York'
            venue[:state] = 'NY'
            venue[:country] = 'US'
            venue[:latitude] = 40.722108
            venue[:longitude] = -73.986794
            return venue
          end
        end
      end
    end
  end
end