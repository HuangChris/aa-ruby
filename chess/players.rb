require_relative 'display'

class Player
  attr_accessor :display
  attr_reader :color

  def initialize(name, board, color)
    @name, @board, @display, @color = name, board, Display.new(board), color
  end

  def render_board(pos, error = nil)
    @display.render(pos, self, error)
  end


end
