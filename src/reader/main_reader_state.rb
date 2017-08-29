require './src/console'
require './src/cursor'
require './src/newsfeed_container'
require './src/reader/articles_reader_state'
require './src/reader/reader_state'

class MainReaderState < ReaderState
  def initialize(sources)
    @sources = sources
    @cursor = Cursor.new
    @cursor.max_x = word_count
    @cursor.max_y = sources.size - 1
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
    @cursor.max_x = word_count
    render
  end

  def down
    @cursor.down
    @cursor.max_x = word_count
    render
  end

  def left
    @cursor.left
    render
  end

  def right
    @cursor.right
    render
  end

  def word_count
    content[@cursor.position.y].split(' ').size
  end

  def render
    info_line = { info: "Select source" }
    cursor_mode = { mode: :line }
    Console.render(content, @cursor.position, info_line.merge(cursor_mode))
  end
end
