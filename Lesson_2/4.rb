alphabet = ('a'..'z').to_a
vowels = %w[a e i o u y]
res_hash = {}

alphabet.each_with_index { |v, i| res_hash[v] = i if vowels.include?(v) }

p res_hash
