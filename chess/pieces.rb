require 'byebug'
class Piece

  attr_accessor :board
  attr_reader   :color

  def initialize(piece_type, color, board)
    @type  = piece_type
    @board = board
    @color = color
  end

  def to_s
    " #{@type[0]} "
  end

  def moves(movelist)

    movelist.select do |move|
      move[0].between?(0,7) && move[1].between?(0,7)
      #move is not to a spot off the grid
    end
  end

  def occupied?
    true
  end

  def dup(new_board)
    self.class.new(self.color, new_board)
  end
end


class NullPiece < Piece
  def initialize(color, board)
    @type  = nil
    @board = board
    @color = nil
  end

  def to_s
    "  "
  end

  def moves(_)
    []
  end

  def occupied?
    false
  end



end

class Pawn < Piece
  def initialize(color, board)
    super("Pawn", color, board)
  end

  def moves(start_pos)
    movelist = []
    if color == :black
      plus_1 = [start_pos[0] + 1, start_pos[1]]
      movelist << plus_1 unless @board[plus_1].color == :white
      plus_2 = [3, start_pos[1]]
      if start_pos[0] == 1  && !@board[plus_2].occupied? && !@board[plus_1].occupied?
        movelist << plus_2
      end
      attack_move_1 = [start_pos[0] + 1, start_pos[1] + 1]
      attack_move_2 = [start_pos[0] + 1, start_pos[1] - 1]
      if attack_move_1[0].between?(0,7) && attack_move_1[1].between?(0,7)
        movelist << attack_move_1 if @board[attack_move_1].color == :white
      end
      if attack_move_2[0].between?(0,7) && attack_move_2[1].between?(0,7)
        movelist << attack_move_2 if @board[attack_move_2].color == :white
      end

    else
      plus_1 = [start_pos[0] - 1, start_pos[1]]
      movelist << plus_1 unless @board[plus_1].color == :black
      plus_2 = [4, start_pos[1]]
      if start_pos[0] == 6 && !@board[plus_2].occupied? && !@board[plus_1].occupied?
        movelist << plus_2
      end
      attack_move_1 = [start_pos[0] - 1, start_pos[1] + 1]
      attack_move_2 = [start_pos[0] - 1, start_pos[1] - 1]
      if attack_move_1[0].between?(0,7) && attack_move_1[1].between?(0,7)
        movelist << attack_move_1 if @board[attack_move_1].color == :black
      end
      if attack_move_2[0].between?(0,7) && attack_move_2[1].between?(0,7)
        movelist << attack_move_2 if @board[attack_move_2].color == :black
      end
    end
      movelist
  end

  def to_s
    "♟ "
  end
end

class StepPiece < Piece
  def moves(start_pos)
    movelist = []
    move_diff.each do |diff|
      movelist << [(start_pos[0] + diff[0]), (start_pos[1] + diff[1])]
    end
    super(movelist)
    movelist
  end
  #Knight and King
end

class SlidePiece < Piece
  #Rook, Bishop, Queen
  def moves(start_pos)
    movelist = []
    move_diff.each do |diff|
      7.times do |idx|
        pos = [start_pos[0] + (idx + 1) * diff[0], start_pos[1] + (idx + 1) * diff[1]]
        #we need to break the loop once it hits an occupied space.
        break unless pos[0].between?(0,7) && pos[1].between?(0,7)
        movelist << pos
        break if @board[pos].occupied?
      end
    end
    movelist
  end
end

class Knight < StepPiece

  def initialize(color, board)
    super("Night", color, board)
  end

  def move_diff
    [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
  end

  def to_s
    "♞ "
  end
end

class King < StepPiece

  def initialize(color, board)
    super("King", color, board)
  end

  def move_diff
    [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
  end

  def to_s
    "♚ "
  end
end

class Rook < SlidePiece

  def initialize(color, board)
    super("Rook", color, board)
  end

  def move_diff
    [[1,0],[0,1],[-1,0],[0,-1]]
  end

  def to_s
    "♜ "
  end
end

class Bishop < SlidePiece
  def initialize(color, board)
    super("Bishop", color, board)
  end

  def move_diff
    [[1,1],[-1,1],[-1,-1],[1,-1]]
  end

  def to_s
    "♝ "
  end
end

class Queen < SlidePiece
  def initialize(color, board)
    super("Queen", color, board)
  end

  def move_diff
    [[1,1],[-1,1],[-1,-1],[1,-1],[1,0],[0,1],[-1,0],[0,-1]]
  end

  def to_s
    "♛ "
  end
end
