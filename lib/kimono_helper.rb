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

      show_date = parse_date(item)

      show_url = parse_url(item)

      if item['band'].is_a?(Array)
        item['band'].each do |band|
          shows << {
            artist_name: band['text'],
            url: show_url,
            date: show_date,
          }
        end
      else
        shows << {
          artist_name: item['band']['text'],
          url: show_url,
          date: show_date,
        }
      end
    end

    return shows
  end

  def self.parse_url(item)
    if item['band']['href'].nil?
      show_url = item['url']['href']
    else
      show_url = item['band']['href']
    end
    show_url
  end

  def self.parse_date(item)
    date = item['date']

    if date.is_a?(Array)
      #if the date had to be parsed into an array, merge it in a string and parse it
      show_date = Chronic.parse(date.join(' '))
    else
      show_date = Chronic.parse(date)
      if show_date.nil?
        show_date = Time.parse(date)
      end
    end
    show_date
  end

end
