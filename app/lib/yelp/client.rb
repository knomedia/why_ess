class Yelp::Client

  YELP_API_BASE = ENV.fetch("YELP_API_BASE" || "https://api.yelp.com")
  YELP_API_KEY = ENV.fetch("YELP_API_KEY")
  LISTING_PATH = "v3/businesses"

  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def listing
    response = HTTParty.get(listing_url, {
      headers: request_headers
    })
    [response.code, JSON.parse(response.body)]
  end

  def listing_url
    "#{YELP_API_BASE}/#{LISTING_PATH}/#{id}"
  end

  def request_headers
    {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{YELP_API_KEY}",
    }
  end

end
