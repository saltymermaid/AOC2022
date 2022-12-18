class Cycle
  attr_accessor :cycle_num, :current_x, :state, :data, :instruction

  def initialize(num, instruction, current_x, data = 0)
    @cycle_num = num
    @current_x = current_x
    @instruction = instruction
    if instruction == "noop"
      @state = :noop
    elsif instruction == "addx"
      @state = :addx
    else
      @state = :wait
    end
    @data = data
  end

  def to_s
    "Cycle #{cycle_num} | State: #{state} | Data: #{data} | X: #{current_x}"
  end
end

def process_input
  counter = 1
  @instructions.each do |inst|
    if inst[0] == "noop"
      @cycles << Cycle.new(counter, inst[0], @x)
    elsif inst[0] == "addx"
      @cycles << Cycle.new(counter, inst[0], @x)
      counter += 1
      @cycles << Cycle.new(counter, nil, @x, inst[1].to_i)
      increment_x(inst[1].to_i)
    else
      puts "Something went wrong . . . ."
    end
    counter += 1
  end
end

def increment_x(data)
  @x += data
end

input = File.open("advent10data.txt")

@instructions = []
@cycles = []
@x = 1

input.each do |inst|
  @instructions << inst.chomp.split
end

process_input
signal_strength = 0
c = 19
6.times do
  # puts @cycles[c-1]
  cycle = @cycles[c]
  puts cycle
  signal_strength += (c + 1) * cycle.current_x
  # puts @cycles[c+1]
  c += 40
end

puts signal_strength

# @cycles.each do |c|
#   puts c
# end
