signals = File.open("advent6data.txt")
MESSAGE_MARKER_LENGTH = 14

signal_arr = signals.first.chomp.split('')

candidate = []
signal_arr.each_with_index do |sig, i|
  candidate << sig
  if candidate.uniq.length == MESSAGE_MARKER_LENGTH && candidate.length == MESSAGE_MARKER_LENGTH
    puts "It's #{i + 1} | #{candidate}"
    break
  end
  if candidate.length == MESSAGE_MARKER_LENGTH
    candidate.shift
  end
end
