require_relative 'my_stack'

def max_range(array,window)
  max_range = nil
  array.each_with_index do |el, start_idx|
    sub_array = array[start_idx..start_idx + window - 1]
    max = sub_array.max
    min = sub_array.min
    max_range = max - min if max_range.nil? || max - min > max_range
  end
  max_range
end

def max_range_queue(array, window)
  queue = StackQueue.new

  window.times do |idx|
    queue.enqueue(array[idx])
  end

  range = queue.max - queue.min

  (array.length - window).times do |idx|
    queue.dequeue
    queue.enqueue(array[window + idx])
    range = queue.max - queue.min if queue.max - queue.min > range
  end

  range
end
