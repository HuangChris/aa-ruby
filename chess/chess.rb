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
    players.first.render_board(nil)
    until board.game_over?
      begin
      start_pos, end_pos = get_turn
      board.move_piece(start_pos, end_pos, players.first)
      players.first.render_board(nil)
      players.rotate!
      rescue WrongColor => error
        players.first.render_board(nil,error)
        retry
      rescue InvalidMove => error
        players.first.render_board(nil,error)
        retry
      rescue InCheck => error
        players.first.render_board(nil,error)
        retry
      end
    end
  end

  def get_turn
    start_pos = nil
    end_pos = nil
    while start_pos.nil?
      start_pos = players.first.display.get_input
      players.first.render_board(start_pos)
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
