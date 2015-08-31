require_relative 'board'
require_relative 'players'

class Chess
  attr_reader :board, :display
  attr_accessor :players

  def initialize
    @board   = Board.new
    @players = [Player.new("1", @board, :white), Player.new("2", @board, :black)]
  end

  def play

    until board.game_over?
      # begin
      players.first.render_board(nil)
      start_pos, end_pos = get_turn
      board.move_piece(start_pos, end_pos, players.first)
      players.rotate!
      # rescue WrongColor
      #   puts "that's not your piece"
      #   retry
      # rescue EmptySquare
      #   puts "select an actual piece"
      #   retry
      # rescue InvalidMove
      #   puts "you can't move there"
      #   retry
      # rescue InCheck
      #   puts "You can't make that move, as you would be in check"
      #   retry
      # end
    end
  end

  def get_turn
    start_pos = nil
    end_pos = nil
    while start_pos.nil?
      players.first.render_board(nil)
      start_pos = players.first.display.get_input
    end
    while end_pos.nil?
      players.first.render_board(start_pos)
      end_pos = players.first.display.get_input
    end
    return start_pos, end_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  Chess.new.play
end
