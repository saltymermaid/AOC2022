@forest = File.open("advent8data.txt")
@grid = []

class Tree
  attr_accessor :height, :left, :right, :top, :bottom

  def initialize(height)
    @height = height
  end

  def is_visible
    return left || right || top || bottom
  end

  def is_blocked?(node)
    return height <= node.height
  end
end

def calc_left_vis(x, y)
  tree = @grid[y][x]
  row = @grid[y]
  pos = x - 1
  (x).times do
    return false if tree.is_blocked?(row[pos])
    pos -= 1
  end
  return true
end

def calc_right_vis(x, y)
  tree = @grid[y][x]
  row = @grid[y]
  pos = x + 1
  (row.length - pos).times do
    return false if tree.is_blocked?(row[pos])
    pos += 1
  end
  return true
end

def calc_top_vis(x, y)
  tree = @grid[y][x]
  pos = y - 1
  (y).times do
    return false if tree.is_blocked?(@grid[pos][x])
    pos -= 1
  end
  return true
end

def calc_bottom_vis(x, y)
  tree = @grid[y][x]
  pos = y + 1
  (@grid.length - y - 1).times do
    return false if tree.is_blocked?(@grid[pos][x])
    pos += 1
  end
  return true
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
      if tree.is_visible
        print "T"
      else
        print "*"
      end
    end
    puts
  end
end

def print_some_trees
  @grid[94].each_with_index do |tree, x|
    print "#{tree.height} | #{tree.bottom} | "
    print @grid[95][x].height
    print @grid[96][x].height
    print @grid[97][x].height
    print @grid[98][x].height
    puts
  end
end

def calc_visible_trees
  visible_trees = 0
  @grid.each do |row|
    row.each do |tree|
     visible_trees += 1 if tree.is_visible
    end
  end
  visible_trees
end

create_grid
calc_vis
print_grid
# print_some_trees
puts calc_visible_trees


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