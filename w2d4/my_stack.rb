class MyStack

  def initialize
    @store = []
    @size = 0
  end

  def push(val)
    if @size == 0
      @store[@size] = {value: val, max: val, min: val}
    else
      max = (val > self.max ? val : self.max)
      min = (val < self.min ? val : self.min)
      @store[@size] = {value: val, max: max, min: min}
    end

    @size += 1
  end

  def pop
    @size -= 1
    val = @store[@size][:value]
    val
  end

  def peek
    @store[@size-1][:value]
  end

  def size
    @size
  end

  def empty?
    @size == 0
  end

  def max
    @store[@size-1][:max]
  end

  def min
    @store[@size-1][:min]
  end
end

class StackQueue
  def initialize
    @inflow = MyStack.new
    @outflow = MyStack.new
  end

  def enqueue(val)
    @inflow.push(val)
  end

  def dequeue
    if @outflow.empty?
      flow
    end

    @outflow.pop
  end

  def peek
    if @outflow.empty?
      flow
    end

    @outflow.peek
  end

  def size
    @inflow.size + @outflow.size
  end

  def max
    if @inflow.empty? && @outflow.empty?
      return nil
    end

    if !@inflow.empty? && @outflow.empty?
      return @inflow.max
    elsif @inflow.empty? && !@outflow.empty?
      return @outflow.max
    end

    @inflow.max > @outflow.max ? @inflow.max : @outflow.max
  end

  def min
    if @inflow.empty? && @outflow.empty?
      return nil
    end

    if !@inflow.empty? && @outflow.empty?
      return @inflow.min
    elsif @inflow.empty? && !@outflow.empty?
      return @outflow.min
    end

    @inflow.min < @outflow.min ? @inflow.min : @outflow.min
  end

  private

  def flow
    until @inflow.empty?
      @outflow.push(@inflow.pop)
    end
  end
end
