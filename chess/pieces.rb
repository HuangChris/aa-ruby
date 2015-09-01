class Piece

  attr_accessor :board
  attr_reader   :color

  def initialize(piece_type, color)
    @type  = piece_type
    @board = nil
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
end


class NullPiece < Piece
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
  def initialize(color)
    super("Pawn", color)
  end

  def moves(start_pos)
    movelist = []
    if color == :black
      #blak is broken right now
      movelist << [start_pos[0] + 1, start_pos[1]]
      movelist << [start_pos[0] + 2, start_pos[1]] if start_pos[0] == 1
      attack_move_1 = [start_pos[0] + 1, start_pos[1] + 1]
      attack_move_2 = [start_pos[0] + 1, start_pos[1] - 1]
      # movelist << attack_move_1
      #if a piece diagonally forward of it
      #movelist << diagonally

    else
      movelist << [start_pos[0] - 1, start_pos[1]]
      movelist << [start_pos[0] - 2, start_pos[1]] if start_pos[0] == 6
    end
  end

  def to_s
    if self.color == :black
      "♟ "
    else
      "♙ "
    end
  end
end

class StepPiece < Piece
  def moves(start_pos)
    movelist = []
    move_diff.each do |diff|
      movelist << [(start_pos[0] + diff[0]), (start_pos[1] + diff[1])]
    end
    #create movelist using MOVE_DIFF
    super(movelist)
    p movelist
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
        # p pos
        # p @board
        # #we need to break the loop once it hits an occupied space.
        # break if @board[pos].nil? || @board[pos].occupied?
        movelist << pos
      end
    end
    # movelist = super(movelist)
    p movelist
    movelist
  end
end

class Knight < StepPiece

  def initialize(color)
    super("Night", color)
  end

  def move_diff
    [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
  end

  def to_s
    if self.color == :black
      "♞ "
    else
      "♘ "
    end
  end

end

class King < StepPiece

  def initialize(color)
    super("King", color)
  end

  def move_diff
    [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
  end

  def to_s
    if self.color == :black
      "♚ "
    else
      "♔ "
    end
  end

end

class Rook < SlidePiece

  def initialize(color)
    super("Rook", color)
  end

  def move_diff
    [[1,0],[0,1],[-1,0],[0,-1]]
  end

  def to_s
    if self.color == :black
      "♜ "
    else
      "♖ "
    end
  end
end

class Bishop < SlidePiece
  def initialize(color)
    super("Bishop", color)
  end

  def move_diff
    [[1,1],[-1,1],[-1,-1],[1,-1]]
  end

  def to_s
    if self.color == :black
      "♝ "
    else
      "♗ "
    end
  end
end

class Queen < SlidePiece
  def initialize(color)
    super("Queen", color)
  end

  def move_diff
    [[1,1],[-1,1],[-1,-1],[1,-1],[1,0],[0,1],[-1,0],[0,-1]]
  end

  def to_s
    if self.color == :black
      "♛ "
    else
      "♕ "
    end
  end
end
