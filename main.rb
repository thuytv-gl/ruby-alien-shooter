require "gosu"
require_relative "constants"
require_relative "point"
require_relative "spaceship"
require_relative "alien_fleet"

class Game < Gosu::Window
  PADDING = 20

  def initialize
    super(Constants::WINDOW_WIDTH, Constants::WINDOW_HEIGHT)
    
    self.caption = "Astro pew pew"
    @rect = Point.new(0, 0)
    @last_update = Gosu.milliseconds
    @delta_time = 0
    @spaceship = Spaceship.new

    @alien_fleet = AlienFleet.new(12, 3)
    @bullets = []
  end

  def draw
    @spaceship.draw
    @alien_fleet.draw
    @bullets.each { |it| it.draw }
  end

  def update
    now = Gosu.milliseconds
    @delta_time = (now - @last_update) / 1000.0
    @last_update = now

    @bullets.each { |it| it.update(@delta_time) }
    @spaceship.update(@delta_time)
    @alien_fleet.update(@delta_time, @bullets)
  end

  def button_down(button)
    Constants::KEYBINDS.each do |action, keys|
      if keys.all? { |k| Gosu.button_down?(k) }
        handle_action(action)
      end
    end
  end

  def handle_action(action)
    case action
    when :shoot
      bullet = @spaceship.shoot
      if bullet != nil
        @bullets.push(bullet)
      end
    when :quit
      close
    end
  end

end

Game.new.show if __FILE__ == $0
