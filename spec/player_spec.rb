require 'rspec'
require 'player'

describe Player do

  subject(:player) { Player.new("NAME") }

  it "initializes variables" do
    expect(player.name).to eq("NAME")
    expect(player.folded).to be false
    expect(player.pot).to eq(100)
  end

  it "gets cards" do
    double(:hand) { "hand", receive_card: nil }

  end
end
