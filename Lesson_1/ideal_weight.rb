puts "Enter your name.."
name = gets.chomp

puts "Enter your height.."
height = gets.chomp.to_f

ideal_weight = (height - 110) * 1.15

puts ideal_weight < 0 ? "Your weight is normal" : "#{name}'s ideal weight is: #{ideal_weight}"
