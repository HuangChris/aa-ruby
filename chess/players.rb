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
    sleep(0.25)
    if start_pos.nil? #first part of move (return start_pos)
      computers_move_list = Hash.new

      @board.get_pieces(color).each do |pos, obj|
        obj.moves(pos,true).each do |move|
          computers_move_list[pos] = move
        end
      end
      test_move = computers_move_list.keys.sample


    else #return move_to position
      computer_move_list = @board[start_pos].moves(start_pos,true)
      # computer_move_list.select! {|move| @board.valid_move?(start_pos, move, color)}
      test_to_move = computer_move_list.sample
    end
  end
end
