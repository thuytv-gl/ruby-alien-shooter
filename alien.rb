require_relative "point"
require_relative "constants"

class Alien
  def initialize(x, y, size, speed = 8)
    @position = Point.new(x, y)
    @speed = speed
    @alive = true
    @size = size
  end
  
  def update(delta_time, delta)
    return if not @alive
    @position.y = @position.y + @speed * delta_time
    @position.x = @position.x + @speed * delta_time * delta
  end

  def hit_wall
    return @position.x + @size >= Constants::WINDOW_WIDTH || @position.x <= 0
  end

  def draw
    return if not @alive
    Gosu.draw_rect(@position.x, @position.y, @size, @size, Gosu::Color.argb(255, 255, 50, 50))
  end


  def got_hit_by(bullet)
    return false if not @alive

    bounds = bullet.bounds
    if bounds['x'] + bounds['size'] > @position.x and
        bounds['x'] < @position.x + @size and
        bounds['y'] + bounds['size'] > @position.y and
        bounds['y'] < @position.y + @size
      return true
    end
    return false
  end

  def unalive
    @alive = false
  end

end
