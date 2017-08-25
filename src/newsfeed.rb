module NewsFeed
  def name
    raise NotImplementedError
  end

  def articles(range)
    raise NotImplementedError
  end

  def open_article(number)
    raise NotImplementedError
  end
end
