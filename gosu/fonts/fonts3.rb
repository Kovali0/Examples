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

    @font = Gosu::Font.new(self, './Strato-unlinked.ttf', 40)
  end

  def draw
    draw_background
    @font.draw(
      'Lorem ipsum dolor sit amet, consectetur',
      100, 200, Z::Text,
      1.0, 3.75, Gosu::Color.new(0xFF32E35B)
    )
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
