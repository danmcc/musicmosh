require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module CA
        class NokiaTheatreLaLive
          def run
            json_data = KimonoHelper.fetch('a8g2edqq')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Nokia Theatre LA Live'
            venue[:city] = 'Los Angeles'
            venue[:state] = 'CA'
            venue[:country] = 'US'
            venue[:latitude] = 34.044403
            venue[:longitude] = -118.267087
            return venue
          end
        end
      end
    end
  end
end