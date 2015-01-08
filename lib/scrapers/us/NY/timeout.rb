module MusicMosh
	module Scrapers
		class USNYTimeout

			require 'chronic'
			require 'mechanize'

			def self.get url
				@agent ||= Mechanize.new
				@agent.get url
			end

			def self.scrape a
				url = URI.join(@url, a[:href]).to_s
				# debugger;
				puts url

				page = get url

				# artists
				artists = a.text.split(' + ')

				# venues
				v_name = page.at('address').parent.at('strong').text rescue nil
				v_location = page.at('address').text.strip rescue nil
				if v_name && v_location
					venue = {:name => v_name, :location => v_location}
				end

				# shows
				page.search('div.information').map(&:parent).each do |div|

					# more venue
					unless venue
						begin
							p = div.at 'p'
							v_name = p.at('a').remove.text
							p.search('a').remove
							v_location = p.text[/\w.*/].strip
							div_venue = {:name => v_name, :location => v_location}
						rescue
							puts "no venue!"
							next
						end
					end

					date_text = div.at('div.additionalInformation strong').text
					time_text = div.at('ul.timePrice li').text

					date = Chronic.parse(date_text).to_date
					time = Chronic.parse [date_text, time_text].join(' ').sub(/\w+ /, '')

					artists.each do |artist|
						show_data = {
							'artist_id' => artist.id,
							'venue_id' => venue ? venue : div_venue,
							'date' => date,
							'time' => time
						}
						@shows << show_data
					end

				end
			end

			@url = "http://www.timeout.com/newyork/search?section=live-music&keyword=&page_size=100&order=popularity"
			@shows = []

			page = get @url

			page.search('h2 a.url').each do |a|
				puts a.content
				scrape a
			end

			while next_link = page.at('a[title="Next page"]')
				url = URI.join(@url, next_link[:href]).to_s
				page = get url
				page.search('h2 a.url').each do |a|
					scrape a
				end
			end

			# return @shows
		end
	end
end