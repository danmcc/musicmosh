require 'kimono_helper'

module MusicMosh
  module Scrapers
    module US
      module CA
        class RubySkyes
          def run
            json_data = KimonoHelper.fetch('atwmpmb4')
            shows = KimonoHelper.parse(json_data)
            venue_hash = self.venue
            shows.each do |show|
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Ruby Skyes'
            venue[:city] = 'San Francisco'
            venue[:state] = 'CA'
            venue[:country] = 'US'
            venue[:latitude] = 37.7875072
            venue[:longitude] = -122.4073588
            return venue
          end
        end
      end
    end
  end
end