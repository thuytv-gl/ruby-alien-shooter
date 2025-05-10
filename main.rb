require "gosu"

WIDTH, HEIGHT = 640, 480

class Welcome < Gosu::Window
  PADDING = 20

  def initialize
    super(WIDTH, HEIGHT)
    
    self.caption = "Welcome!"

    text =
      "<b>Hello world</b>
      Welcome to <b>Gosu</b>"
    text.gsub! /^ +/, ""

    @text = Gosu::Image::from_markup(text, 80, { width: WIDTH - 2 * PADDING })
  end

  def draw
    @text.draw(PADDING, PADDING, 0)
  end
end

Welcome.new.show if __FILE__ == $0
