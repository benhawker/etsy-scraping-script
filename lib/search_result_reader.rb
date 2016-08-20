class SearchResultReader
  attr_reader :search_term, :search_filters, :category, :products

  MAX_PAGES = 3 #Place a temporary hard limit of the number of pages we can crawl.

  def initialize(search_term, category=nil, search_filters={})
    @search_term = search_term
    @search_filters = search_filters
    @category = category
    @products = []
  end

  def read
    page_number = 1

    while page_number <= MAX_PAGES
      #Returns Mechanize::Page object
      page = get_page(page_number)

      # Returns Nokogiri::XML::NodeSet (a colletion of 48)
      products_found = page.root.css("div.card-meta.m-xs-1")

      products_found.each do |product|
        title = product.children[1].text.strip
        price_currency = product.children[3].children[1].text.strip
        price = price_currency.gsub("US$", "").to_f
        currency = "US$"

        products << { title: title, price: price, currency: currency, page: page_number }
      end

      page_number += 1
    end
  end

  private

  # https://www.etsy.com/search?q=silver+necklace&order=price_desc&min=10&max=50&page=2
  def get_page(page_number=1)
    search_filters.merge!( { page: page_number } )
    SearchClient.new(search_term, :search, category, search_filters).get
  end

end