NUM_ROUNDS = 20

class Monkey
  attr_accessor :id, :items, :operator, :operand, :divisible_by, :true_monkey, :false_monkey, :inspections

  def initialize(id, items, operator, operand, divisible_by, true_monkey, false_monkey)
    @id = id
    @items = items
    @operator = operator
    @operand = operand
    @divisible_by = divisible_by
    @true_monkey = true_monkey
    @false_monkey = false_monkey
    @inspections = 0
  end

  def inspect_items
    inspected_items = []
    items.each do |item|
      @inspections += 1
      case operator
      when '*'
        if operand == "old"
          inspected_items << item * item
        else
          inspected_items << item * operand.to_i
        end
      when '+'
        inspected_items << item + operand.to_i
      else
        inspected_items << item
      end
    end
    @items = inspected_items
  end
  
  def worry_less
    worried_items = []
    items.each do |item|
      worried_items << item / 3
    end
    @items = worried_items
  end

  def throw_to(item)
    item % divisible_by == 0 ? true_monkey : false_monkey
  end

  def print_items
    puts "Monkey #{id} | Items: #{items}"
  end

  def full_data
    puts "Monkey #{id} | Items: #{items} | Operation: #{operator} #{operand} | Div by: #{divisible_by} | true: #{true_monkey} | false: #{false_monkey}"
  end

  def to_s
    "Monkey #{id} | Items: #{items} | Inspections: #{inspections}"
  end
end

@monkeys = []

input = File.open("advent11data.txt")

def import_data(input)
  items = []
  ops = []
  opd = []
  div = []
  tm = []
  fm = []
  monkey = 0
  line = 0
  input.each do |raw|
    case line
    when 0
      monkey = raw.split[1].to_i
      line += 1
    when 1
      data = raw.split(": ")[1]
      its = data.split(", ")
      items[monkey] = its.map(&:to_i)
      line += 1
    when 2
      data = raw.split("old ")
      op = data[1].split(' ')
      ops[monkey] = op[0]
      opd[monkey] = op[1]
      line += 1
    when 3
      data = raw.split("by ")
      div[monkey] = data[1].to_i
      line += 1
    when 4
      data = raw.split("monkey ")
      tm[monkey] = data[1].to_i
      line += 1
    when 5
      data = raw.split("monkey ")
      fm[monkey] = data[1].to_i
      line += 1
    else
      line = 0
    end
  end
  num_monkeys = monkey + 1
  m = 0
  num_monkeys.times do
    @monkeys << Monkey.new(m, items[m], ops[m], opd[m], div[m], tm[m], fm[m])
    m += 1
  end
end

import_data(input)

@round_counter = 0

def execute_round
  @monkeys.each do |monkey|
    monkey.inspect_items
    monkey.worry_less
    throw_items(monkey)
  end
  @round_counter += 1
end

def throw_items(monkey)
  item_count = monkey.items.count
  item_count.times do
    item = monkey.items.shift
    new_monkey = monkey.throw_to(item)
    @monkeys[new_monkey].items << item
  end
end

def print_monkey_items
  @monkeys.each do |monkey|
    monkey.print_items
  end
end

while @round_counter < 20 do
  execute_round
end

inspects = []
@monkeys.each do |monkey|
  puts monkey
  inspects << monkey.inspections
end
top_two = inspects.max(2)
puts top_two[0] * top_two[1]