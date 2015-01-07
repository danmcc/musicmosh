task :scraper do

	puts "Starting all scrapers...\n"

	Dir.glob('lib/scrapers/**/*.rb') do |file|
		puts 'Currently scrapping: ' + file
		run_scraper(file)
	end
end

def run_scraper(filename)

	begin
		require_relative '../../' + filename
		split_filename = filename.split('/')
		class_name = "MusicMosh::Scrapers::" # initial modules
		class_name << split_filename[2].upcase # country
		class_name << split_filename[3].upcase # city
		class_name << File.basename(split_filename[4].capitalize, '.rb') # venue

		puts class_name

		scraper = class_name.constantize.new
		scraper.run

	rescue

		# exceptions should be handled gracefully
		# without breaking the whole scraping operation
		#
		# TODO: maybe add the file to some list for future relaunching
		puts $!, $@
		puts "#{filename} threw an exception while running"

	rescue LoadError
		# TODO: failing to load a file should be immediately reported
		puts "#{filename} couldn't be required, please verify this manually"
	end
end