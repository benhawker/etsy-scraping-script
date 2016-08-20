class ProductReader
  attr_reader :id, :page

  def initialize(id)
    @id = id
    @page = get_page
  end

  def read
    {
      title: title,
      price: price,
      currency_code: currency_code,
      favorite_count: favorite_count,
      seller_feedback_count: seller_feedback_count,
      seller_feedback_percentage: seller_feedback_percentage,
      ships_from: ships_from
    }
  end

  private

  def title #"Title"
    page.root.css("#listing-page-cart-inner > h1 > span").at('span').children.text
  end

  def price #"4.99"
    price = page.root.css("#listing-price > span.currency-value").at('span').children.text
    price.to_f
  end

  def currency_code #"US$"
    page.root.css("#listing-price > span.currency-symbol").at('span').children.text
  end

  #TODO: Deal with 0 favourites.
  def favorite_count #"3127 reviews"
    count = page.root.css("#item-overview > ul > li:nth-child(3) > a").children.text
    count = count[/(.*)\s/,1]
    count.to_i
  end

  def seller_feedback_count #"3127"
    count = page.at('meta[itemprop="count"]')[:content]
    count.to_i
  end

  def seller_feedback_percentage #"4.8861"
    percentage = page.at('meta[itemprop="rating"]')[:content]
    percentage.to_f.round(2)
  end

  #TODO: Deal with "Ships to XYZ from A"
  def ships_from #"Ships worldwide from Singapore"[/(.*)\s/,1]
    string = page.root.css("#item-overview > ul").children[2].text
    string.gsub("Ships worldwide from ", '')
  end

  def get_page
    ProductClient.new(id).get
  end
end