require './src/hacker_news'
require './src/reader'
require './src/command'
require './src/keyboard'

sources = Array.new
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)

reader = Reader.new(sources)

Keyboard.new.listen do |input|
  command = Command.new(input)
  reader.exec(command)
end
