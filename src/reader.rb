require './src/console'
require './src/cursor'

class Reader
  def initialize(sources)
    @sources = sources

    #TODO think about state machine
    @state = :main
    @cursor = Cursor.new
    @cursor.max = sources.size - 1
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
    render
  end

  def down
    @cursor.down
    render
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
      @articles ||= @sources[@cursor.position].articles(0..10)
      @cursor.max = @articles.size - 1
      render
    elsif @state == :source
      system "chromium #{@articles[@cursor.position].link}"
    end
  end

  def nothing
    puts "this action don't work"
  end
end
