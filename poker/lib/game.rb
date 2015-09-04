require_relative 'deck'
require_relative 'player'

class PokerGame
  def initialize
    @deck = Deck.new
    # @players = get_players
    @players = Array.new(4) {Player.new("name")}
    @current_pot = 0
  end

  def play
    while true
      show_current_standings
      play_round
    end
  end

  def play_round
    deal_deck
    get_bets
    get_card_trades
    get_bets
    reveal_hands
    determine_winner
  end

  private
  def get_players
    #asks for a number of players and names, return an array with Player.new
  end

  def show_current_standings
    #display each player's pot
    @players.each do |player|
      puts "#{player.name}: $#{player.pot}"
    end

  end

  def deal_deck
    5.times do
      @players.each do |player|
        player.get_cards([@deck.deal_card])
      end
    end
  end

  def get_bets
    # @players.each do |player|
    #   case player.get_play
    #   when :see
    #     @pot += 5
    #

    end
  end

  def get_card_trades
    #call player#trade_cards
    #deal player the correct number of new cards.
  end

  def determine_winner
    #gets player.value, returns the highest.  Gives that player the pot.
  end

  def reveal_hands
    #gets hand.to_s from each player that hasn't folded
  end

end
