require "byebug"

class MazeSolver
  attr_reader :maze, :start
  def initialize(file)

    @maze = File.readlines(file).map do |line|
      line.chomp.split("")
    end
      @start = []
      @finish = []
  end

  def [](pos)
    @maze[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @maze[pos[0]][pos[1]] = value
  end

  def possible_moves(pos)
    adj_moves = []
    adj_moves << [pos[0]-1,pos[1]-1]
    adj_moves << [pos[0]-1,pos[1]]
    adj_moves << [pos[0]-1,pos[1]+1]
    adj_moves << [pos[0],pos[1]-1]
    adj_moves << [pos[0],pos[1]+1]
    adj_moves << [pos[0]+1,pos[1]-1]
    adj_moves << [pos[0]+1,pos[1]]
    adj_moves << [pos[0]+1,pos[1]+1]
    adj_moves.select! {|move| self[move] == " " || self[move] == "E"}
    # puts "position: #{pos}"
    # puts "moves:  #{adj_moves}"
    adj_moves
  end



  def solve_bfs
    find_start
    find_finish
    queue = [@start]
    seen_positions = {@start => nil}
    until queue.empty? || seen_positions.include?(@finish)
    # puts "Seen position #{seen_positions}"
      # p queue
      current_position = queue.shift
      new_moves = possible_moves(current_position)
      new_moves.each do |move|
        unless seen_positions.include?(move)
          queue << move
          seen_positions[move] = current_position
          puts "#{move} => #{current_position}"
        end
      end
    end

    path = [@finish]
    spot = @finish
    # debugger
    puts "second to last spot #{seen_positions[@finish]}"
    until seen_positions[spot].nil?
      spot = seen_positions[spot]
      path << spot
    end
      path
  end

  def find_start
    start_pos = []
    @maze.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        start_pos = [row_idx, col_idx] if col == "S"
      end
    end
    @start = start_pos
  end

  def find_finish
    finish_pos = []
    @maze.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        finish_pos = [row_idx, col_idx] if col == "E"
      end
    end
    @finish = finish_pos
  end

end

a = MazeSolver.new("sample_maze.txt")
p a.maze
puts "solution: #{a.solve_bfs}"
