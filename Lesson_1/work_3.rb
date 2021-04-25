puts "Треугольник прямоугольный ?"
print "Первая сторона:"
a = gets.to_f

print "Вторая сторона:"
b = gets.to_f

print "Третья сторона:"
c = gets.to_f

sides = [a, b, c].sort
hypotenuse = sides[2] ** 2
side_1 = sides[0] ** 2
side_2 = sides[1] ** 2
sum_side = side_1 + side_2


if (a == b) && (a == c) && (b == c)
  puts "Треугольник равнобедренный и равносторонний, но не прямоугольный."
elsif (hypotenuse == sum_side) && (side_1 == side_2)  
  puts "Треугольник равнобедренный и прямоугольный."
elsif (hypotenuse == sum_side)
  puts "Треугольник прямоугольный." 
else
  puts "Треугольник не прямоугольный."    
end
