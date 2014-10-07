require 'open-uri'
require 'json'
require 'chronic'

class KimonoHelper

  def self.fetch(api_id)
    url = "https://www.kimonolabs.com/api/#{api_id}?apikey=#{ENV['KIMONO_API_KEY']}"
    page_data = ""
    open(url) do |page|
      page_data += page.read
    end

    return JSON.parse(page_data)
  end

  def self.load_from_file(path) # for testing
    page_data = File.read(path)
    return JSON.parse(page_data)
  end

  def self.parse(data)
    shows = []

    data['results']['collection1'].each do |item|
      artist_name = item['artist']['text']
      url = item['artist']['href']
      date = item['date']

      if show_date.is_a?(Array)
        show_date = show_date.grep(%r|/|).first # naively assume dates will have slashes
      end
      show_date = Chronic.parse(show_date)

      shows.push({
        artist_name: artist_name,
        url: url,
        date: date,
      })
    end

    return shows
  end

end
