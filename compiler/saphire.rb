
require_relative 'definition'

# load file
$lines = []
$main = Def.new(:class, "Main")
file = File.open('../examples/example1.sphr', 'r')
while line = file.gets
  $lines << line
end

# tokenize
$lines.each_with_index do |line, i|
  line.strip!
  $lines[i] = line.split ' '
end

def print_all
  $lines.each do |line|
    p line
  end
  puts
end

$lines.each_with_index do |line, i|
  if line[0] == 'class'
    type = :class
  elsif line[0] == 'def'
    type = :method
  else
    type = nil
  end
  if type
    $main.hash[line[1]] = Def.new(type, line[1])
    $main.hash[line[1]].start = i
  end
end

p $main
