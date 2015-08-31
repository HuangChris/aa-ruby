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
      #move is not to a spot with a piece of the same color
    end
  end
end


class NullPiece < Piece
  def to_s
    "   "
  end

  def moves(_)
    []
  end

end

class Pawn < Piece
  def initialize(color)
    super("Pawn", color)
  end
end

class StepPiece < Piece
  def moves(start_pos)
    movelist = []
    MOVE_DIFF.each do |diff|
      movelist << [(start_pos[0] + diff[0]), (start_pos[1] + diff[1])]
    end
    p start_pos
    p MOVE_DIFF
    p movelist
    #create movelist using MOVE_DIFF
    super(movelist)
    # p movelist
    movelist
  end
  #Knight and King
end

class SlidePiece < Piece
  #Rook, Bishop, Queen
end

class Knight < StepPiece
  MOVE_DIFF = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]

  def initialize(color)
    super("Night", color)
  end

end

class King < StepPiece
  MOVE_DIFF = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]

  def initialize(color)
    super("King", color)
  end
end

class Rook < SlidePiece
  def initialize(color)
    super("Rook", color)
  end
end

class Bishop < SlidePiece
  def initialize(color)
    super("Bishop", color)
  end
end

class Queen < SlidePiece
  def initialize(color)
    super("Queen", color)
  end
end
