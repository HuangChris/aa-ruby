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
    # debugger
    players.first.render_board(nil)
    until board.game_over?(players.first.color)

      # TODO everytime we rotate, set a color variable to pass
      begin
      start_pos, end_pos = get_turn
      board.move_piece(start_pos, end_pos, players.first.color)
      players.rotate!
      players.first.render_board(nil)
      rescue WrongColor, InvalidMove, InCheck => error
        players.first.render_board(nil,error)
        retry
      end
    end

    game_over_message

  end

  def game_over_message
    puts "Game over!"
    puts "#{players.last.color.capitalize} wins!" if board.checkmate?

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
