class Cursor
  attr_reader :position

  def initialize
    @position = 0
  end

  def max=(max)
    @max = max
  end

  def max?
    @position == @max
  end

  def down
    if @position != @max
      @position += 1
    end
  end

  def up
    if @position != 0
      @position -= 1
    end
  end
end
