# frozen_string_literal: true

require 'ruby2d'
require_relative 'logic/game_logic'
require_relative 'logic/snake'

set title: 'Snake Game'

snake = Snake.new
game_logic = GameLogic.new(snake: snake)

on :key_down do |event|
  snake.allowed_direction(event.key)
end

update do
  unless game_logic.game_over?
    snake.move

    game_logic.create_apples
    game_logic.check_snake_and_apple_collition
    game_logic.increase_snake_speed
    game_logic.update_hud

    game_logic.show_game_over if game_logic.snake_collition?

    game_logic.increase_tick
  end
end

show
