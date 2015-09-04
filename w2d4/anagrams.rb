def first_anagram(str1, str2)
  subs_str1 = create_substrings(str1)
  subs_str1.include?(str2)
end

def create_substrings(str1)
  if(str1.length < 2)
    return [str1]
  end

  str1 = str1.split("")
  new_subs = []
  str1.length.times do
    subs = create_substrings(str1.drop(1).join(""))
    new_subs += subs.map {|str| str1.first + str}
    str1.rotate!
  end
  new_subs
end

def second_anagram(str1, str2)
  if(str1.length != str2.length)
    return false
  end

  str1 = str1.split("")
  str2 = str2.split("")

  until str1.empty? || str2.empty?
    deleted = false
    str1.each_with_index do |char1, i|
      str2.each do |char2|
        if char1 == char2
          str1.delete(char1)
          str2.delete(char2)
          deleted = true
        end
      end
    end
    return false unless deleted
  end

  str1.empty? && str2.empty?
end

def third_anagram(str1, str2)
  str1.split("").sort == str2.split("").sort
end

def fourth_anagram(str1, str2)
  hash = Hash.new{|hash, key| hash[key] = Array.new(2){0}}

  [str1, str2].each_with_index do |str, idx|
    str1.split("").each do |char|
      hash[char][idx] += 1
    end
  end

  # str1.split("").each do |char|
  #   hash[char][0] +=1
  # end
  #
  # str2.split("").each do |char|
  #   hash[char][1] += 1
  # end

  hash.all? { |k,v| v[0] == v[1] }
end
