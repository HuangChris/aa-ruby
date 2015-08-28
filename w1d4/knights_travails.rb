require_relative '00_tree_node/lib/00_tree_node.rb'

class KnightPathFinder

  def initialize(start_pos)
    @start_pos = PolyTreeNode.new(start_pos)
    @move_tree = [@start_pos]
    build_move_tree
  end
  #set these private?

  def find_path(end_pos)
    #p move_tree.map {|node| node.value}
    last_node = start_pos.bfs(end_pos)
     path = []
     until last_node.parent.nil?
       path << last_node
       last_node = last_node.parent
     end
     path << last_node
     path.reverse!
     path.each do |node|
       p node.value
     end
   end


  def build_move_tree
    #called on start_pos and builds nodes for each possible move
    queue = [start_pos]
    until queue.empty?
      position = queue.shift
      new_moves = new_move_positions(position.value)
      new_moves.each do |pos|
          if new_move?(pos)
            move_tree << PolyTreeNode.new(pos)
            queue << move_tree.last
            move_tree.last.parent = position
          end
      end
    end
  end

  def new_move?(pos)
    #can use #any?
    @move_tree.each do |node|
      return false if node.value == pos
    end
    true
  end

  def new_move_positions(pos)
    possible_moves = []
    possible_moves << [(pos[0] - 2), (pos[1] - 1)]
    possible_moves << [(pos[0] - 2), (pos[1] + 1)]
    possible_moves << [(pos[0] - 1), (pos[1] - 2)]
    possible_moves << [(pos[0] - 1), (pos[1] + 2)]
    possible_moves << [(pos[0] + 1), (pos[1] - 2)]
    possible_moves << [(pos[0] + 1), (pos[1] + 2)]
    possible_moves << [(pos[0] + 2), (pos[1] - 1)]
    possible_moves << [(pos[0] + 2), (pos[1] + 1)]

    #select makes more sense than map here, I think
    possible_moves.select do |move|
      move[0] >= 0 && move[0] < 8 && move[1] >= 0 && move[1] < 8
    end
    #returns all possible moves from that pos
  end
  private
  attr_reader :start_pos, :move_tree
  #def trace_path_back
  #end
end

if __FILE__ == $PROGRAM_NAME
  a = KnightPathFinder.new([0,0])
  a.find_path([7,6])
  a.find_path([6,2])
end
