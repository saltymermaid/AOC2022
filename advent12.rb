class Node
  attr_accessor :x, :y, :height, :visited, :neighbors
  def initialize(x, y, height)
    @x = x
    @y = y
    if height == "S"
      @height = "a"
    elsif height == "E"
      @height = "z"
    else
      @height = height
    end
    @neighbors = []
    @visited = false
  end

  def set_neighbors(nodes)
    nodes.each do |n|
      @neighbors << n
    end
  end

  def not_too_tall?(other_node)
    return other_node.height.ord - self.height.ord <= 1
  end

  def print_immediate_neighbors
    @neighbors.each do |n|
      puts "#{n.x}, #{n.y}"
    end
    puts
  end

  def to_s
    "NODE | x: #{x} y: #{y} | h: #{height}"
  end
end

def make_grid(input)
  input.each_with_index do |row, y|
    @grid[y] = []
    spots = row.chomp.split('')
    spots.each_with_index do |spot, x|
      if spot == "S"
        @start = Node.new(x, y, spot)
        @grid[y] << @start
      elsif spot == "E"
        @end = Node.new(x, y, spot)
        @grid[y] << @end
      else
        @grid[y] << Node.new(x, y, spot)
      end
    end
  end
end

def add_neighbors
  @grid.each_with_index do |row, y|
    row.each_with_index do |spot, x|
      neighbors = []
      neighbors << add_top_neighbor(spot) unless y == 0
      neighbors << add_bottom_neighbor(spot) unless y == @grid.length - 1
      neighbors << add_left_neighbor(spot) unless x == 0
      neighbors << add_right_neighbor(spot) unless x == row.length - 1
      spot.set_neighbors(neighbors)
    end
  end
end

def add_top_neighbor(node)
  @grid[node.y - 1][node.x]
end

def add_bottom_neighbor(node)
  @grid[node.y + 1][node.x]
end

def add_left_neighbor(node)
  @grid[node.y][node.x - 1]
end

def add_right_neighbor(node)
  @grid[node.y][node.x + 1]
end

def print_grid
  @grid.each do |row|
    row.each do |spot|
      if spot == @start
        print "S"
      elsif spot == @end
        print "E"
      else
        print spot.height
      end
    end
    puts
  end
end

def find_path
  current = @start
  
end

def main
  input = File.open("testdata.txt")
  @grid = []
  make_grid(input)
  add_neighbors
  print_grid
end

main