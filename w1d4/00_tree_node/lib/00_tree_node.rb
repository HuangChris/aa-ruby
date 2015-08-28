require "byebug"

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  attr_reader :parent, :value
  attr_accessor :children

  def parent=(parent)
    @parent.children.delete(self) unless @parent.nil?
    #repeated @parent = parent, can move .nil? condition to unless statement
    if parent.nil?
      @parent = nil
    else
      @parent = parent
      @parent.children << self unless @parent.children.include?(self)
    end
  end


  def add_child(child_node)
    @children << child_node
    child_node.parent = self
  end

  def remove_child(child)
    #unless children.include?(child)  ?
    raise "not child" unless children.include?(child)
    @children.delete(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    return nil if children.empty?

    self.children.each do |child|
      search_result = child.dfs(target_value)
      return search_result if !search_result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    return nil
  end
end
