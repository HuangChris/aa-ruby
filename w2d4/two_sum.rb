def two_sum_brute(arr, target)
  i = 0
  while(i < arr.length)
    j = i + 1
    while(j < arr.length)
      return true if arr[i]+arr[j] == target
      j += 1
    end
    i += 1
  end
  false
end

def two_sum_sort(arr, target)
  arr.sort!
  i = 0
  j = arr.length-1

  while(i < j)
    return true if arr[i] + arr[j] == target
    i += 1 if arr[i] + arr[j] < target
    j -= 1 if arr[i] + arr[j] > target
  end
  false
end

def two_sum_hash(arr, target)
  hash = Hash.new
  arr.each do |el|
    return true if hash[el]
    hash[target - el] = true
  end


  false
end

def n_sum_hash(arr, target, number_of_sums)
  hash = Hash.new {|hash, key| hash[key] = Array.new}
  arr.each do |el|
    return true if hash[el].length == number_of_sums - 1
    hash[target - el] = [el]
    new_hash = Hash.new
    hash.each do |key, val|
      new_hash[key - el] = hash[key] + [el]
    end
    hash.merge!(new_hash)
  end


  false
end
