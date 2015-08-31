require_relative 'display'

class Player
  attr_accessor :display
  attr_reader :color

  def initialize(name,board,color)
    @name = name
    @board = board
    @display = Display.new(@board)
    @color = color
  end

  def render_board(pos)
    @display.render(pos)
  end


end
