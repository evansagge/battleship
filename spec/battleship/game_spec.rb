require 'spec_helper'

describe Battleship::Game do
  let(:board) { Battleship::Board.new(10) }
  let(:ships) do
    [
      Battleship::Ship.new(3),
      Battleship::Ship.new(2),
      Battleship::Ship.new(4),
      Battleship::Ship.new(5)
    ]
  end

  describe '.new' do
    subject { described_class.new(10, 2) }

    it 'sets #players to the number of players specified' do
      expect(subject.players.count).to eq(2)
    end

    it 'sets the board for each player to the specified board size' do
      subject.players.each do |board|
        expect(board.size).to eq(10)
      end
    end
  end

  describe '#shoot' do
    let(:game) { described_class.new(10, 2) }
    let(:ship_1) { Battleship::Ship.new(5) }
    let(:ship_2) { Battleship::Ship.new(3) }

    before do
      game.players[0].add_ship(ship_1, 2, 2)
      game.players[1].add_ship(ship_2, 6, 6)
    end

    context 'on a successful move' do
      subject { game.shoot(0, 1, 6, 6) }

      it 'returns true' do
        expect(subject).to eq(true)
      end

      it 'removes the ship from that position (removes a hitpoint from the player)' do
        expect { subject }.to change { game.players[1].positions[6, 6] }.from(ship_2).to(nil)
      end

      context 'if target player has no more ships with hitpoints' do
        specify do
          expect(game.shoot(0, 1, 5, 6)).to eq(true)
          expect(game.shoot(0, 1, 7, 6)).to eq(true)
          expect { game.shoot(0, 1, 6, 6) }.to throw_symbol(:target_destroyed)
        end
      end
    end

    context 'if it is not the player\'s turn' do
      specify do
        expect { game.shoot(1, 0, 3, 3) }.to raise_error(Battleship::OutOfTurn)
      end
    end

    context 'if position is unoccupied' do
      specify do
        expect(game.shoot(0, 1, 9, 9)).to eq(false)
      end
    end

  end
end
