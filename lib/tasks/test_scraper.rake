require 'show_importer'

namespace :musicmosh do

  desc 'Test scraper'
  task :test_scraper, [:file] => [:environment] do |t, args|

    filename = 'lib/scrapers/' + args[:file]

    puts filename

    begin
      require_relative '../../' + filename
      split_filename = filename.split('/')

      # Compose the full path class name of the scraper
      class_name = 'MusicMosh::Scrapers' # initial modules
      class_name << '::' << split_filename[2].upcase # country
      class_name << '::' << split_filename[3].upcase # city
      class_name << '::' << File.basename(split_filename[4].camelize, '.rb') # venue

      # Run the scraper and pass through the shows to the ShowImporter
      # for validation and saving in the DB
      scraper = class_name.constantize.new
      shows = scraper.run

      puts shows

    rescue => e
      error_text = e.to_s + "\n" + e.backtrace.join("\n\t")
      puts error_text
      puts "#{filename} threw an exception while running"

    rescue LoadError
      puts "#{filename} couldn't be required. Please double check the filename"
    end

  end

end