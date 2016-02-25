require "cabral"
require "cabral/step"
require "cabral/point"

module Cabral
  class Map
    # Arguments:
    # @array: 2 dimension array, x,y, 0 indicates wall, >= n indicates cost of movement
    # @origin: [x,y] where the actor starts
    # @object: [x,y] where the actor should get into
    def initialize(array, origin, objective)
      @map       = array
      @origin    = Cabral::Point.new(*origin)
      @objective = Cabral::Point.new(*objective)
    end

    def resolve
      opened_list = []
      closed_list = []

      opened_list << Step.new(@map, @origin, @objective)

      while opened_list.any? do
        # Grab lowest cost node
        opened_list.sort_by!(&:f)
        closed_list << opened_list.shift

        # we found a path!
        break if closed_list.find { |step| step == @objective }

        walkable = find_walkable(closed_list.last)
        walkable.each do |path|
          # If on closed list we just need to skip it
          next if closed_list.include?(path)

          index = opened_list.index(path)

          # TODO: Consider keeping track of steps as
          # might scores might be the same but with less
          # steps

          # If it is already on the opened list and lower "f" score we replace it
          # Else just add to the open list
          if index && path.f < opened_list[index].f
            opened_list[index] = path
          elsif !index
            opened_list << path
          end
        end
      end

      step = closed_list.find { |step| step == @objective }
      return nil unless step

      solution_path(step)
        .reverse
        .map { |step| [step.x, step.y] }
    end

    private

    def find_walkable(start)
      [].tap do |walkable|
        walkable << start.north if can_go_north?(start)
        walkable << start.east  if can_go_east?(start)
        walkable << start.south if can_go_south?(start)
        walkable << start.west  if can_go_west?(start)
      end
    end

    def solution_path(step, output = [])
      return output.push(step) unless step.parent
      solution_path(step.parent, output.push(step))
    end

    def can_go_north?(position)
      (position.y - 1) >= 0 && @map[position.y - 1][position.x]
    end

    def can_go_east?(position)
      (position.x + 1) < @map[0].length && @map[position.y][position.x + 1]
    end

    def can_go_south?(position)
      (position.y + 1) < @map.length && @map[position.y + 1][position.x]
    end

    def can_go_west?(position)
      (position.x - 1) >= 0 && @map[position.y][position.x - 1]
    end
  end
end
