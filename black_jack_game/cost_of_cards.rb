$cost_of_cards = {}
point_for_picture = 10
max_ace_point = 11
min_ace_point = 1

2.upto(10) do |i|
  $cost_of_cards["#{i}""\u2660"] = i #spades
  $cost_of_cards["#{i}""\u2661"] = i #hearts
  $cost_of_cards["#{i}""\u2662"] = i #diamonds
  $cost_of_cards["#{i}""\u2663"] = i #clubs
end  

1.times do |i|
  i = 'J'
  $cost_of_cards["#{i}""\u2660"] = point_for_picture
  $cost_of_cards["#{i}""\u2661"] = point_for_picture 
  $cost_of_cards["#{i}""\u2662"] = point_for_picture 
  $cost_of_cards["#{i}""\u2663"] = point_for_picture
end  

1.times do |i|
  i = 'Q'
  $cost_of_cards["#{i}""\u2660"] = point_for_picture
  $cost_of_cards["#{i}""\u2661"] = point_for_picture 
  $cost_of_cards["#{i}""\u2662"] = point_for_picture 
  $cost_of_cards["#{i}""\u2663"] = point_for_picture
end

1.times do |i|
  i = 'K'
  $cost_of_cards["#{i}""\u2660"] = point_for_picture
  $cost_of_cards["#{i}""\u2661"] = point_for_picture 
  $cost_of_cards["#{i}""\u2662"] = point_for_picture 
  $cost_of_cards["#{i}""\u2663"] = point_for_picture
end

1.times do |i|
  i = 'A'
  $cost_of_cards["#{i}""\u2660"] = [min_ace_point, max_ace_point]
  $cost_of_cards["#{i}""\u2661"] = [min_ace_point, max_ace_point] 
  $cost_of_cards["#{i}""\u2662"] = [min_ace_point, max_ace_point] 
  $cost_of_cards["#{i}""\u2663"] = [min_ace_point, max_ace_point]
end
