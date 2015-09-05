class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    # each_with_index { |link, j| return link if i == j }
    # nil
    get(i)
  end

  def first
    @head
  end

  def last
    # puts "List#last called"
    # p @head
    link = @head
    until link.next.nil?
      link = link.next
    end
    link
  end

  def empty?
   @head.next.nil?
  end

  def get(key)
    link = @head
    until link.next.nil?
      return link.val if link.key == key
      link = link.next
    end
    return link.val if link.key == key
    nil
  end

  def include?(key)
    link = @head
    until link.next.nil?
      return true if link.key == key
      link = link.next
    end
    return true if link.key == key
    false
  end

  def insert(key, val)
    last.next = Link.new(key, val)
  end

  def remove(key)
    previous_link = nil
    link = @head
    until link.next.nil?
      return previous_link.next = link.next if link.key == key

      previous_link = link
      link = link.next
    end
  end

  def each
    link = @head
    until link == last
      link = link.next
      yield(link)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
