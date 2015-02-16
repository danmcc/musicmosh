require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module NV
        class TheColosseumCaesarsPalace
          def run
            json_data = KimonoHelper.fetch('85awrb3o')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'The Colosseum Caesars Palace'
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