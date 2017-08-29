require 'net/http'
require 'json'
require './src/newsfeed'
require './src/article'

class HackerNews
  include NewsFeed

  @@domen = 'https://hacker-news.firebaseio.com'

  def name
    "Hacker News"
  end

  def articles(range)
    ids = top_stories_ids[range]
    ids.map { |id| article(id) }
  end

  private

  def article(id)
    url = "#{@@domen}/v0/item/#{id}.json"
    res = json_by_url(url)
    Article.new(res["title"], res["url"])
  end

  def top_stories_ids
    url = "#{@@domen}/v0/topstories.json"
    json_by_url(url)
  end

  def json_by_url(url)
    uri = URI(url)
    begin
      res = Net::HTTP.get(uri)
      JSON.parse(res)
    rescue
      []
    end
  end
end
