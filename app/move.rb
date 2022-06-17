# frozen_string_literal: true

require_relative 'graph/board'

# This function is called on every turn of a game. It's how your Battlesnake decides where to move.
# Valid moves are "up", "down", "left", or "right".

def move(game)
  board_and_me = game[:board].merge({ you: game[:you] })
  graph = Graph::Board.new(board_and_me)
  paths = graph.search

  # food_unreachable unless path.presence
  move = if paths.present?
           pp 'Shortest Path'
           get_move(game[:you][:head], paths[1])
         else
           pp 'Stay Alive'
           stay_alive(board_and_me)
         end

  pp move

  # Choose a random direction to move in

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

def stay_alive(_board_and_me)
  possible_moves = %w[up down left right]
  possible_moves.sample
end
