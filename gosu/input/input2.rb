#!/usr/bin/env ruby
require 'rubygems'
require 'gosu'
require 'yaml'
require 'base64'
require 'tempfile'

$data = YAML.parse(DATA.read)

def with_data(key,&block)
  Tempfile.open(File.basename(__FILE__)) do |tmp|
    tmp.binmode
    tmp.write( Base64.decode64($data[key].value) )
    tmp.close

    block.call(tmp.path)
  end
end

module Z
  Background, Player = *0..100
end

class Player
  attr_reader :x, :y

  # In pixels/second
  SPEED = 200

  def self.load(window)
    with_data('player.png') do|f|
      @@image = Gosu::Image.new(window, f, false)
    end
  end

  def initialize(window)
    @window = window
    @x = (@window.width / 2) - (@@image.width / 2)
    @y = @window.height - @@image.height
    @direction = 0
  end

  def update(delta)
    @direction = 0

    if @window.button_down?(Gosu::KbLeft)
      @direction -= 1
    end

    if @window.button_down?(Gosu::KbRight)
      @direction += 1
    end

    @x += @direction * SPEED * delta

    @x = 0 if @x < 0
    if @x > @window.width - @@image.width
      @x = @window.width - @@image.width
    end
  end

  def draw
    @@image.draw(@x, @y, Z::Player)
  end
end

class MyWindow < Gosu::Window
  WIDTH = 640
  HEIGHT = 480
  TITLE = "Input Example"

  TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
  BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)



  def initialize
    super(WIDTH, HEIGHT, false)
    self.caption = TITLE

    @last_frame = Gosu::milliseconds

    Player.load(self)
    @player = Player.new(self)
  end



  def update
    calculate_delta
    @player.update(@delta)
  end

  def calculate_delta
    @this_frame = Gosu::milliseconds
    @delta = (@this_frame - @last_frame) / 1000.0
    @last_frame = @this_frame
  end



  def draw
    draw_background
    @player.draw
  end

  def draw_background
    draw_quad(
      0,     0,      TOP_COLOR,
      WIDTH, 0,      TOP_COLOR,
      0,     HEIGHT, BOTTOM_COLOR,
      WIDTH, HEIGHT, BOTTOM_COLOR,
      Z::Background
    )
  end
end

MyWindow.new.show

__END__
--- 
player.png: |
  iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAAAXNSR0IArs4c
  6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAAd0
  SU1FB9gCGAIGHesMB8MAAAHVSURBVFjD7ZexboMwEIZ/I8Y+QSU6ROyVkLox
  ZwlS10pZ8xCkD1DlBbrlAegYySzM3SpF6W6yRKLv0OU6NFBCHILDkUQq/0KE
  fcen/3yODfTq1avX/5ZgykMd5WVJRMPhcOdFkiRskDYHnOd5ewNJkhAHpM0B
  5/s+giAAAEgpWSEtjjIEQQAiAhEVoFyyGRoCAPD2dXdsvjgHIA0Wvw6tH+XO
  wNPtRhtQmn9SuVlKLKUsSlxegxcpcdU57vltAIvymny4EmNcZtukMV4ePv/W
  XMNATQzL/rgDR0SUP3NtHaUoc6iqKHNosAi0MfmTy8FtvqNbyUHpYogIQohG
  TtZ1MSmlkKYp+wklTVMopdDESbsODgDm83nx8vnjvjRlA/f1GytvjBs/xmg0
  AgDEcYzV+xjucom1JmY6nQIAJpMJlFJwXbfWSbspHGOTFLmbQB5cg1U4nYNN
  VBeTQxqvQR1cVzr2La2Ds9msMyDT3LbBSZuYGI1ym+7oVImlBjDUxV3FCDoM
  w+LfIgxDYnT7+m91HOdBijKnOA9GmcO5XlngtIcFLkirrXOHxOWk1WLNifwe
  Uj6x5L+3Y6ItpHWG5hKX7uK9Upfcu55tJofkhGPv6GvaXs6mH5HTJzgvjhgR
  AAAAAElFTkSuQmCC

