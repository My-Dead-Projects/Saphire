
require_relative 'definition'

# load file
$lines = []

file = File.open('../examples/example1.sphr', 'r')
while line = file.gets
  $lines << line
end

$main = Def.new(:class, "Main")
$main.start = 0
$main.end = $lines.length-1

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

def parse
  stack = [$main]

  $lines.each_with_index do |line, i|
    if line[0] == 'class'
      type = :class
    elsif line[0] == 'def'
      type = :method
    elsif line[0] == 'end'
      stack.pop.end = i
    else
      stack.last.code << line
    end
    if type
      definition = Def.new(type, line[1])
      definition.start = i
      stack.last.hash[line[1]] = definition
      stack.push definition
    end
  end
end

parse

def print_def(d, indent=0, indent_style='|  ')
  puts "#{indent_style*indent}#{d.type.to_s} #{d.identifier}:#{d.start+1}"
  d.code.each do |line|
    puts "#{indent_style*(indent+1)}#{line.inspect}" unless line.size == 0
  end
  d.hash.each do |key, value|
    print_def(value, indent+1, indent_style)
  end
  puts "#{indent_style*indent}end:#{d.end+1}"
end

print_def $main
