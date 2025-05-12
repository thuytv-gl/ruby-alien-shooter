require_relative "point"
require_relative "constants"

class Bullet
  def initialize(x, y, speed = 200)
    @position = Point.new(x, y)
    @speed = speed
    @alive = true
    @size = 10
  end
  
  def update(delta_time)
    return if not @alive

    @position.y = @position.y - @speed * delta_time
  end

  def draw
    return if not @alive
    Gosu.draw_rect(@position.x, @position.y, @size, @size, Gosu::Color.argb(255, 0, 255, 255))
  end

  def bounds
    {
      "x" => @position.x,
      "y" => @position.y,
      "size" => @size
    }
  end

end
