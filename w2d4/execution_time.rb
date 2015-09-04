def my_min(ary)
  min = ary.first
  ary.each do |el|
    if min > el
      min = el
    end
  end
  min
end

def sub_sum(ary)
  current_sum = 0
  best_sum = 0
  ary.each do |el|
    current_sum += el if el >= 0
    if el < 0
      if current_sum + el < 0
        best_sum = current_sum if current_sum > best_sum
        current_sum = 0
      else
        best_sum = current_sum if current_sum > best_sum
        current_sum += el
      end
    end
  end
  best_sum = current_sum if current_sum > best_sum

  best_sum

end
