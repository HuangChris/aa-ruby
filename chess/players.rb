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
  def get_input(start_pos)
    #  sleep(0.13)
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
      computers_move_list = @board[start_pos].moves(start_pos,true)
      return winning_move(computers_move_list)[1] if winning_move(computers_move_list)
      computers_move_list.sample
    end
  end

  def winning_move(computers_move_list)
    opposite = (color == :black ? :white : :black)
    computers_move_list.each do |start_pos, end_pos|
      test_board = @board.dup
      test_board.move!(start_pos, end_pos)
      return [start_pos,end_pos] if test_board.check_mate?(opposite)
    end
    nil
  end
end
