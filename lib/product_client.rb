class ProductClient < Client
  attr_reader :id

  # 255084653
  def initialize(id)
    @id = id
  end

  private

  def url_builder
    BASE_URL + "listing/" + id.to_s
  end
end