require 'koala'

class FacebookEventsFetcher

  def self.fetch(page_id)
    oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])

    token = oauth.get_app_access_token

    graph = Koala::Facebook::API.new(token)

    page_events = graph.get_object(page_id + '/events')

    page_events.each do |event|
      puts event['name']
      puts event['start_time']
      puts
    end

  end

  fetch('MadisonSquareGarden')

end