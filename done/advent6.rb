signals = File.open("advent6data.txt")

signal_arr = signals.first.chomp.split('')

candidate = []
signal_arr.each_with_index do |sig, i|
  candidate << sig
  if candidate.uniq.length == 4 && candidate.length == 4
    puts "It's #{i + 1} | #{candidate}"
    break
  end
  if candidate.length == 4
    candidate.shift
  end
end
