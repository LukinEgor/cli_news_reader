require './src/console'
require './src/cursor'

class Reader
  def initialize(sources)
    @sources = sources
    @state = :main
    @cursor = Cursor.new
    @cursor.max = sources.size
    render
  end

  def exec(command)
    self.method(command.action).call
  end

  private

  def render
    lines = case @state
            when :main
              @sources.map(&:name)
            when :source
              @articles.map(&:header)
            end

    Console.render(lines, @cursor.position)
  end

  def up
    @cursor.up
  end

  def down
    @cursor.down
  end

  def back
    if @state == :source
      @state = :main
      render
    end
  end

  def open
    if @state == :main
      @state = :source
      @articles = @sources[@cursor].articles(0..10)
      @cursor.max = @articles.size
      render
    elsif @state == :source
      #open browser
    end
  end

  def nothing
    puts "this action don't work"
  end
end
