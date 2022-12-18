@forest = File.open("advent8data.txt")
@grid = []

class Tree
  attr_accessor :height, :left, :right, :top, :bottom, :scenic_score

  def initialize(height)
    @height = height
  end

  def is_blocked?(node)
    return height <= node.height
  end

  def calc_scenic_score
    left * right * top * bottom
  end
end

def calc_left_vis(x, y)
  tree = @grid[y][x]
  row = @grid[y]
  pos = x - 1
  see_trees = 0
  (x).times do
    see_trees += 1
    return see_trees if tree.is_blocked?(row[pos])
    pos -= 1
  end
  see_trees
end

def calc_right_vis(x, y)
  tree = @grid[y][x]
  row = @grid[y]
  pos = x + 1
  see_trees = 0
  (row.length - pos).times do
    see_trees += 1
    return see_trees if tree.is_blocked?(row[pos])
    pos += 1
  end
  see_trees
end

def calc_top_vis(x, y)
  tree = @grid[y][x]
  pos = y - 1
  see_trees = 0
  (y).times do
    see_trees += 1
    return see_trees if tree.is_blocked?(@grid[pos][x])
    pos -= 1
  end
  see_trees
end

def calc_bottom_vis(x, y)
  tree = @grid[y][x]
  pos = y + 1
  see_trees = 0
  (@grid.length - y - 1).times do
    see_trees += 1
    return see_trees if tree.is_blocked?(@grid[pos][x])
    pos += 1
  end
  see_trees
end

def create_grid
  @forest.each_with_index do |row, y|
    @grid[y] = []
    trees = row.chomp.split('')
    trees.each_with_index do |tree, x|
      @grid[y] << Tree.new(tree.to_i)
    end
  end
end

def calc_vis
  @grid.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      tree.left = calc_left_vis(x, y)
      tree.right = calc_right_vis(x, y)
      tree.top = calc_top_vis(x, y)
      tree.bottom = calc_bottom_vis(x, y)
    end
  end
end

def print_grid
  @grid.each do |row|
    row.each do |tree|
      print tree.scenic_score
    end
    puts
  end
end

def print_some_trees
  @grid.each do |row|
    row.each do |tree|
      puts "#{tree.height} | #{tree.left} | #{tree.right} | #{tree.top} | #{tree.bottom} | #{tree.scenic_score}"
    end
  end
end

def calc_scenic_score
  @grid.each do |row|
    row.each do |tree|
      tree.scenic_score = tree.calc_scenic_score
    end
  end
end

def find_max_scenic_score
  max = 0
  @grid.each do |row|
    row.each do |tree|
      max = [tree.scenic_score, max].max
    end
  end
  max.to_s
end

create_grid
calc_vis
# print_grid
calc_scenic_score
# print_some_trees
puts find_max_scenic_score


# 30373
# 25512
# 65332
# 33549
# 35390

# TTTTT
# TTT*T
# TT*TT
# T*T*T
# TTTTT