# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
# Найти порядковый номер даты, начиная отсчет с начала года. 
# Учесть, что год может быть високосным. 

puts "Day:"
day = gets.chomp.to_i

puts "Month number:"
mounth = gets.chomp.to_i

puts "Year:"
year = gets.chomp.to_i

mounths_count = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
feb_in_leap_year = 29

if mounth == 1
  date = day
  puts day
elsif ((year % 4 == 0) && (year % 100 > 0)) || (year % 400 == 0)
  mounths_count[1] = feb_in_leap_year
  mounth -= 2
  date = mounths_count[0..mounth].sum + day
  puts date
else 
  mounth -= 2
  date = mounths_count[0..mounth].sum + day
  puts date
end
