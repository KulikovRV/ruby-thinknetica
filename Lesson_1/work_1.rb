print "Ваше имя:"
name = gets.chomp

print "Ваш рост:"
height = gets.to_f

FIX_NUM = 110
ideal_weight = height - FIX_NUM

if ideal_weight < 0
  puts "#{name}, ваш вес уже оптимальный."
else
  puts "#{name}, ваш идеальный вес #{ideal_weight}"
end
