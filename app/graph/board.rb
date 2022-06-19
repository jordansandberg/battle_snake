# frozen_string_literal: true

require 'gastar'
require_relative 'board_node'

module Graph
  class Board < AStar
    attr_reader :graph, :start

    def initialize(board_arr, me)
      graph = build_graph(board_arr)
      @start = graph.keys.select { |node| node.x == me[:head][:x] && node.y == me[:head][:y] }.first

      @end = find_closest_food(@start, graph) || graph[@start].sample
      super(graph)
    end

    def search
      super(@start, @end)
    end

    def heuristic(_node, _start, _goal)
      distance(@start, @end)
    end

    private

    def build_graph(board_arr)
      board_nodes = board_arr.each_with_index.map do |column_arr, x|
        column_arr.each_with_index.map do |tile, y|
          next if tile.nil?

          BoardNode.new(tile, x, y)
        end
      end.flatten.compact

      board_nodes.to_h do |node|
        [node, board_nodes.select { |x| x.neighbour?(node) }]
      end
    end

    def distance(p1, p2)
      Math.sqrt(((p1.x - p2.x)**2) + ((p1.y - p2.y)**2))
    end

    def find_closest_food(start, graph)
      food = graph.keys.select { |node| node.type == :food }
      food.min_by { |f| distance(start, f) }
    end
  end
end
