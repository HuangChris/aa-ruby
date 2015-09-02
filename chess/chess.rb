require_relative 'board'
require_relative 'players'

class Chess
  attr_reader :board, :display
  attr_accessor :players

  def initialize
    mode = get_game_mode
    @board   = Board.new
    #this should be split out, probably.
    case mode
    when 1
      @players = [Player.new("1", @board, :white), Player.new("2", @board, :black)]
    when 2
      @players = [ComputerPlayer.new("1", @board, :white), Player.new("2", @board, :black)]
    when 3
      @players = [Player.new("1", @board, :white), ComputerPlayer.new("2", @board, :black)]
    when 4
      @players = [ComputerPlayer.new("1", @board, :white), ComputerPlayer.new("2", @board, :black)]
    end
  end

  def get_game_mode
    puts "Welcome to chess.  Select an option:"
    puts "1: Human v Human"
    puts "2: Computer(white) v Human(black)"
    puts "3: Human(white) v Computer(black)"
    puts "4: Computer v Computer"
    gets.chomp.to_i
  end

  def play
    color = players.first.color
    players.first.render_board(nil)

    until board.game_over?(color)
      begin
      start_pos, end_pos = get_turn
      board.move_piece(start_pos, end_pos, color)
      players.rotate!
      color = players.first.color

      players.first.render_board(nil)
      rescue WrongColor, InvalidMove, InCheck, MissingKing => error
        players.first.render_board(nil,error)
        retry
      end
    end

    game_over_message
  end

  def game_over_message
    puts "Game over!"
    puts "#{players.last.color.capitalize} wins!" if board.check_mate?(:white) || board.check_mate?(:black)

  end

  def get_turn
    start_pos = nil
    end_pos = nil
    while start_pos.nil?
      start_pos = players.first.get_input(start_pos)
      players.first.render_board(start_pos)
    end
    while end_pos.nil?
      players.first.render_board(start_pos)
      end_pos = players.first.get_input(start_pos)
    end
    return start_pos, end_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  Chess.new.play
end
