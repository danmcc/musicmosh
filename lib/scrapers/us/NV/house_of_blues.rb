require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module NV
        class HouseOfBlues
          def run
            #faulty kimono API
            return []
            json_data = KimonoHelper.fetch('9s6cltuu')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'House Of Blues'
            venue[:city] = 'Las Vegas'
            venue[:state] = 'NV'
            venue[:country] = 'US'
            return venue
          end
        end
      end
    end
  end
end