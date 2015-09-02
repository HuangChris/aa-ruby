require 'rspec'
require 'deck'

describe Deck do

  it "initializes without errors" do
    expect {Deck.new}.not_to raise_error
  end

  it "deals random hands" do
    hand = Array.new(2) {Array.new}
    2.times do |i|
      deck = Deck.new
      5.times do
        hand[i]<< deck.deal_card
      end
    end
    expect(hand[0]).to_not eq(hand[1])
  end

  it "shuffles and resets to the start of the deck" do
      deck = Deck.new
      52.times do
        deck.deal_card
      end
      deck.shuffle
      expect(deck.deal_card).to be_a(Card)
  end

  it "doesn't deal cards twice" do
    #deal 52, look for duplicates
    deck = Deck.new
    hand = []
    52.times do
      hand << deck.deal_card
    end

    expect(hand).to eq(hand.uniq)
  end


end
