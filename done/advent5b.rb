stacks = []
stacks[0] = ["F", "T", "C", "L", "R", "P", "G", "Q"]
stacks[1] = ["N", "Q", "H", "W", "R", "F", "S", "J"]
stacks[2] = ["F", "B", "H", "W", "P", "M", "Q"]
stacks[3] = ["V", "S", "T", "D", "F"]
stacks[4] = ["Q", "L", "D", "W", "V", "F", "Z"]
stacks[5] = ["Z", "C", "L", "S"]
stacks[6] = ["Z", "B", "M", "V", "D", "F"]
stacks[7] = ["T", "J", "B"]
stacks[8] = ["Q", "N", "B", "G", "L", "S", "P", "H"]

raw_moves = File.open("advent5data2.txt")

moves = []
raw_moves.each_with_index do |rm, i|
  moves[i] = {}
  mermaid = rm.split
  moves[i][:num_to_move] = mermaid[1].to_i
  moves[i][:source] = mermaid[3].to_i
  moves[i][:dest] = mermaid[5].to_i
end

# {:num_to_move=>21, :source=>3, :dest=>5}

# stacks.each_with_index do |stack, i|
#   puts "#{i + 1}: #{stack.to_s}"
# end
# puts

moves.each do |move|
  move_blocks = stacks[move[:source] - 1].pop(move[:num_to_move])
  move_blocks.each do |block|
    stacks[move[:dest] - 1] << block
  end
  # puts "Move #{move[:num_to_move]}"
  # stacks.each_with_index do |stack, i|
  #   star = '   '
  #   if i == move[:dest] -1
  #     star = "D* "
  #   elsif i == move[:source] -1
  #     star = "S* "
  #   end
  #   puts "#{star}#{i + 1}: #{stack.to_s}"
  # end
  # puts
end


tops = []
stacks.each do |stack|
  tops << stack.last
end

puts tops.join