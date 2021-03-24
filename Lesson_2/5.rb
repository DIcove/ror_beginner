puts 'Please enter a day...'
day = gets.chomp.to_i

puts 'Please enter a month...'
month = gets.chomp.to_i
return day if month == 1

puts 'Please enter a year...'
year = gets.chomp.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
leap_year = (year % 4).zero? && (year % 400).zero? && year % 100 != 0

months[1] = 29 if leap_year

p months[0...months[month - 1]].inject(:+) + day
