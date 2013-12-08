
def load_file(path)
  $lines = []
  file = File.open(path, 'r')
  while line = file.gets
    $lines << line
  end
end

def print_all
  $lines.each do |line|
    p line
  end
  puts
end

load_file 'examples/example1.sphr'

# tokenize
$lines.each_with_index do |line, i|
  line.strip!
  $lines[i] = line.split ' '
end

print_all
