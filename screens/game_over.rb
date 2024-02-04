# frozen_string_literal: true

# Class to show Game Over screen.
class GameOver
  def initialize
    Text.new('GAME OVER', x: 120, y: 200, style: 'bold', size: 60, color: Settings::GAME_OVER_DEFAULT_TEXT_COLOR, z: 10)
  end
end
