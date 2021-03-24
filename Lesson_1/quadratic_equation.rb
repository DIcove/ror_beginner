puts "Enter A.."
a = gets.chomp.to_f

puts "Enter B.."
b = gets.chomp.to_f

puts "Enter C.."
c = gets.chomp.to_f

d = b**2 - 4 * a * c

message = case
          when d > 0
            x1 = (-b + Math.sqrt(d)) / 2 * a
            x2 = (-b - Math.sqrt(d)) / 2 * a
            "Discriminant: #{d}, x1: #{x1}, x2: #{x2}"
          when d = 0
            x1 = -b / 2 * a
            "Discriminant: #{d}, x1: #{x1}"
          else
            "There r no roots.."
          end

puts message
