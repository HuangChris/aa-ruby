require_relative 'hand'

class Player
  attr_reader :name, :folded, :pot

  def initialize(name, pot = 100)
    @name = name
    @hand = Hand.new
    @folded = false
    @pot = pot
  end

  def get_cards(cards)
    cards.each {|card| @hand.receive_card(card)}
  end

  def get_play
    #get input from player, to see,fold, or raise
  end

  def trade_cards
    #get input from player to drop up to 3 cards (hold array of indices)
    #call hand.give_card(index) with each.
    #return number of cards dropped.
  end

  def win_pot(winnings)
    @pot += winnings
  end

  def value
    return 0 if @folded
    @hand.value
  end
end
