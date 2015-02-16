require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module CA
        class TheWiltern
          def run
            json_data = KimonoHelper.fetch('7ewy2ze2')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'The Wiltern'
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