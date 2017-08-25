class Cursor
  attr_reader :position

  def initialize
    @position = 0
  end

  def max=(max)
    @max = max
    @position = 0
  end

  def up
    if @position == @max
      @position = 0
    else
      @position += 1
    end
  end

  def down
    if @position == 0
      @position = @max
    else
      @position -= 1
    end
  end
end
