require 'card'
require 'rspec'
require 'colorize'

describe Card do
  subject(:cards) { [Card.new(4, :spades), Card.new(13, :hearts)] }

  it "takes a number and a suit" do
    expect(cards[0].number).to eq(4)
    expect(cards[1].suit).to eq(:hearts)
  end

  it 'to_s returns proper string value' do
    expect(cards[0].to_s).to eq("4♤".white)
    expect(cards[1].to_s).to eq("K♥".red)
  end


end
