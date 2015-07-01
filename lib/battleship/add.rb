module Battleship
  class Add
    attr_reader :board, :ship

    def initialize(board, ship)
      @board = board
      @ship = ship
    end

    def execute(x, y, horizontal = true)
      if horizontal
        start_x = x - (ship.hit_points / 2)
        end_x = x + (ship.hit_points / 2)

        (start_x..end_x).each do |n|
          validate(n, y)
        end

        (start_x..end_x).to_a.each do |n|
          board.positions.send(:[]=, n, y, ship)
        end
      else
        start_y = y - (ship.hit_points / 2)
        end_y = y + (ship.hit_points / 2)

        (start_y..end_y).each do |n|
          validate(x, n)
        end

        (start_y..end_y).to_a.each do |n|
          board.positions.send(:[]=, x, n, ship)
        end
      end
    end

    private

    def validate(x, y)
      raise InvalidPosition if x < 0 || y < 0 || x > board.size - 1 || y > board.size - 1

      raise OverlappingShip if board.has_ship?(x, y)
    end
  end
end
