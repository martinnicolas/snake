# frozen_string_literal: true

require_relative '../settings'

# Class to define and implement Snake logic on game.
class Snake
  attr_accessor :speed, :head, :body, :direction, :tick
  attr_reader :previous_tick

  LEFT = 'left'
  RIGHT = 'right'
  UP = 'up'
  DOWN = 'down'

  def initialize(direction: Settings::SNAKE_DEFAULT_DIRECTION, speed: Settings::SNAKE_DEFAULT_SPEED)
    @direction = direction
    @speed = speed
    @head = Square.new(x: 200, y: 200, size: 10, color: Settings::SNAKE_DEFAULT_HEAD_COLOR, z: 10)
    @body = []
  end

  def allowed_direction(key)
    @direction = key if allowed_direction?(key)
  end

  def move
    @previous_tick ||= tick unless tick.zero?

    elapsed_time = tick.to_i - previous_tick.to_i
    desired_interval = 10.0 / speed
    return if elapsed_time < desired_interval

    case direction
    when LEFT
      move_left
    when RIGHT
      move_right
    when UP
      move_up
    when DOWN
      move_down
    end

    @previous_tick = tick
  end

  def eat_apple
    increase_body
  end

  def self_collition?
    collition = false

    body.each_with_index do |element, index|
      next if index.zero? || index == 1 || index == 2

      if element.contains?(head.x, head.y)
        collition = true
        break
      end
    end

    collition
  end

  def wall_collition?
    collition = false

    collition = true unless (0..630).include? head.x
    collition = true unless (0..470).include? head.y

    collition
  end

  def apple_collition?(apple:)
    apple.shape.contains?(head.x, head.y) ||
      apple.shape.contains?(head.x + head.size, head.y) ||
      apple.shape.contains?(head.x, head.y + head.size) ||
      apple.shape.contains?(head.x + head.size, head.y + head.size)
  end

  def set_tick(tick:)
    @tick = tick
  end

  private

  def allowed_direction?(key)
    !unallowed_direction?(key)
  end

  def unallowed_direction?(key)
    (key == UP && direction == DOWN) ||
      (key == DOWN && direction == UP) ||
      (key == LEFT && direction == RIGHT) ||
      (key == RIGHT && direction == LEFT)
  end

  def increase_body
    body.unshift(Square.new(x: head.x, y: head.y, size: 10, color: Settings::SNAKE_DEFAULT_BODY_COLOR, z: 10))
  end

  def move_left
    prev_head_location_x = head.x
    prev_head_location_y = head.y
    head.x -= 10
    update_body(prev_head_location_x, prev_head_location_y) if body.any?
  end

  def move_right
    prev_head_location_x = head.x
    prev_head_location_y = head.y
    head.x += 10
    update_body(prev_head_location_x, prev_head_location_y) if body.any?
  end

  def move_up
    prev_head_location_x = head.x
    prev_head_location_y = head.y
    head.y -= 10
    update_body(prev_head_location_x, prev_head_location_y) if body.any?
  end

  def move_down
    prev_head_location_x = head.x
    prev_head_location_y = head.y
    head.y += 10
    update_body(prev_head_location_x, prev_head_location_y) if body.any?
  end

  def update_body(prev_head_location_x, prev_head_location_y)
    body.unshift(
      Square.new(
        x: prev_head_location_x,
        y: prev_head_location_y,
        size: 10,
        color: Settings::SNAKE_DEFAULT_BODY_COLOR,
        z: 10
      )
    )
    body.last.remove
    body.pop
  end
end
