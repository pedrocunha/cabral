require "cabral"

module Cabral
  class ManhattanDistance
    # @origin: object that responds to x,y
    # @target: object that responds to x,y
    def initialize(origin, target)
      @origin = origin
      @target = target
    end

    def calculate
      (@origin.x - @target.x).abs + (@origin.y - @target.y).abs
    end
  end
end
