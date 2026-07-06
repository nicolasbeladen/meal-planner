class UnsplashService
  BASE_URL = "https://api.unsplash.com"

  def self.search_photo(query)
    url = URI("#{BASE_URL}/search/photos?query=#{URI.encode_www_form_component(query)}&per_page=1")
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Client-ID #{ENV.fetch('UNSPLASH_ACCESS_KEY', nil)}"

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(request)
    end

    data = JSON.parse(response.body)
    data.dig("results", 0, "urls", "regular")
  end
end
