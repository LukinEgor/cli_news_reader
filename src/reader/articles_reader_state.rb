require './src/console'
require './src/cursor'
require './src/newsfeed_container'
require './src/reader/main_reader_state'
require './src/reader/reader_state'

class ArticlesReaderState < ReaderState
  def initialize(sources, position)
    @sources = sources
    @container = sources[position]
    @cursor = Cursor.new
    load_articles
    render
  end

  def load_articles
    render({ info: "Loading..." })
    @container.load
    @cursor.max = @container.articles.size
  end

  def next(command)
    case command
    when :back
      MainReaderState.new(@sources)
    else
      self
    end
  end

  def content
    @container.articles.map(&:header)
  end

  def up
    @cursor.up
    render
  end

  def down
    @cursor.down
    load_articles if @cursor.max?
    render
  end

  def render(*params)
    info_line = params.empty? ? { info: @container.name } : params[0]
    Console.render(content, @cursor.position, info_line)
  end

  def open
    system "chromium #{@container.articles[@cursor.position].link}"
  end
end
