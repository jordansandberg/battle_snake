# frozen_string_literal: true

require 'gastar'

# Implement the abstract node class.
# Note: All attributes below are custom for this implementation and none are
# needed nor used by the actual AStar seach algorithm. They're my domain atts.
module Graph
  class BoardNode < AStarNode
    attr_reader :type, :x, :y

    COSTS = {
      food: 0,
      board: 10,
      start: 2
    }.freeze

    def initialize(type, x, y)
      super()
      @type = type
      @x = x
      @y = y
    end

    def move_cost(_other)
      COSTS[@type]
    end

    def to_s
      "#{@x} #{@y}"
    end

    def neighbour?(other)
      x_neighbour = (x == other.x - 1 || x == other.x + 1) && y == other.y
      y_neighbour = (y == other.y - 1 || y == other.y + 1) && x == other.x
      x_neighbour || y_neighbour
    end
  end
end
