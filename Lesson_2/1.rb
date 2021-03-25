months = %i[January February March April May June July August September October November December]

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

result = {}

months.each_with_index { |m, i| result[m] = days[i] }

result.each { |m, d| puts m if d == 30 }
