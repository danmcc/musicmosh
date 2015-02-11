require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module CA
        class StaplesCenter
          def run
            json_data = KimonoHelper.fetch('awkn6bnu')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Staples Center'
            venue[:city] = 'Los Angeles'
            venue[:state] = 'CA'
            venue[:country] = 'US'
            return venue
          end
        end
      end
    end
  end
end