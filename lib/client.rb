class Client
  BASE_URL = "https://www.etsy.com/"

  def get
    http_client.get(url_builder)
  end

  private

  def http_client
    Mechanize.new
  end
end