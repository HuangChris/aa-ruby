require 'colorize'

class Card
  FACE_CARDS = ["J", "Q", "K", "A"]

  attr_reader :number, :suit

  def initialize(number, suit)
    @number = number
    @suit = suit
  end

  def to_s
    if suit == :spades || suit == :clubs
      color = :white
      symbol = (suit == :spades ? "♤" : "♧")
    else
      color = :red
      symbol = (suit == :hearts ? "♥" : "♦")
    end

    if number < 11
      value = number.to_s
    else
      value = FACE_CARDS[number - 11]
    end

    (value + symbol).colorize(color)
  end

end
