require 'rspec'
require 'player'

describe Player do

  subject(:player) { Player.new("NAME", 100, hand) }
  let(:hand) { double("hand", receive_card: nil, value: "hand_value") }

  it "initializes variables" do
    expect(player.name).to eq("NAME")
    expect(player.folded).to be false
    expect(player.pot).to eq(100)
  end

  describe '#get_cards' do
    it "passes one card to hand" do
      expect(hand).to receive(:receive_card).with(1)
      player.get_cards([1])
    end

    it "passes multiple cards to hand" do
      expect(hand).to receive(:receive_card).exactly(3).times
      player.get_cards([1, 2, 3])
    end
  end

  it "#update_pot adds to player's current pot" do
    player.update_pot(1)
    expect(player.pot).to eq(101)

    player.update_pot(-1)
    expect(player.pot).to eq(100)
  end

  describe '#value' do
    it "displays the player's hand value if not folded" do
      expect(hand).to receive(:value)
      player.value
      expect(player.value).to eq("hand_value")
    end

    it 'returns zero if folded' do
      player.fold
      expect(player.value).to eq(0)
    end
  end
end
