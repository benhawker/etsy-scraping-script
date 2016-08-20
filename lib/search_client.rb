class Client
  #https://www.etsy.com/search?q=silver+necklace&order=price_desc&min=10&max=50&page=2
  attr_reader :search_term, :category, :search_filters

  # 255084653
  def initialize(search_term, category=nil, search_filters={})
    @search_term = search_term
    @category = category
    @search_filters = search_filters
  end

  private

  def url_builder
    if category
      BASE_URL + "search/" + category.to_s + "?q=" + id.to_s + search_filter_builder
    else
      BASE_URL + "search?q=" + id.to_s + search_filter_builder
    end
  end

  # "&page=#{}&order=#{}&min=#{}&max=#{}"
  def search_filter_builder
    query_string = ""

    search_filters.each do |k, v|
      query_string << "&" + k.to_s + "=" + v.to_s if v
    end
    query_string
  end

  # {
  #   page:  1,
  #   order: nil,
  #   min:   10,
  #   max:   50
  # }
  # def search_filters_hash
  #   {
  #     page:  search_filters[:page]
  #     order: search_filters[:order]
  #     min:   search_filters[:min]
  #     max:   search_filters[:max]
  #   }
  # end

  def format_search_term
    # Remove leading a trailing whitespace
    search_term = search_term.to_s.strip
    # Substitute any whitespace for +
    search.gsub(" ", "+")
  end

end