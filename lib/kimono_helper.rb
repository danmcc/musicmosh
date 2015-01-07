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
			artist_name = item['band']['text']
			url = item['band']['href']
			date = item['date']

			if date.is_a?(Array)
				show_date = Chronic.parse(date.first)
			else
          		show_date = Chronic.parse(date)
				if show_date.nil?
					show_date = Time.parse(date)
				end
			end

			shows.push({
						   artist_name: artist_name,
						   url: url,
						   date: show_date,
					   })
		end

		return shows
	end

end
