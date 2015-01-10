require 'show_importer'

namespace :musicmosh do

  desc 'Run all the scrapers and store new shows in the DB'
  task :scraper => :environment do

    puts "Starting all scrapers...\n"

    imported_shows = 0

    Dir.glob('lib/scrapers/**/*.rb') do |file|

      puts "\n"
      puts 'Currently scrapping: ' + file

      # Run the scraper and keep a counter with the total imported shows
      scraping_result = run_scraper(file)
      imported_shows += scraping_result.is_a?(Numeric) ? scraping_result : 0

    end

    puts "\nFinished scrapping shows"
    puts "#{imported_shows} new shows were imported"

  end

  def run_scraper(filename)

    begin
      require_relative '../../' + filename
      split_filename = filename.split('/')

      # Compose the full path class name of the scraper
      class_name = 'MusicMosh::Scrapers' # initial modules
      class_name << '::' << split_filename[2].upcase # country
      class_name << '::' << split_filename[3].upcase # city
      class_name << '::' << File.basename(split_filename[4].capitalize, '.rb') # venue

      # Run the scraper and pass through the shows to the ShowImporter
      # for validation and saving in the DB
      scraper = class_name.constantize.new
      shows = scraper.run
      import_result = ShowImporter.import(shows)

      # If the ShowImporter result is a number, the scraping was successful
      # Otherwise there were errors validating at least one show
      if import_result.is_a? Numeric
        puts File.basename(split_filename[4].capitalize) + ": #{import_result} shows imported"
        return import_result
      else
        puts 'Validation errors at ' + File.basename(split_filename[4].capitalize)
        ap import_result
        puts "#{import_result} shows imported"
        return import_result[0]
      end

    rescue

      # exceptions should be handled gracefully
      # without breaking the whole scraping operation
      #
      # TODO: maybe add the file to some list for future relaunching
      puts $!
      puts "#{filename} threw an exception while running"

    rescue LoadError
      # TODO: failing to load a file should be immediately reported
      puts "#{filename} couldn't be required, please verify this manually"
    end
  end

end