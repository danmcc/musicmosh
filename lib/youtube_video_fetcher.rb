require 'google/api_client'

class YoutubeVideoFetcher

  DEVELOPER_KEY = ENV['YOUTUBE_API_KEY']
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def self.get_service
    client = Google::APIClient.new(
      :key => DEVELOPER_KEY,
      :authorization => nil,
      :application_name => $PROGRAM_NAME,
      :application_version => '1.0.0'
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    return client, youtube
  end

  def self.search_youtube(band_name, results, duration)
    client, youtube = get_service

    begin
      videos = []

      # Call the search.list method to retrieve results matching the specified
      # query term.
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => band_name,
          :maxResults => results,
          :type => 'video',
          :videoDuration => duration
        }
      )

      search_response.data.items.each do |search_result|
        videos.push(search_result.id.videoId)
      end

      return videos

    rescue Google::APIClient::TransmissionError => e
      puts e.result.body

    end
  end

  def self.fetch(band_name)

    videos = []

    videos.push(search_youtube(band_name, 4, 'short')).flatten!
    videos.push(search_youtube(band_name, 6, 'medium')).flatten!

    return videos

  end

end