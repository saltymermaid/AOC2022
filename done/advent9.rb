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
  attr_accessor :x, :y, :visitor, :visited

  def initialize(visitor = nil)
    @visitor = visitor
    @visited = false
  end

  def set_visitor(state)
    @visitor = state
    @visited = true if state == :tail
  end

  def to_s
    "Spot | x: #{x} y: #{y} | visitor: #{visitor}"
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
    puts move
    move.distance.times do
      move_head(move.direction)
      move_tail
      # print_grid
    end
  end
end

def move_head(dir)
  @head.set_visitor(nil)
  x = @head.x
  y = @head.y
  case dir
  when :right
    if @grid[y][x+1].nil?
      @grid[y][x+1] = Spot.new(:head)
      @width = [@width, x+2].max
    end
    add_right_column if x == @width
    @head = @grid[y][x+1]
    @head.x = x + 1
    @head.y = y
    @head.visitor = :head
  when :left
    if x == 0
      add_left_column
      x += 1
    end
    if @grid[y][x-1].nil?
      @grid[y][x-1] = Spot.new(:head)
    end
    @head = @grid[y][x-1]
    @head.x = x - 1
    @head.y = y
    @head.visitor = :head
  when :up
    add_top_row if @grid[y+1].nil?
    if @grid[y+1][x].nil?
      @grid[y+1][x] = Spot.new(:head)
    end
    @head = @grid[y+1][x]
    @head.y = y + 1
    @head.x = x
    @head.visitor = :head
  when :down
    if y == 0
      add_bottom_row
      y += 1
    end
    @grid[y-1] ||= []
    @grid[y-1][x] ||= Spot.new(:head)
    @head = @grid[y-1][x]
    @head.y = y - 1
    @head.x = x
    @head.visitor = :head
  else
    puts "I should be moving but I'm not"
  end
end

def move_tail
  @tail.set_visitor(nil)
  tx = @tail.x
  ty = @tail.y
  hx = @head.x
  hy = @head.y
  tmhx = tx - hx
  tmhy = ty - hy
  if tmhx.abs > 1
    tx = hx + (tmhx / 2)
    ty = hy
  elsif tmhy.abs > 1
    ty = hy + (tmhy / 2)
    tx = hx
  end
  @tail = @grid[ty][tx]
  @tail.set_visitor(:tail)
end

def add_top_row
  @grid[@height] = []
  @height += 1
end

def add_bottom_row
  @grid.unshift(nil)
  @height += 1
  @grid.each do |row|
    next if row.nil?
    row.each do |spot|
      unless spot.nil?
        spot.y +=1
      end
    end
  end
end

def add_right_column
  @width += 1
end

def add_left_column
  @grid.each do |row|
    row.unshift(nil) unless row.nil?
  end
  @width += 1
  @grid.each do |row|
    row.each do |spot|
      unless spot.nil?
        spot.x +=1
      end
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
          print "."
        elsif dot.visitor == :head
          print "H"
        elsif dot.visitor == :tail
          print "T"
        elsif dot.visitor == :start
          print "s"
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
    next if row.nil?
    row.each do |node|
      next if node.nil?
      num_visited += 1 if node.visited
    end
  end
  puts "Number visited: #{num_visited}"
end


input = File.open("advent9data.txt")
moves = import(input)
@start = Spot.new
@start.x = 0
@start.y = 0
@head = @start
@tail = @start
@head.set_visitor(:head)
@tail.visited = true
@height = 1
@width = 1
@grid = []
@grid[0] = []
@grid[0][0] = @start
create_grid(moves)
print_grid
count_visited
