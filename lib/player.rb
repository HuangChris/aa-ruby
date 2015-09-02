require_relative 'hand'

class Player
  attr_reader :name, :folded, :pot

  def initialize(name, pot = 100, hand = Hand.new)
    @name = name
    @hand = hand
    @folded = false
    @pot = pot
  end

  def get_cards(cards)
    cards.each {|card| @hand.receive_card(card)}
  end

  def get_play
    print "See, fold, or raise? "
    move = gets.chomp.downcase.split("")[0].to_sym
    case move
    when :f
      :fold
    when :s
      :see
    when :r
      print "How much? "
      raise_value = gets.chomp.to_i
      [:raise, raise_value]
    end
  end

  def trade_cards
    #get input from player to drop up to 3 cards (hold array of indices)
    #call hand.give_card(index) with each.
    #return number of cards dropped.
    print "Which cards would you like to drop? (0 - 4)"
    cards = gets.chomp.split(",").map(&:to_i)
    cards.each { |card| @hand.drop_card(card) }

    cards.length
  end

  def update_pot(num)
    @pot += num
  end

  def value
    return 0 if @folded
    @hand.value
  end

  def fold
    @folded = true
  end

end
