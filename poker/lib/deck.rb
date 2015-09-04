require_relative 'card'

class Deck
  def initialize
    @next_card = 0
    @cards = []
    create_cards
  end

  def deal_card
    raise "end of deck" if empty?
    @next_card += 1
    @cards[@next_card - 1]
    #return top card from deck, @next_card += 1
  end

  def shuffle
    @cards.shuffle
    @next_card = 0
    #shuffle deck, reset @next_card = 0
  end

  def empty?
    @next_card == 52
  end

  private
  def create_cards
    #create each card, shuffle, return an array of cards
    [:spades, :clubs, :hearts, :diamonds].each do |suit|
      13.times { |num| @cards << Card.new(num + 2, suit) }
    end
    @cards.shuffle
  end
end
