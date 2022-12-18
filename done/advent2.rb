moves = File.open("advent2data.txt")

points = {win: 6, draw: 3, lose: 0}
my_points = 0
elf_points = 0
shapes = {rock: 1, paper: 2, scissors: 3}
elf_plays = {"A" => :rock, "B" => :paper, "C" => :scissors}
my_plays = {"X" => :rock, "Y" => :paper, "Z" => :scissors}

moves.each do |move|
  play = move.split
  elf_play = elf_plays[play[0]]
  my_play = my_plays[play[1]]
  my_points += shapes[my_play]
  elf_points += shapes[elf_play]
  if shapes[elf_play] - shapes[my_play] == 0
    winner = "draw"
    my_points += points[:draw]
    elf_points += points[:draw]
  elsif (shapes[elf_play] % 3) == (shapes[my_play] -1)
    winner = "me"
    my_points += points[:win]
  else
    winner = "elf" 
    elf_points += points[:win]
  end
  puts "Elf: #{elf_play} : #{elf_points} | Me: #{my_play} : #{my_points} | #{winner}"
end

puts "Me: #{my_points} | Elf: #{elf_points}"