require './src/console'
require './src/cursor'
require './src/newsfeed_container'
require './src/reader/articles_reader_state'
require './src/reader/reader_state'

class MainReaderState < ReaderState
  def initialize(sources)
    @sources = sources
    @cursor = Cursor.new
    @cursor.max = sources.size - 1
    render
  end

  def next(command)
    case command
    when :open
      ArticlesReaderState.new(@sources, @cursor.position)
    else
      self
    end
  end

  def content
    @sources.map(&:name)
  end

  def up
    @cursor.up
    render
  end

  def down
    @cursor.down
    render
  end

  def render
    Console.render(content, @cursor.position, { info: "Select source" })
  end
end
