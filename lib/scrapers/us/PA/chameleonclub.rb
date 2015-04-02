require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module PA
        class Chameleonclub
          def run
            json_data = KimonoHelper.fetch('7z5ijrou')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Chameleon Club'
            venue[:city] = 'Lancaster'
            venue[:state] = 'PA'
            venue[:country] = 'US'
            venue[:latitude] = 40.04154
            venue[:longitude] = -76.308916
            return venue
          end
        end
      end
    end
  end
end
