class Hand
  def initialize
    @cards = []
  end

  def to_s
    @cards.map(&:to_s).join("")
  end

  def receive_card(card)
    raise "too many cards" if @cards.length > 4
    @cards << card
    #add card to @cards if it's not full
  end

  def drop_card(card_index)
    @cards.delete_at(card_index)
    #remove cards from @cards
  end

  def value
    same_value = find_same_value #return number of matches, and value
    straight = straight?
    flush = flush?
    high_value = get_high_value(same_value)

    if flush && straight
      value = 2500 + high_value
    elsif same_value[0] == 4
      value = 2480 + same_value[1]
    elsif flush
      value = 2440 + high_value

    elsif same_value[0] == 3
      if full_house?
        value = 2460 + same_value[1]
      else
        value = 2400 + high_value # about 2400
      end

    elsif same_value[0] == 2
      if two_pair? # [2, 13, 2, 5]
        same_value.sort!
        value = 169 * same_value.pop + 13 * same_value.pop + high_value
      else #one-pair
        value = 15 + 13 * same_value[1] + high_value
      end

    else
      value = same_value.max
    end
  end

  # private
  def find_same_value
    #return highest number of matching cards, and the value
    hash = Hash.new(0)
    @cards.each { |card| hash[card.number] += 1 }
    set_value = hash.values.max
    hash.select! {|_,value| value == set_value}
    hash.to_a.flatten.reverse
  end

  def straight?
    @cards.sort! { |x, y| x.number <=> y.number }
    @cards.drop(1).each_with_index do |card, idx|
      return false if card.number != @cards[idx].number + 1
    end

    true
  end

  def flush?
    @cards.all? do |card|
      card.suit == @cards[0].suit
    end
  end

  def get_high_value(same_value)
    #gets the highest value card outside of a set.
    values = @cards.map do |card|
      card.number unless same_value.include?(card.number)
    end

    values.reject(&:nil?).max
  end

  # def lower_set_value
  #   #for 2-pair, gets the value of the lower pair
  # end
end
