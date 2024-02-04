# frozen_string_literal: true

# Class to show HUD (Head Up Display) with game information.
class Hud
  attr_accessor :snake, :score, :time

  def initialize(snake:)
    @snake = snake
    @score = Text.new('Score: ', x: 500, y: 0, style: 'bold', size: 20, color: 'green', z: 10)
    @time = Text.new('Time: ', x: 10, y: 0, style: 'bold', size: 20, color: 'green', z: 10)
  end

  def update(tick:)
    score.text = score_text
    time.text = time_text(tick)
  end

  private

  def score_text
    "Score: #{snake.body.size.to_s.rjust(4, '0')}"
  end

  def time_text(tick)
    "Time: #{(tick / 100).to_s.rjust(4, '0')}"
  end
end
