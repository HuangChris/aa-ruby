require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def build_grid(start_pos)
    @board.grid.map.with_index do |row, i|
      build_row(row, i, start_pos)
    end
  end

  def build_row(row, i, start_pos)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j, start_pos)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j, start_pos)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif [i,j] == start_pos
      bg = :yellow
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :light_green
    end
    if @board[[i,j]].color == :white
      { background: bg, color: :white }
    else
      { background: bg, color: :black }
    end

  end

  def render(cursor_pos, selected_pos, player, error = nil)
    @cursor_pos = cursor_pos
    system("clear")
    puts "It's #{player.color.to_s.capitalize}'s turn"
    puts "#{player.color.to_s.capitalize} is in check!" if @board.in_check?(player.color)
    puts "It's a stalemate" if @board.get_pieces(:white).length == 1 && @board.get_pieces(:black).length == 1
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid(selected_pos).each { |row| puts row.join }
    puts error.message unless error.nil?
  end
end
