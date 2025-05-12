require "gosu"
require_relative "point"
require_relative "constants"
require_relative "bullet"
require_relative "soundtrack"

SIZE = 30
X = Constants::WINDOW_WIDTH / 2 - SIZE
Y = Constants::WINDOW_HEIGHT - SIZE * 1.5
LIM_RIGHT = Constants::WINDOW_WIDTH - SIZE
LIM_LEFT = 0
RECOIL = 100

class Spaceship
  def initialize(speed = 500)
    @position = Point.new(X, Y)
    @speed = speed
    @last_fire = Gosu.milliseconds
  end
  
  def update(delta_time)
    Constants::KEYBINDS_MOVEMENTS.each do |direction, keys|
      if keys.all? { |k| Gosu.button_down?(k) }
        move(direction, delta_time)
      end
    end
  end

  def shoot
    now = Gosu.milliseconds
    return nil if (now - @last_fire) < RECOIL
    @last_fire = now
    Soundtrack::Shoot.play
    Bullet.new(@position.x, @position.y)
  end

  def move(direction, delta_time)
    dx = 0
    dx += 1 if direction == :right
    dx -= 1 if direction == :left
    x = @position.x + dx * @speed * delta_time
    @position.x = [LIM_LEFT, [LIM_RIGHT, x].min].max
  end

  def draw
    Gosu.draw_rect(@position.x, @position.y, SIZE, SIZE, Gosu::Color.argb(255, 255, 255, 255))
  end

end
