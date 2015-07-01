require 'matrix'

module Battleship
  class Board
    attr_reader :size, :positions

    def initialize(size)
      @size = size
      @positions = Matrix.build(size, size) { nil }
    end

    def add_ship(ship, x, y, horizontal = true)
      Add.new(self, ship).execute(x, y, horizontal)
    end

    def has_ship?(x, y)
      !positions[x, y].nil?
    end

    def hit!(x, y)
      positions.send(:[]=, x, y, :hit)
    end

    def destroyed?
      positions.each do |position|
        return false if !position.nil?
      end

      return true
    end
  end
end
