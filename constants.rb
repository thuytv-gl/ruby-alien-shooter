require "gosu"

module Constants
  KEYBINDS_MOVEMENTS = {
    # :up => [Gosu::KB_W],
    # :down => [Gosu::KB_S],
    :left => [Gosu::KB_A],
    :right => [Gosu::KB_D],
  }

  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480

  KEYBINDS = {
    :quit => [Gosu::KB_LEFT_CONTROL, Gosu::KB_Q],
    :shoot => [Gosu::KB_SPACE],
  }

end

