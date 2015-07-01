module Battleship
  class Error < StandardError; end

  class InvalidPosition < Error; end

  class OverlappingShip < Error; end

  class OutOfTurn < Error; end
end
