require "cabral"

module Cabral
  class Point
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def north
      self.class.new(x, y - 1)
    end

    def east
      self.class.new(x + 1, y)
    end

    def south
      self.class.new(x, y + 1)
    end

    def west
      self.class.new(x - 1, y)
    end
  end
end
