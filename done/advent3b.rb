rucksacks = File.open("advent3data.txt")

total_priorities = 0

groups = []

rucksacks.each_with_index do |rucksack, index|
  row = index / 3
  column = index % 3
  if column == 0
    groups[row] = []
  end
  groups[row][column] = rucksack
end

groups.each do |group|
  ruck = group[0].chomp.split('')
  sack = group[1].chomp.split('')
  duck = group[2].chomp.split('')
  common_arr = ruck & sack & duck
  puts "HALP! #{common_arr.length} | #{common_arr}" if common_arr.length != 1
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