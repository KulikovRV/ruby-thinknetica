# Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом). 
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара. 
# На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. 
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

goods = Hash.new
value = Hash.new
price_for_goods = Hash.new

while true
  puts "Product Name:"
  product = gets.chomp.downcase

  if product == "stop"
    break
  end  

  puts "Price for one:"
  price = gets.chomp

  puts "Count:"
  count = gets.chomp

  value[price.to_sym] = count.to_i
  goods[product.to_sym] = value
  price_for_goods[product.to_sym] = price.to_i * count.to_i
end

puts goods
puts price_for_goods

array = []
price_for_goods.each_value {|v| array.push(v)}
puts array.sum
