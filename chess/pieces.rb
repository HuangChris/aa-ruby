class Piece
  attr_accessor :board
  attr_reader   :color

  def initialize(piece_type, color, board)
    @type, @board, @color  = piece_type, board, color
  end

  # def moves(movelist)
  #   # movelist.select do |move|
  #   #   move[0].between?(0,7) && move[1].between?(0,7)
  #   #   #move is not to a spot off the grid
  #   # end
  # end

  def valid_move?(start_pos, end_pos, flag)
    return false unless @board.in_bounds?(end_pos)
    return false if @board[start_pos].color == @board[end_pos].color
    if flag
      test_board = @board.dup
      test_board.move!(start_pos, end_pos)
      return false if test_board.in_check?(color)
    end
    true
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
    @type, @board, @color  = nil, board, nil
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

  def pawn_moves(start_pos)
    movelist = []
    if color == :black
      diff, origin, opposite = 1, 1, :white
    else
      diff, origin, opposite = -1, 6, :black
    end

    plus_1 = [start_pos[0] + diff, start_pos[1]]
    movelist << plus_1 unless @board[plus_1].occupied?
    plus_2 = [origin + 2 * diff, start_pos[1]]

    if start_pos[0] == origin  && !@board[plus_2].occupied? && !@board[plus_1].occupied?
      movelist << plus_2
    end

    attack_move_1 = [start_pos[0] + diff, start_pos[1] + 1]
    attack_move_2 = [start_pos[0] + diff, start_pos[1] - 1]
    if board.in_bounds?(attack_move_1)
      movelist << attack_move_1 if @board[attack_move_1].color == opposite
    end
    if board.in_bounds?(attack_move_2)
      movelist << attack_move_2 if @board[attack_move_2].color == opposite
    end
    movelist
  end

  def moves(start_pos,flag)
    movelist = pawn_moves(start_pos)
    movelist.select {|move| valid_move?(start_pos, move, flag)}
  end

  def to_s
    "♟ "
  end
end

class StepPiece < Piece
  #Knight and King
  def moves(start_pos, flag)
    movelist = []
    move_diff.each do |diff|
      movelist << [(start_pos[0] + diff[0]), (start_pos[1] + diff[1])]
    end
    movelist.select {|move| valid_move?(start_pos, move, flag)}
    # movelist
  end
end

class SlidePiece < Piece
  #Rook, Bishop, Queen
  def moves(start_pos, flag)
    movelist = []
    move_diff.each do |diff|
      7.times do |idx|
        pos = [start_pos[0] + (idx + 1) * diff[0], start_pos[1] + (idx + 1) * diff[1]]
        #we need to break the loop once it hits an occupied space.
        break unless board.in_bounds?(pos)
        movelist << pos
        break if @board[pos].occupied?
      end
    end
    #movelist
    movelist.select {|move| valid_move?(start_pos, move, flag)}
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
