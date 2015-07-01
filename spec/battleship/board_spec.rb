require 'spec_helper'

describe Battleship::Board do
  describe '#new' do
    let(:size) { 5 }
    subject { described_class.new(size) }

    it 'sets #size to the given size' do
      expect(subject.size).to eq(size)
    end

    it 'creates a matrix for #positions' do
      expect(subject.positions.to_a.size).to eq(size)
      subject.positions.to_a.each do |row|
        expect(row.size).to eq(size)
      end
    end
  end

  let(:board) { described_class.new(10) }

  describe '#add_ship' do
    let(:ship) { Battleship::Ship.new(5) }

    context 'with horizontal set to true' do
      before { board.add_ship(ship, 2, 2) }

      it 'lets the ship occupy the positions around x, y' do
        expect(board.positions[0,2]).to eq(ship)
        expect(board.positions[1,2]).to eq(ship)
        expect(board.positions[2,2]).to eq(ship)
        expect(board.positions[3,2]).to eq(ship)
        expect(board.positions[4,2]).to eq(ship)
        expect(board.positions[5,2]).to be_nil
      end
    end

    context 'with horizontal set to false' do
      before { board.add_ship(ship, 2, 2, false) }

      it 'lets the ship occupy the positions around x, y' do
        expect(board.positions[2,0]).to eq(ship)
        expect(board.positions[2,1]).to eq(ship)
        expect(board.positions[2,2]).to eq(ship)
        expect(board.positions[2,3]).to eq(ship)
        expect(board.positions[2,4]).to eq(ship)
      end
    end

    context 'if position sets the ship or part of the ship outside the board' do
      subject { board.add_ship(ship, 10, 2) }

      specify do
        expect { subject }.to raise_error(Battleship::InvalidPosition)
      end
    end

    context 'if position is already occupied by another ship' do
      before { board.add_ship(Battleship::Ship.new(3), 2, 2) }

      subject { board.add_ship(ship, 2, 2) }

      specify do
        expect { subject }.to raise_error(Battleship::OverlappingShip)
      end
    end
  end
end
