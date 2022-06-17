# frozen_string_literal: true

require_relative 'graph/board'

# This function is called on every turn of a game. It's how your Battlesnake decides where to move.
# Valid moves are "up", "down", "left", or "right".

def move(game)
  board_and_me = game[:board].merge({ you: game[:you] })
  board = Graph::Board.new(board_and_me)
  paths = board.search

  # # food_unreachable unless path.presence
  move = paths.present? ? get_move(game[:you][:head], paths[1]) : stay_alive(board, game)

  puts "MOVE: #{move}"

  { move: move }
end

def get_move(me, path)
  x = me[:x] - path.x
  y = me[:y] - path.y
  if y.positive?
    'down'
  elsif x.positive?
    'left'
  elsif y.negative?
    'up'
  else
    'right'
  end
end

def stay_alive(board, game)
  pp 'STAY ALIVE'
  paths = board.search(decide_best_node(board, game))
  get_move(game[:you][:head], paths[1])
end
