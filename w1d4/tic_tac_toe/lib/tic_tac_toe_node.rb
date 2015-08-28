require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @possible_moves = []
  end

  attr_accessor :possible_moves
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def losing_node?(evaluator)
    children
    if @board.over?
      if board.winner == evaluator || board.winner.nil?
        false
      else
        true
      end
    else #board.over? == false
      if evaluator == next_mover_mark
        possible_moves.all? {|node| node.losing_node?(evaluator)}
      else
        possible_moves.any? {|node| node.losing_node?(evaluator)}
      end
    end
  end

  def winning_node?(evaluator)
    children
    if @board.over?
      if board.winner == evaluator
        true
      else
        false
      end
    else
      if evaluator == next_mover_mark #board.over? == false
        possible_moves.any? {|node| node.winning_node?(evaluator)}
      else
        possible_moves.all? {|node| node.winning_node?(evaluator)}
      end
    end
  end

  def flip_mark(mark)
    if mark == :x
      :o
    else
      :x
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @possible_moves = []

    3.times do |row|
      3.times do |col|
        child = board.dup
        if child.empty?([row, col])
          child[[row, col]] = next_mover_mark
          # child.board[row][col]
          possible_moves << TicTacToeNode.new(child, flip_mark(next_mover_mark), [row, col])
          # possible_moves.last.children
        end
      end
    end
    possible_moves
  end

end
