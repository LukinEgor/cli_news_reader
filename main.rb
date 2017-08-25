require './src/hacker_news'
require './src/reader'
require './src/command'

sources = Array.new
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)
sources.push(HackerNews.new)

reader = Reader.new(sources)

@keyboard_queue = Queue.new

#TODO don't work listening keyboard
Thread.new { listen_keyboard }

loop do
  unless @keyboard_queue.empty?
    input = @keyboard_queue.shift
    puts input
    command = Command.new(input)
    reader.exec(command)
  end
end

def listen_keyboard
  puts "run"
  loop do
    char = STDIN.getc
    @keyboard_queue << char if char
    puts char
  end
end
