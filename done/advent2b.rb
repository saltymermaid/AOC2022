moves = File.open("advent2data.txt")

points = {win: 6, draw: 3, lose: 0}
my_points = 0
elf_points = 0
shapes = {rock: 1, paper: 2, scissors: 3}
elf_plays = {"A" => :rock, "B" => :paper, "C" => :scissors}
my_outcomes = {"X" => :lose, "Y" => :draw, "Z" => :win}

moves.each do |move|
  play = move.split
  elf_play = elf_plays[play[0]]
  my_outcome = my_outcomes[play[1]]
  my_points += points[my_outcome]
  if my_outcome == :draw
    my_play = elf_play
    elf_points += points[:draw]
  elsif my_outcome == :lose
    my_play = shapes.key((shapes[elf_play] + 1) % 3 + 1)
    elf_points += points[:win]
  else
    my_play = shapes.key(shapes[elf_play] % 3 + 1)
  end
  elf_points += shapes[elf_play]
  my_points += shapes[my_play]
  puts "Elf: #{elf_play} : #{elf_points} | #{my_outcome} | Me: #{my_play} : #{my_points}"
end

puts "Me: #{my_points} | Elf: #{elf_points}"