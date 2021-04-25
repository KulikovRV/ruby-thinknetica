# Заполнить массив числами фибоначчи до 100

fibonacci = [1, 1]
i = 0

loop do
  next_value = fibonacci[i] + fibonacci[i + 1]
  i += 1
  break if next_value > 100
  fibonacci << next_value
end  

puts fibonacci
