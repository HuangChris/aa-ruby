require "byebug"

class WordChainer
  attr_accessor :new_words, :seen_words
  def initialize (dictionary_file_name)
    @new_words = []
    @seen_words = {}
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
    @dictionary = Set.new(@dictionary)
  end

  def adjacent_words(word)
    #debugger
    #variations in solution: not defining alphabet; calling range(a-z).each
    #no need to split string to array for the methods we've called on it.
    #instead of resetting the word in the loop, dup the word before changing it
    #in each loop.

    adjacent = []
    alphabet = ("a".."z").to_a
    word_array = word.split("")
    word_array.each_with_index do |value, idx|
        alphabet.each do |letter|
          word_array[idx] = letter
          if @dictionary.include?(word_array.join(""))
            adjacent << word_array.join("")
          end
        end
          word_array[idx] = value
    end
    adjacent
  end

  def build_path(target)
    #solution handles iteratively.
    return [target] if seen_words[target].nil?
    build_path(seen_words[target]) + [target]
  end

  def run(source,target)
    current_words = [source]
    seen_words[source] = nil
    #until current_words.empty? || seen_words.has_key?
    while !current_words.empty? && !seen_words.has_key?(target)
      #everything within loop is #goodwords method
      new_words = [] #initialize each run
      current_words.each do |word|
        new_words += good_words(word)
        end
        p new_words
        current_words = new_words
    end
    puts "found a path:"
    p build_path(target)
  end

  def run_recursive(source,target)
  end

  def good_words(word)
    new_words = []
    adjacent_words(word).each do |new_word|
      if !seen_words.has_key?(new_word)
        new_words << new_word
        seen_words[new_word] = word
      end
    end
      new_words
  end

end

if __FILE__ == $PROGRAM_NAME
  a = WordChainer.new("dictionary.txt")
  a.run("at", "do")
end
