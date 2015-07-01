require 'spec_helper'

describe Battleship::Ship do
  let(:ship) { described_class.new(5) }

  it 'has #hit_points' do
    expect(ship.hit_points).to eq(5)
  end
end
