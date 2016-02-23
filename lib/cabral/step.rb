require "cabral"
require "cabral/manhattan_distance"

module Cabral
  class Step
    # @map: 2 dimensional array
    # @point: current cartesian point
    # @objective: objective cartesian point
    # @g: movement cost
    attr_reader :map, :x, :y

    def initialize(map, point, objective, g = 0)
      @map       = map
      @point     = point
      @objective = objective
      @g         = g + map[point.y][point.x]
    end

    def x
      @point.x
    end

    def y
      @point.y
    end

    def north
      self.class.new(map, @point.north, @objective, g)
    end

    def east
      self.class.new(map, @point.east, @objective, g)
    end

    def south
      self.class.new(map, @point.south, @objective, g)
    end

    def west
      self.class.new(map, @point.west, @objective, g)
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
