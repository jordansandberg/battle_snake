# frozen_string_literal: true

require 'active_support/all'

# Turns a hash from { hi_there: true } to { "hiThere": true } to match engine
# syntax.
def camelcase(hash)
  hash.deep_transform_keys { |key| key.to_s.camelize(:lower) }
end

# Turns a hash from { "hiThere": true } to { hi_there: true } to match ruby
# like syntax.
def underscore(hash)
  hash.deep_transform_keys { |key| key.to_s.underscore.to_sym }
end

def do_a_circle(graph, me)
  tail = me[:body].last
  graph.keys.min_by { |f| Math.sqrt(((f.x - tail[:x])**2) + ((f.y - tail[:y])**2)) }
end

def last_resort(graph, start)
  graph[start].sample
end

def decide_best_node(board, game)
  node = do_a_circle(board.graph, game[:you])
  node.nil? ? last_resort(board.graph, board.start) : node
end
