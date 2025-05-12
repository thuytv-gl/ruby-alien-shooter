require_relative "point"
require_relative "constants"
require_relative "alian"

ALIAN_SIZE = 22
BLOCK_SIZE = ALIAN_SIZE * 2

class AlianFleet
  def initialize(cols, rows)
    @cols = cols
    @rows = rows
    @alian_fleet = []
    @direction = 1
    offset_left = Constants::WINDOW_WIDTH / 2 - @cols * BLOCK_SIZE / 2
    (0..@rows).each do |py|
      (0..@cols).each do |px|
        x = offset_left + px * BLOCK_SIZE
        y = py * BLOCK_SIZE
        alian = Alian.new(x, y, ALIAN_SIZE, 12)
        @alian_fleet.push(alian)
      end
    end
  end
  
  def update(delta_time, bullets)
    @alian_fleet.each do |it|
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
    @alian_fleet.each { |it| it.draw }
  end

end
