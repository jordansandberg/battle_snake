# frozen_string_literal: true

require_relative 'graph/board'

# This function is called on every turn of a game. It's how your Battlesnake decides where to move.
# Valid moves are "up", "down", "left", or "right".

def move(game)
  board_arr = build_board(game[:board], game[:you])

  board = Graph::Board.new(board_arr, game[:you])

  paths = board.search

  my_xy = game[:you][:head]
  head_node = board.start

  # # food_unreachable unless path.presence

  move = paths.present? ? get_move(my_xy, paths[1]) : get_move(my_xy, board.graph[head_node].sample)

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

def build_board(board, me)
  snakes = board[:snakes].map { |snakes| snakes[:body] }.flatten
  food = board[:food]

  board_arr = Array.new(board[:height]) do |x|
    Array.new(board[:width]) do |y|
      x_y = { x: x, y: y }
      next if snakes.include?(x_y)

      food.include?(x_y) ? :food : :board
    end
  end
  board_arr[me[:head][:x]][me[:head][:y]] = :start

  board_arr
end
