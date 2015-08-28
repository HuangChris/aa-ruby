require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_turn = TicTacToeNode.new(game.board, mark)
    current_turn.children.each do |node|
      return node.prev_move_pos if node.winning_node?(mark)
    end
    current_turn.children.each do |node|
      return node.prev_move_pos unless node.losing_node?(mark)

    end

    raise "Huh?"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
