res = {}
sum = 0

loop do
  puts 'Please enter a name of a product...'
  name = gets.chomp
  break if name == 'стоп' || name == 'stop'

  puts 'Please enter a price per meal...'
  price = gets.chomp.to_f

  puts 'Please enter a quantity of the product...'
  quantity = gets.chomp.to_f

  res[name.to_sym] = { price: price, quantity: quantity }
end

res.each { |_, h| sum += h[:price] * h[:quantity] }
p res
p sum
