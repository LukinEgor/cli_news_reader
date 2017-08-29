require './src/console'
require './src/cursor'
require './src/newsfeed_container'
require './src/reader/main_reader_state'
require './src/reader/reader_state'
require './src/translator'

class ArticlesReaderState < ReaderState
  def initialize(sources, position)
    @sources = sources
    @container = sources[position.x]
    @cursor = Cursor.new
    load_articles
    render
  end

  def load_articles
    render({ info: "Loading..." })
    @container.load
    @cursor.max_y = @container.articles.size
    @cursor.max_x = word_count
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
    @cursor.max_x = word_count
    render
  end

  def down
    @cursor.down
    @cursor.max_x = word_count || 0
    load_articles if @cursor.max_y?
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

  def translate
    current_word = content[@cursor.position.y].split(' ')[@cursor.position.x]
    translate = Translator.exec(current_word)
    render({info: "#{current_word} - #{translate}"})
  end

  def render(*params)
    info_line = params.empty? ? { info: @container.name } : params[0]
    cursor_mode = { mode: :word }
    Console.render(content, @cursor.position, info_line.merge(cursor_mode))
  end

  def word_count
    line_content = content[@cursor.position.y]
    line_content.nil? ? 0 : line_content.split(' ').size - 1
  end

  def open
    system "chromium #{@container.articles[@cursor.position.y].link}"
  end
end
