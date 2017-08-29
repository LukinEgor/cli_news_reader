require './src/point'

class Cursor
  attr_accessor :max_x, :max_y
  attr_reader :position

  def initialize
    @position = Point.new
    @max_x = 0
    @max_y = 0
  end

  def max_x?
    @position.x == @max_x
  end

  def max_y?
    @position.y == @max_y
  end

  def down
    if @position.y != @max_y
      @position.y += 1
    end
  end

  def up
    if @position.y != 0
      @position.y -= 1
    end
  end

  def left
    if @position.x != 0
      @position.x -= 1
    end
  end

  def right
    if @position.x != @max_x
      @position.x += 1
    end
  end
end
