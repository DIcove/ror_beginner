puts "Enter side A.."
a = gets.chomp.to_f

puts "Enter side B.."
b = gets.chomp.to_f

puts "Enter side C.."
c = gets.chomp.to_f

vals = [a, b, c].sort

formula = vals.max**2 == vals[0]**2 + vals[1]**2

type = case
       when formula
        "right"
       when a == b && b == c && a == c
        "equilateral and isoscles"
       when a == b || b == c || a == c
        "isosceles"
       else
        "regular"
       end

puts "That's #{type} triangle"

# if formula
#   puts "That's right triangle"
# elsif a == b || b == c || a == c
#   puts "That's isosceles triangle"
# elsif a == b && b == c && a == c
#   puts "That's equilateral and isoceles triangle"
# else
#   puts "Just a regular triangle"
