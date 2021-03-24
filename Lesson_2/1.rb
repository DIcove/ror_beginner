months = %w[January February March April May June July August September October November December]

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

result = {}

months.length.times do |i|
  result[months[i].to_sym] = days[i]
end

result.each { |m, d| puts m if d == 30 }
