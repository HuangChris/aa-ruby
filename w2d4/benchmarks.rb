require 'benchmark'
require_relative 'anagrams'
require_relative 'max_window'
require_relative 'two_sum'

def anagrams_benchmarks(count, size)
    string1 = create_random_strings(size)
    string2 = create_random_strings(size)


    Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                        "Avg. Merge:  ", "Avg. Bubble: ") do |b|
      #b.report("First Anagram n!") { first_anagram(string1, string2) }
      b.report("Second Anagram n**3") { second_anagram(string1, string2) }
      b.report("Third Anagram n log(n)") { third_anagram(string1, string2) }
      b.report("Fourth Anagram n") { fourth_anagram(string1, string2) }
    end
end

def create_random_strings(size)
  str = ""
  size.times do
    str << ("a".."z").to_a.sample
  end
  str
end

def max_window_benchmarks(count, size)
    test_array = Array.new(size){ rand(size)}

    Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                        "Avg. Merge:  ", "Avg. Bubble: ") do |b|
      #b.report("First Anagram") { first_anagram(string1, string2) }
      # b.report("Window N**2") { max_range(test_array, size / 2) }
      b.report("Window N") { max_range_queue(test_array, size / 2) }

    end
end

def two_sum_benchmarks(count, size)
  test_array = Array.new(size){ rand(size)}


    Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                        "Avg. Merge:  ", "Avg. Bubble: ") do |b|
      #b.report("First Anagram n!") { first_anagram(string1, string2) }
      b.report("sum brute n**2") { two_sum_brute(test_array, size) }
      b.report("sum sort n log(n)") { two_sum_sort(test_array, size) }
      b.report("sum hash n") { two_sum_hash(test_array, size) }
    end
end

two_sum_benchmarks(1, 10000)
two_sum_benchmarks(1, 100000)
two_sum_benchmarks(1, 1000000)
two_sum_benchmarks(1, 10000000)

anagrams_benchmarks(1, 10000)
anagrams_benchmarks(1, 100000)
anagrams_benchmarks(1, 1000000)
anagrams_benchmarks(1, 10000000)


max_window_benchmarks(1, 10000)
max_window_benchmarks(1, 100000)
max_window_benchmarks(1, 1000000)
max_window_benchmarks(1, 10000000)
max_window_benchmarks(1, 100000000)
