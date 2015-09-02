require_relative 'pieces'
require_relative 'display'

class Board
  attr_accessor :cursor_pos
  attr_reader :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
     populate
    # populate_test
  end

  def populate_test
    grid.each_with_index do |row,ridx|
      row.each_with_index do |_,cidx|
        self[[ridx,cidx]] = NullPiece.new(nil, self)
      end
    end
    self[[1,5]] = Pawn.new(:white, self)
    self[[5,7]] = King.new(:black, self)
    self[[1,3]] = King.new(:white, self)
  end

  def populate
    piece_lineup = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    piece_lineup.each_with_index do |piece, idx|
      self[[0,idx]] = piece.new(:black, self)
      self[[7,idx]] = piece.new(:white, self)
    end
    #creates tiles for pieces, assigns them to grid
    8.times do |idx|
      6.times do |j|
        self[[j+1,idx]] = NullPiece.new(nil, self)
      end
      self[[1,idx]] = Pawn.new(:black, self)
      self[[6,idx]] = Pawn.new(:white, self)
    end
  end

  def dup
    duped = Board.new
    grid.each_with_index do |row, ridx|
      row.each_with_index do |piece, pidx|
        duped[[ridx,pidx]] = self[[ridx,pidx]].dup(duped)
      end
    end

    duped
  end

  def move_piece(start_pos, end_pos, color)
    if valid_move?(start_pos, end_pos, color)
      # puts "#{start_pos} move to #{end_pos}" TODO see below (move!)
      self[start_pos], self[end_pos] = NullPiece.new(nil, self), self[start_pos]
    end

    promote_pawns(:white)
    promote_pawns(:black)
    #if pawn on last row, replace pawn with queen
  end

  def promote_pawns(color)
    color == :black ? (goal = 7) : (goal = 0)

    grid[goal].each_with_index do |piece, idx|
      if piece.class == Pawn && piece.color == color
        self[[goal, idx]] = Queen.new(color, self)
      end
    end
  end

  def find_king(color)
    grid.each_with_index do |row, ridx|
      row.each_with_index do |piece, sidx|
          # p piece.color
          # p piece.class
          # puts "#{color.to_s} #{[ridx,sidx]}"
        if piece.color == color && piece.class == King
          return [ridx, sidx]
        end
      end
    end
    p grid
    raise "what? no #{color} king!"
  end

  def in_check?(color)
    king_pos = find_king(color)
    other_color = (color == :black ? :white : :black)

    get_pieces(other_color).each do |pos, piece|
      if piece.color != color && piece.class != NullPiece
        return true if piece.moves(pos, false).include?(king_pos)
      end
    end
    false
    #find king
    #
    #return true if any piece of opposite color has the king as a valid move
  end

  def get_pieces(color)
    pieces = Hash.new
    grid.each_with_index do |row,ridx|
      row.each_with_index do |piece, pidx|
        pieces[[ridx,pidx]] = piece if piece.color == color
      end
    end
    pieces

  end

  def no_valid_moves?(color)
    get_pieces(color).none? do |pos, piece|
      piece.moves(pos,true).length > 0
    end
  end

  def check_mate?(color)
    no_valid_moves?(color) if in_check?(color)

    # puts "checkmate? #{var}"
    # var
  end

  def stale_mate?(color)
    no_valid_moves?(:white) && no_valid_moves?(:black)
    #no valid moves except king for both players


  end

  def move!(start_pos, end_pos)
    # puts "#{start_pos} move to #{end_pos}" TODO add to render (show last move)
    self[start_pos], self[end_pos] = NullPiece.new(nil, self), self[start_pos]
    promote_pawns(:white)
    promote_pawns(:black)
  end

  def valid_move?(start_pos, end_pos, color)
    piece = self[start_pos]
    raise WrongColor if piece.color != color
    raise InvalidMove unless piece.moves(start_pos,false).include?(end_pos)
    raise InvalidMove if self[start_pos].color == self[end_pos].color
    test_board = self.dup
    test_board.move!(start_pos, end_pos)
    raise InCheck if test_board.in_check?(color)

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

  def game_over?(color)
    check_mate?(color) || stale_mate?(color)
  end
end

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
