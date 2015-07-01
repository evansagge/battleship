module Battleship
  class Game
    attr_reader :players, :current_player, :winning_player

    def initialize(board_size, player_count)
      @players = []
      player_count.times do
        @players << Board.new(board_size)
      end
      @current_player = 0
    end

    def shoot(player, target_player, x, y)
      raise OutOfTurn if player != current_player

      target = players[target_player]

      return false unless target.has_ship?(x, y)

      @current_player = (@current_player = player.size - 1) ? 0 : @current_player + 1

      target.hit!(x, y)

      throw :target_destroyed if target.destroyed?

      true
    end
  end
end
