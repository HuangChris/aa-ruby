require_relative 'pieces'
require_relative 'display'


class Board

  attr_accessor :cursor_pos
  attr_reader :grid

  def initialize
    @grid = Array.new(8) {Array.new}
    populate
  end

  def populate
    #creates tiles for pieces, assigns them to grid
    8.times do |idx|
      6.times do |j|
        self[[j+1,idx]] = NullPiece.new("nil", "nil")
      end
      # self[[1,idx]] = Pawn.new(:black)
      # self[[6,idx]] = Pawn.new(:white)
    end

    2.times { |i| self[[7,7*i]] = Rook.new(:white) }
    2.times { |i| self[[0,7*i]] = Rook.new(:black) }

    2.times { |i| self[[7,5*i+1]] = Knight.new(:white) }
    2.times { |i| self[[0,5*i+1]] = Knight.new(:black) }

    2.times { |i| self[[7,3*i+2]] = Bishop.new(:white) }
    2.times { |i| self[[0,3*i+2]] = Bishop.new(:black) }

    self[[0,4]] = King.new(:black)
    self[[7,4]] = King.new(:white)
    self[[0,3]] = Queen.new(:black)
    self[[7,3]] = Queen.new(:white)

    grid.flatten.each do |piece|
      piece.board = self
    end
  end

  def move_piece(start_pos, end_pos, player)
    if valid_move?(start_pos,end_pos, player)
      puts "#{start_pos} move to #{end_pos}"
      self[start_pos], self[end_pos] = NullPiece.new("nil", "nil"), self[start_pos]
    end

  end

  def in_check?(color)
    #return true if any piece of opposite color has the king as a valid move
  end

  def valid_move?(start_pos,end_pos, player)
    piece = self[start_pos]
      raise WrongColor if piece.color != player.color
      raise InvalidMove unless piece.moves(start_pos).include?(end_pos)
      raise InvalidMove if self[start_pos].color == self[end_pos].color
      raise InCheck if start_pos == end_pos
    #can't move if you are in check after move
      #use move, call #in_check?, reset move
      #raise InCheck
      true

  end

  def[](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, val)
    @grid[pos[0]][pos[1]] = val
  end

  def in_bounds?(pos)
    # self[pos] ? true : false
    pos.all? {|position| position.between?(0,7)}
  end

  def game_over?
    false
    # TODO
  end
end

# if __FILE__ == $PROGRAM_NAME
#
# a = Board.new
# b = Display.new(a)
#
#   loop do
#     b.render
#     b.get_input
#   end
# end
class WrongColor < StandardError
  def message
    "You can't move that piece"
  end
end

class InvalidMove < StandardError
  def message
    "You can't move there"
  end
end

class InCheck < StandardError
  def message
    "You would be in check after that move"
  end
end
