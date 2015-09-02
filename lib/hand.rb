class Hand
  def initialize
    @cards = []
  end

  def to_s
    @cards.map(&:to_s).join("")
  end

  def receive_card(card)
    #add card to @cards if it's not full
  end

  def drop_card(card_index)
    #remove cards from @cards
  end

  def value
    #return a value based on hand type and high card
    #use private methods to get hand type and high card
  end

end
