require './src/hacker_news'
require './src/reader'
require './src/command'
require 'io/console'
require './src/keyboard'

sources = Array.new
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)

reader = Reader.new(sources)

Keyboard.listen do |input|
  if input == "\u0003"
    puts "CONTROL-C"
    exit 0
  end
  command = Command.new(input)
  reader.exec(command)
end
