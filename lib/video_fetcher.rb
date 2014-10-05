class VideoFetcher

  def self.fetch(band_name)
    api_key = ENV['BING_API_KEY']
    no_of_result = 10
    bing_search = Bing.new(api_key, no_of_result, "Web")

    query_string = "#{band_name} site:youtube.com"
    search_results = bing_search.search(query_string)
    web_results = search_results[0][:Web]

    valid_results = []
    if web_results.any?
      web_results.each do |result|
        next unless result[:Url] =~ %r|^http://www.youtube.com/watch|
        valid_results.push(result[:Url])
      end
    end

    return valid_results
  end
end
