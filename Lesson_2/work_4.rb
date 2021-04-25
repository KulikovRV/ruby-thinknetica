# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

hash_1 = {}
hash_2 = {} 

serial_number = 1
vowels = ['a', 'e', 'i', 'o', 'u']
i = 0

for letter in 'a'..'z'
  hash_1[letter] = serial_number
  serial_number += 1
  if letter == vowels[i]
    hash_2[letter] = hash_1[letter]
    i += 1
    end
end  

puts hash_2
