
def load_file(path)
  $lines = []
  file = File.open(path, 'r')
  while line = file.gets
    $lines << line
  end
end

def print_file
  $lines.each_with_index do |line, i|
    print i+1, ' '; puts line
  end
end

def find_all(symbol)
  result = []
  $lines.each_with_index do |line, i|
    if (symbol == :methods and line[0] == 'def')\
    or (symbol == :classes and line[0] == 'class')
      result << i
    end
  end
  result
end

load_file 'examples/example1.sphr'

$lines.each_with_index do |line, i|
  line.strip!
  $lines[i] = line.split ' '
end

p $lines

methods = find_all(:methods)

methods.each_with_index do |e, i|
  methods[i] = e+1
end

classes = find_all(:classes)

classes.each_with_index do |e, i|
  classes[i] = e+1
end

puts 'methods:', methods

puts 'classes:', classes
