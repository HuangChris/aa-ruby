require_relative 'display'
require 'byebug'
require_relative 'cursorable'

class Player
  include Cursorable

  attr_accessor :display
  attr_reader :color

  def initialize(name, board, color)
    @cursor_pos = [0, 0]
    @name, @board, @display, @color = name, board, Display.new(board), color
  end

  def render_board(pos, error = nil)
    @display.render(@cursor_pos, pos, self, error)
  end

end

class ComputerPlayer < Player
  def initialize(name, board, color)
    super(name, board, color)
    @cursor_pos = nil
  end

  def get_input(start_pos)
    #  sleep(0.15)
    # _ = gets.chomp
    if start_pos.nil? #first part of move (return start_pos)
      computers_move_list = Hash.new

      @board.get_pieces(color).each do |pos, obj|
        obj.moves(pos,true).each do |move|
          computers_move_list[pos] = move
        end
      end
      return winning_move(computers_move_list)[0] if winning_move(computers_move_list)
      computers_move_list.keys.sample


    else #return move_to position
      # debugger
      computers_move_list = @board[start_pos].moves(start_pos,true)
      winning_pos = winning_last_move(computers_move_list, start_pos)
      return winning_pos if winning_pos
      computers_move_list.sample
    end
  end

  def winning_move(computers_move_list)
    opposite = (color == :black ? :white : :black)
    computers_move_list.each do |start_pos, end_pos|
      test_board = @board.dup
      test_board.move!(start_pos, end_pos)
      return [start_pos,end_pos] if test_board.check_mate?(opposite)
      test_board = nil
    end
    nil
  end

  def winning_last_move(movelist, start_pos)
    #this is different because it takes an array of end positions, rather than a hash of both.
    opposite = (color == :black ? :white : :black)
    movelist.each do |end_pos|
      test_board = @board.dup
      test_board.move!(start_pos, end_pos)
      return end_pos if test_board.check_mate?(opposite)
      test_board = nil
    end
    nil
  end
end
