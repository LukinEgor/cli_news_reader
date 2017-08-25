class Article
  attr_accessor :header
  attr_accessor :link

  def initialize(header, link)
    @header = header
    @link = link
  end
end
