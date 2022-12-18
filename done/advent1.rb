snacks = File.open("advent1data.txt")

elves = []
elf = 0
elves[elf] = 0
snacks.each do |snack|
  if snack.to_i > 0
    elves[elf] += snack.to_i
  else
    elf = elf + 1
    elves[elf] = 0
  end
end

puts elves.max(3).sum