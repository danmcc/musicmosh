require 'kimono_helper'

module MusicMosh
	module Scrapers
		class USNYTerminal5music
			def run
				json_data = KimonoHelper.fetch('9gahya72')
				shows = KimonoHelper.parse(json_data)
				puts shows
			end
		end
	end
end