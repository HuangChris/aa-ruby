require "byebug"

def range(start,last)
  return [] if last < start
  return [last] if start == last
  range(start, last-1) << last
end

def sum_recursive(array)
  return array[0] if array.length == 1
  array.first + sum_recursive(array.drop(1))
end

def sum_iterative(array)
  sum = 0
  array.each do |el|
    sum += el
  end
  sum
end

def exponent_1(base, exponent)
  # return 1 if exponent == 0
  # base * exponent_1(base,exponent-1)
  exponent == 0 ? 1 : base * exponent_1(base, exponent - 1)
end

def exponent_2 (base, exponent)
  return 1 if exponent == 0
  return base if exponent == 1

  if exponent.odd?
    base * (exponent_2(base, (exponent-1)/2)**2)
  else
    exponent_2(base,exponent/2) ** 2
  end
end

class Array
  def deep_dup
    self.map do |el|
      if el.is_a?(Array)
        el.deep_dup
      else
        a = el * 1
      end
    end
  end
end

def fibonacci_r(num)
  return [1] if num < 2
  return [1,1] if num == 2
  a = fibonacci_r(num-1)
  a << (a[-1] + a[-2])
end

def fibonacci_i(num)
  results = []
  num.times do |i|
    if i < 2
      results << 1
    else
      results << (results[-1]+results[-2])
    end
  end
  results
end

def bsearch(array,number)
  pivot = array.length / 2
  return nil if array == []
  if number == array[pivot]
    return pivot
  elsif number < array[pivot]
    bsearch(array.take(pivot),number)
  else
    plus = bsearch(array[(pivot + 1)..-1],number)
    plus.nil? ? nil : pivot + 1 + plus
  end
end

def subsets(array)
  return [[]] if array.empty?
  sets = subsets(array.drop(1))
    list = sets.dup
    #sets = subsets(array(-last element))
    #to each subset in sets, add (last element), and add to sets
    list.each {|subset| sets << ( subset + [array[0]])}
    sets
  end

# def make_change(number, change)
#   #return array of values from change that add to number
#   change.sort.reverse!
#   return [] if number == 0 #base case
#   if number >= change.first
#     [change.first] + make_change(number - change.first, change)
#   else
#     make_change(number, change[1..-1])
#   end
# end
#
# def best_change(number,change)
#   return [] if change == [] || number == 0
#   best_solution = nil
#   change.sort.reverse!
#   change.length.times do
#     solution = make_change(number, change)
#     change.shift
#     best_solution ||= solution
#     if best_solution.length > solution.length
#       best_solution = solution
#     end
#   end
#
#   best_solution
# end
#
#
# def make_change(num, ch)
#   # base cases
#   return nil if ch == []
#   return [] if num == 0
#   # two recursive calls
#   # compare the recursive calls
#   # e.g.: best_change(num - ch[0], ch)
#   # AND best_change(num, ch.drop(1))
#   if num - ch[0] >= 0
#     a = [ch[0]] + make_change(num- ch[0], ch)
#   end
#     b =  make_change(num, ch.drop(1))
#   # return lowest change
#   !a.nil? && a.length < b.length ? a : b
# end
