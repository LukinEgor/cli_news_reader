require 'test/unit'
require './src/hacker_news'

class HackerNewsTest < Test::Unit::TestCase
  def test_get_name
    news = HackerNews.new
    assert_equal(news.name, "Hacker News")
  end

  def test_get_last_articles
    range = 0..0
    news = HackerNews.new
    actual = news.articles(range)
    assert_equal(actual.class, Array)
    assert_equal(actual.size, 1)
    assert_equal(actual[0].class, Article)
  end
end
