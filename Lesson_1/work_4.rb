puts "Решим квадратное уровнение."
print "Введите a:"
a = gets.to_f

print "Введите b:"
b = gets.to_f

print "Введите c:"
c = gets.to_f

d = (b ** 2) - (4 * a * c)
d_sqrt = Math.sqrt(d)

if d < 0
  puts "Корней нету, D = #{d}"
elsif d == 0
  x = -b / (2 * a) 
  puts "D = #{d}, корень #{x}"
elsif d > 0
  x_1 = (-b + d_sqrt) / (2 * a)
  x_2 = (-b - d_sqrt) / (2 * a)
  puts "D = #{d}, x1 = #{x_1}, x2 = #{x_2}"          
end
