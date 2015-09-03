require 'rspec'
require 'hand'

describe Hand do
  subject(:s_flush) do
     hand = Hand.new
     hand.receive_card(Card.new(11, :clubs))
     hand.receive_card(Card.new(10, :clubs))
     hand.receive_card(Card.new(9, :clubs))
     hand.receive_card(Card.new(8, :clubs))
     hand.receive_card(Card.new(7, :clubs))
     hand
   end

   subject(:four) do
      hand = Hand.new
      hand.receive_card(Card.new(6, :clubs))
      hand.receive_card(Card.new(6, :clubs))
      hand.receive_card(Card.new(6, :clubs))
      hand.receive_card(Card.new(6, :clubs))
      hand.receive_card(Card.new(11, :clubs))
      hand
    end

    subject(:full_house) do
       hand = Hand.new
       hand.receive_card(Card.new(5, :clubs))
       hand.receive_card(Card.new(5, :clubs))
       hand.receive_card(Card.new(5, :clubs))
       hand.receive_card(Card.new(13, :clubs))
       hand.receive_card(Card.new(13, :clubs))
       hand
     end

     subject(:two_pair) do
        hand = Hand.new
        hand.receive_card(Card.new(11, :clubs))
        hand.receive_card(Card.new(11, :clubs))
        hand.receive_card(Card.new(9, :clubs))
        hand.receive_card(Card.new(9, :clubs))
        hand.receive_card(Card.new(7, :clubs))
        hand
      end

      subject(:high_card) do
         hand = Hand.new
         hand.receive_card(Card.new(14, :diamonds))
         hand.receive_card(Card.new(10, :spades))
         hand.receive_card(Card.new(9, :hearts))
         hand.receive_card(Card.new(4, :diamonds))
         hand.receive_card(Card.new(3, :clubs))
         hand
       end

  # describe '#to_s' do
  #   it "checks every card" do
  #
  #   end
  #
  #   it "prints a hand" do
  #
  #   end
  # end

  describe '#find_same_value' do
    it "finds the largest number of matches" do
      expect(full_house.find_same_value).to eq([3,5])
      expect(two_pair.find_same_value.length).to eq(4)
      #give it a full house to test
    end

    # it "returns the value of the match set" do
    #   expect(full_house.find_same_value[1]).to eq([3,5])
    # end

    it "returns 1 for no matches" do
      expect(high_card.find_same_value[0]).to eq(1)
    end
  end

  describe '#straight?' do
    it "finds a straight" do
      expect(s_flush).to be_straight
    end

    it "doesn't find a non-straight" do
      expect(high_card).to_not be_straight
    end
  end

  describe '#flush?' do
    it "finds a flush" do
      expect(s_flush).to be_flush
    end

    it "doesn't find a non-flush" do
      expect(high_card).to_not be_flush
    end
  end

  describe '#get_high_value' do
    it "gets the highest card" do
      expect(four.get_high_value(four.find_same_value)).to eq(11)
    end

    it "does not get the high card from a set" do
      expect(two_pair.get_high_value(two_pair.find_same_value)).to eq(7)
    end

  end

  describe '#lower_set_value' do
    it "gets the value of the second pair" do

    end
  end

end
