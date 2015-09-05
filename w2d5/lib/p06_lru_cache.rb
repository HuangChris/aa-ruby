require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    puts "getting key #{key}"
    p @store.first
    p @map.count
    if @map.include?(key)
      update_link!(@map[key])
      @map[key].val
    else
      eject! if count == @max
      value = @prc.call(key)
      link = @store.insert(key, value)
      @map[key] = link
      value
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link.key)
    @store.insert(link.key, link.val)
    # link.next = nil
    # @store.last.next = link
  end

  def eject!
    # debugger
    @map.delete(@store.first.next.key)
    @store.remove(@store.first.next.key)
  end
end
