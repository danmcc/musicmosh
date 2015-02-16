require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module IL
        class TheChicagoTheatre
          def run
            json_data = KimonoHelper.fetch('cfzwlobu')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'The Chicago Theatre'
            venue[:city] = 'Chicago'
            venue[:state] = 'IL'
            venue[:country] = 'US'
            return venue
          end
        end
      end
    end
  end
end