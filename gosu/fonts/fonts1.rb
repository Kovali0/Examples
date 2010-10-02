#!/usr/bin/env ruby
require 'rubygems'
require 'gosu'

module Z
  Background, Text = *1..100
end

class FontWindow < Gosu::Window
  WIDTH = 640
  HEIGHT = 480
  TITLE = "Gosu Font Window"

  TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
  BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)
  
  def initialize
    super(WIDTH, HEIGHT, false)
    self.caption = TITLE

    @font = Gosu::Font.new(self, Gosu.default_font_name, 40)
  end

  def draw
    draw_background
    @font.draw( "Hello, world!", 100, 100, Z::Text )
  end

  def draw_background
    draw_quad(
      0,     0,      TOP_COLOR,
      WIDTH, 0,      TOP_COLOR,
      0,     HEIGHT, BOTTOM_COLOR,
      WIDTH, HEIGHT, BOTTOM_COLOR,
      0)
  end
end

FontWindow.new.show
