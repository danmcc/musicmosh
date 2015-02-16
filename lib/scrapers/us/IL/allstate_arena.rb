require 'facebook_events_fetcher'

module MusicMosh
  module Scrapers
    module US
      module IL
        class AllstateArena
          def run
            shows = FacebookEventsFetcher.fetch('AllstateArena')
            venue_hash = self.venue
            shows.each do |show|
              next if show[:artist_name].nil?
              show[:venue] = venue_hash
            end
          end

          def venue
            venue = Hash.new
            venue[:name] = 'Allstate Arena'
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