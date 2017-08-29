require './src/hacker_news'
require './src/reader'
require './src/command'
require './src/keyboard'

sources = []
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)

reader = Reader.new(sources)

Keyboard.new.listen do |input|
  action = Command.new(input).action
  reader.exec(action)
end
