require "byebug"
def merge_sort(array)
  #debugger
  return array if array.length < 2

  left = array[0..array.length / 2 - 1]
  right = array[array.length / 2..-1]

  left = merge_sort(left)
  right = merge_sort(right)

  sorted = []
  until left.empty? && right.empty?
    if left.empty? || (!right.empty? && left[0] > right[0])
      sorted << right.shift
    else
      sorted << left.shift
    end
  end
  sorted
end


'''

def merge_sort(array)
  return array if array.length == 1
  array.each_index do |idx|
    break if array[idx+1] == nil
    if (array[idx] <=> array[idx+1]) == 1
      array[idx], array[idx+1] = array[idx+1], array[idx]
    end
    array[idx] += array[idx+1]
  end
  merge_sort(array)
end
'''
