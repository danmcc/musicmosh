require 'koala'
require 'chronic'

class FacebookEventsFetcher

  def self.fetch(page_id)
    oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])

    token = oauth.get_app_access_token

    graph = Koala::Facebook::API.new(token)

    page_events = graph.get_object(page_id + '/events')

    shows = []

    page_events.each do |event|

      shows << {
        artist_name: event['name'],
        url: 'https://www.facebook.com/events/' + event['id'],
        date: Time.parse(event['start_time'])
      }

    end

    return shows

  end

  puts fetch('MadisonSquareGarden')

end