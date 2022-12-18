rucksacks = File.open("advent3data.txt")

total_priorities = 0

rucksacks.each do |rucksack|
  length = rucksack.length
  half_length = length / 2
  ruck = rucksack.slice(0..(half_length - 1)).split('')
  sack = rucksack.slice(half_length..length).split('')
  common_arr = ruck & sack
  puts "HALP!" if common_arr.length != 1
  common = common_arr[0]
  common_ascii = common.ord
  if (common_ascii >= 97) 
    priority = common_ascii - 96
  else
    priority = common_ascii - 38
  end
  total_priorities += priority
end

puts total_priorities