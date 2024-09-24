# frozen_string_literal: true

require_relative 'snake'
require_relative 'apple'
require_relative '../screens/hud'
require_relative '../screens/game_over'

# Class to define Base Logic for the game.
class GameLogic
  attr_accessor :snake, :apples, :hud, :game_over, :tick

  def initialize(snake:)
    @tick = 0
    @snake = snake
    snake.set_tick(tick: tick)
    @apples = []
    @hud = Hud.new(snake: snake)
    @game_over = false
  end

  def create_apples
    return unless (tick % 720).zero?

    apples << Apple.new
    return unless tick >= 10_000

    rand(1..2).times do
      apples << Apple.new
    end
  end

  def increase_snake_speed
    case tick
    when 2_000
      snake.speed += 2
    when 8_000
      snake.speed += 2
    when 20_000
      snake.speed += 2
    when 40_000
      snake.speed += 2
    end
  end

  def update_hud
    hud.update(tick: tick)
  end

  def show_game_over
    show_game_over_screen
    play_game_over_sound_effect
  end

  def snake_collition?
    snake.wall_collition? || snake.self_collition?
  end

  def check_snake_and_apple_collition
    collided_apple = apples.select { |apple| snake.apple_collition?(apple: apple) }.first

    return unless collided_apple

    snake.eat_apple
    play_eat_sound_effect
    remove_colided_apple(collided_apple: collided_apple)
  end

  def game_over?
    game_over
  end

  def increase_tick
    @tick += 1
    snake.set_tick(tick: @tick)
  end

  private

  def show_game_over_screen
    GameOver.new
    @game_over = true
  end

  def play_game_over_sound_effect
    game_over_sound = Sound.new(Settings::GAME_OVER_SOUND_EFFECT)
    game_over_sound.play
  end

  def play_eat_sound_effect
    eat_apple_sound = Sound.new(Settings::EAT_APPLE_SOUND_EFFECT)
    eat_apple_sound.play
  end

  def remove_colided_apple(collided_apple:)
    collided_apple.shape.remove
    apples.delete(collided_apple)
  end
end
