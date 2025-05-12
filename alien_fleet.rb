require_relative "point"
require_relative "constants"
require_relative "alien"

ALIEN_SIZE = 22
BLOCK_SIZE = ALIEN_SIZE * 2

class AlienFleet
  def initialize(cols, rows)
    @cols = cols
    @rows = rows
    @alien_fleet = []
    @direction = 1
    offset_left = Constants::WINDOW_WIDTH / 2 - @cols * BLOCK_SIZE / 2
    (0..@rows).each do |py|
      (0..@cols).each do |px|
        x = offset_left + px * BLOCK_SIZE
        y = py * BLOCK_SIZE
        alien = Alien.new(x, y, ALIEN_SIZE, 12)
        @alien_fleet.push(alien)
      end
    end
  end
  
  def update(delta_time, bullets)
    @alien_fleet.each do |it|
      it.update(delta_time, @direction)

      bullets.each do |bullet|
        if it.got_hit_by(bullet)
          bullets.delete(bullet)
          it.unalive
          break
        end
      end

      if it.hit_wall
        @direction = -@direction
        break
      end
    end
  end

  def draw
    @alien_fleet.each { |it| it.draw }
  end

end
