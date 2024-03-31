# frozen_string_literal: true

# Class set default settings values.

class Settings
  # Snake settings
  SNAKE_DEFAULT_DIRECTION = 'up'
  SNAKE_DEFAULT_SPEED = 15
  SNAKE_DEFAULT_HEAD_COLOR = 'blue'
  SNAKE_DEFAULT_BODY_COLOR = 'blue'

  # Apple settings
  APPLE_DEFAULT_COLOR = 'red'

  # Game Over screen settings
  GAME_OVER_DEFAULT_TEXT_COLOR = 'purple'

  # HUD screen settings
  HUD_DEFAULT_TEXT_COLOR = 'green'

  # Game sound effects settings
  EAT_APPLE_SOUND_EFFECT = 'assets/audios/eat_apple.wav'
  GAME_OVER_SOUND_EFFECT = 'assets/audios/game_over.wav'
end
