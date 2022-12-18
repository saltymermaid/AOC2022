class Move
  attr_accessor :distance, :direction

  def initialize(direction, distance)
    @direction = get_direction(direction)
    @distance = distance
  end

  def get_direction(dir)
    dirs = {"L" => :left, "R" => :right, "U" => :up, "D" => :down }
    dirs[dir]
  end

  def to_s
    "#{direction}: #{distance}"
  end
end

class Spot
  attr_accessor :x, :y, :start, :head, :one, :two, :three, :four, :five, :six, :seven, :eight, :tail, :visitor, :visited

  def initialize(x, y)
    @x = x
    @y = y
    @visited = false
  end

  def set_visitor(xfor, to)
    if xfor == :tail
      @visited = true
    end
    if !to.nil?
      case xfor
      when :head
        @head = to
      when :one
        @one = to
      when :two
        @two = to
      when :three
        @three = to
      when :four
        @four = to
      when :five
        @five = to
      when :six
        @six = to
      when :seven
        @seven = to
      when :eight
        @eight = to
      when :tail
        @tail = to
        @visited = true
      when :start
        @start = to
      end
    else
      @one, @two, @three, @four, @five, @six, @seven, @eight, @head, @tail , @start = false
    end
  end

  def visitor
    return "H" if @head
    return "1" if @one
    return "2" if @two
    return "3" if @three
    return "4" if @four
    return "5" if @five
    return "6" if @six
    return "7" if @seven
    return "8" if @eight
    return "T" if @tail
    return "S" if @start

    nil
  end

  def to_s
    "Spot | x: #{x} y: #{y} | visitor: #{visitor}"
  end
end

class Knot
  attr_accessor :x, :y, :position, :follower
  def initialize(x, y, position)
    @x = x
    @y = y
    @position = position
  end

  def set_follower(node)
    @follower = node
  end

  def set_x_y(x, y)
    @x = x
    @y = y
  end

  def to_s
    "Knot | x: #{x} | y: #{y} | position: #{position}"
  end
end

def import(input)
  moves = []
  input.each do |raw_move|
    move = raw_move.chomp.split()
    moves << Move.new(move[0], move[1].to_i)
  end
  moves
end

def create_grid(moves)
  moves.each do |move|
    move.distance.times do
      move_head(move.direction)
      k = 0
      9.times do
        move_knot(@knots[k], @knots[k].follower)
        k += 1
      end
    end
  end
end

def reset_state(position, follower)
  node = @grid[follower.y][follower.x]
  set_visitor(follower, false, position)
end

def set_visitor(knot, to, xfor = nil)
  node = @grid[knot.y][knot.x]
  node.set_visitor(xfor, to)
end

def move_head(dir)
  set_visitor(@head, false, :head)
  x = @head.x
  y = @head.y
  case dir
  when :right
    if @grid[y][x+1].nil?
      add_right_column
    end
    @head.set_x_y(x + 1, y)
  when :left
    if x == 0
      add_left_column
      x += 1
    end
    @head.set_x_y(x - 1, y)
  when :up
    add_top_row if @grid[y+1].nil?
    @head.set_x_y(x, y + 1)
  when :down
    if y == 0
      add_bottom_row
      y += 1
    end
    @head.set_x_y(x, y - 1)
  else
    puts "I should be moving but I'm not"
  end
  set_visitor(@head, true, :head)
end

# def move_knot(leader, follower)
#   tx = follower.x
#   ty = follower.y
#   hx = leader.x
#   hy = leader.y
#   tmhx = tx - hx
#   tmhy = ty - hy
#   if tmhx.abs > 1 || tmhy.abs > 1
#     if tmhx.abs > 1
#       tx = hx + (tmhx / 2)
#       ty = hy
#     elsif tmhy.abs > 1
#       ty = hy + (tmhy / 2)
#       tx = hx
#     end
#     reset_state(follower.position, follower)
#     follower.set_x_y(tx, ty)
#     set_visitor(follower, true, follower.position)
#   end
# end

def move_knot(leader, follower)
  tx = follower.x
  ty = follower.y
  hx = leader.x
  hy = leader.y
  tmhx = tx - hx
  tmhy = ty - hy
  if tmhx.abs > 1 || tmhy.abs > 1
    tx -= sign(tmhx)
    ty -= sign(tmhy)
    reset_state(follower.position, follower)
    follower.set_x_y(tx, ty)
    set_visitor(follower, true, follower.position)
  end
end

def sign(x)
  return 0 if x.zero?
  x / x.abs
end

def add_top_row
  @grid[@height] = []
  columns = @width - 1
  @width.times do
    @grid[@height][columns] = Spot.new(columns, @height)
    columns -= 1
  end
  @height += 1
end

def add_bottom_row
  @knots.each do |knot|
    knot.y += 1
  end
  @start.y += 1
  @grid.unshift(nil)
  @grid[0] = []
  columns = @width - 1
  @width.times do
    @grid[0][columns] = Spot.new(columns, 0)
    columns -= 1
  end
  @height += 1
  @grid.each_with_index do |row, i|
    next if i.zero?
    row.each do |spot|
      unless spot.nil?
        spot.y +=1
      end
    end
  end
end

def add_right_column
  @grid.each_with_index do |row, i|
    row[@width] = Spot.new(@width, i)
  end
  @width += 1
end

def add_left_column
  @knots.each do |knot|
    knot.x += 1
  end
  @start.x += 1
  @grid.each_with_index do |row, i|
    row.unshift(Spot.new(0, i))
  end
  @width += 1
  @grid.each do |row|
    row.each do |spot|
      spot.x +=1
    end
  end
end

def print_grid
  h = @height - 1
  @height.times do
    row = @grid[h]
    w = 0
    @width.times do
      if row.nil?
        print "."
      else
        dot = row[w]
        if dot.nil?
          print "n"
        elsif dot.visitor != nil
          print dot.visitor
        elsif dot.visited
          print "#"
        else
          print "."
        end
      end
      w += 1
    end
    puts
    h -= 1
  end
  puts
end

def count_visited
  num_visited = 0
  @grid.each do |row|
    row.each do |node|
      num_visited += 1 if node.visited
    end
  end
  puts "Number visited: #{num_visited}"
end

def initialize_grid
  @grid = []
  h = @height - 1
  @height.times do
    @grid[h] = []
    w = 0
    @width.times do
      @grid[h][w] = Spot.new(w, h)
      w += 1
    end
    h -= 1
  end
end

def create_knots
  @knots = []
  @knots << @head
  [:one, :two, :three, :four, :five, :six, :seven, :eight].each do |knot|
    @knots << Knot.new(0, 0, knot)
  end
  @knots << @tail
  @knots.each_with_index do |knot, k|
    unless k == 9
      knot.set_follower(@knots[k + 1])
    end
  end
end

input = File.open("advent9data.txt")
moves = import(input)
@start = Knot.new(0, 0, :start)
@head = Knot.new(0, 0, :head)
@tail = Knot.new(0, 0, :tail)
create_knots
@height = 1
@width = 1
initialize_grid
set_visitor(@start, true, :start)
@knots.each do |knot|
  set_visitor(knot, true, knot.position)
end

create_grid(moves)
# print_grid
count_visited
