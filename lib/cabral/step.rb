require "cabral"
require "cabral/manhattan_distance"

module Cabral
  class Step
    # @map: 2 dimensional array
    # @point: current cartesian point
    # @objective: objective cartesian point
    # @g: movement cost
    # @parent: step before
    attr_reader :map, :x, :y, :parent

    def initialize(map, point, objective, g = 0, parent = nil)
      @map       = map
      @point     = point
      @objective = objective
      @g         = g + map[point.y][point.x]
      @parent    = parent
    end

    def x
      @point.x
    end

    def y
      @point.y
    end

    def north
      self.class.new(map, @point.north, @objective, g, self)
    end

    def east
      self.class.new(map, @point.east, @objective, g, self)
    end

    def south
      self.class.new(map, @point.south, @objective, g, self)
    end

    def west
      self.class.new(map, @point.west, @objective, g, self)
    end

    def ==(step)
      x == step.x && y == step.y
    end

    # Cost movement methods

    def g
      @g
    end

    def h
      @h ||= Cabral::ManhattanDistance.new(@point, @objective).calculate
    end

    def f
      @f ||= g + h
    end
  end
end
