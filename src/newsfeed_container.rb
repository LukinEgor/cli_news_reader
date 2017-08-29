class NewsFeedContainer
  attr_reader :articles

  ARTICLES_ON_PAGE = 15

  def initialize(source)
    @source = source
    @articles = []
    @page = 0
  end

  def load
    @page += 1
    from = (@page - 1) * ARTICLES_ON_PAGE
    to = @page * ARTICLES_ON_PAGE
    new_articles = @source.articles(from...to)
    @articles.concat(new_articles)
  end

  def render
    @articles.map(&:header)
  end

  def name
    @source.name
  end

  def empty?
    @articles.empty?
  end
end
