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
      bg = :blue
    end
    if @board[[i,j]].color == :white
      { background: bg, color: :white }
    else
      { background: bg, color: :black }
    end

  end

  def render(selected_pos)
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid(selected_pos).each { |row| puts row.join }
  end
end