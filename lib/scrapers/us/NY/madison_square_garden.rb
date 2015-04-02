require 'kimono_helper'

  module MusicMosh
    module Scrapers
      module US
        module NY
          class MadisonSquareGarden
            def run
              json_data = KimonoHelper.fetch('6802a5yu')
              shows = KimonoHelper.parse(json_data)
              venue_hash = self.venue
              shows.each do |show|
                show[:venue] = venue_hash
              end
            end

            def venue
              venue = Hash.new
              venue[:name] = 'Madison Square Garden'
              venue[:city] = 'New York'
              venue[:state] = 'NY'
              venue[:country] = 'US'
              venue[:latitude] = 40.750504
              venue[:longitude] = -73.993439
              return venue
            end
          end
        end
      end
    end
  end