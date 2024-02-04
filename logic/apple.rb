# frozen_string_literal: true

# Class to create new apples on game
class Apple
  attr_reader :shape

  def initialize
    @shape = Square.new(x: rand(600), y: rand(400), size: 10, color: Settings::APPLE_DEFAULT_COLOR, z: 10)
  end
end
