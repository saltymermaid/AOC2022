# commands = File.open("testdata.txt")
commands = File.open("advent7data.txt")
FILE_SIZE_LIMIT = 100_000

class FileDir
  attr_accessor :name, :parent, :children

  def initialize(name, parent = nil)
    @name = name
    @parent = parent
    @children = []
  end

  def add_child(node)
    children << node
  end

  def to_s
    name_to_print = ""
    name_to_print = parent.name if parent
    "- #{name} (dir) -- parent (#{name_to_print}) -- dir size: #{calc_dir_size(self)}"
  end
end

class FileFile
  attr_accessor :name, :size, :dir

  def initialize(name, size, dir)
    @name = name
    @size = size.to_i
    @dir = dir
  end

  def to_s
    "- #{name} (file size: #{size}) -- dir (#{dir.name})"
  end
end

@root = FileDir.new("root")

def print_dirs(node, level = 0)
  level += 1
  puts node
  node.children.each do |child|
    if child.class == FileDir
      print "  "*level
      print_dirs(child, level)
    else
      print "  "*level
      puts child
    end
  end
end

def calc_dir_size(node)
  size = 0
  node.children.each do |child|
    if child.class == FileDir
      size += calc_dir_size(child)
    else
      size += child.size
    end
  end
  size
end

def find_small_dirs(node)
  small_dir_total = 0
  node.children.each do |child|
    if child.class == FileDir
      dir_size = calc_dir_size(child)
      if dir_size <= FILE_SIZE_LIMIT
        small_dir_total += dir_size
      end
      small_dir_total += find_small_dirs(child)
    end
  end
  small_dir_total
end

def parse_input(command)
  com = command.chomp.split(' ')
  if com[0] == "$"
    execute_command(com)
  else
    create_node(com)
  end
end

def execute_command(com)
  if com[1] == "cd"
    change_dir(com[2])
  end
end

def create_node(com)
  if com[0] == "dir"
    @current_node.add_child(FileDir.new(com[1], @current_node))
  else
    @current_node.add_child(FileFile.new(com[1], com[0], @current_node))
  end
end

def change_dir(cd_arg)
  if cd_arg == '/'
    @current_node = @root
  elsif cd_arg == '..'
    @current_node = @current_node.parent
  else
    @current_node = find_node(cd_arg)
  end
end

def find_node(name)
  @current_node.children.each do |child|
    return child if child.name == name
  end
end

@current_node = @root
commands.each do |command|
  parse_input(command)
end

# print_dirs(@root)
# puts calc_dir_size(@root)
puts find_small_dirs(@root)