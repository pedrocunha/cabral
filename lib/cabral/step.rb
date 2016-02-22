require "cabral"

module Cabral
  class Step
    # @map: 2 dimensional array
    # @x: x cartesian position
    # @y: y cartesian position
    # @g: movement cost
    attr_reader :map, :x, :y, :g

    def initialize(map, x, y, g = 0)
      @map = map
      @x   = x
      @y   = y
      @g   = g + map[y][x]
    end

    def north
      self.class.new(map, x, y - 1, g)
    end

    def east
      self.class.new(map, x + 1, y, g)
    end

    def south
      self.class.new(map, x, y + 1, g)
    end

    def west
      self.class.new(map, x - 1, y, g)
    end

    def dup
      self.class.new(map, x, y, g)
    end
  end
end
