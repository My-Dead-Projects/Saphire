
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
      n_line = []
      line.each_with_index do |token, j|
        tok = token.split /\./
        t = tok.shift
        if (t =~ /[+\-=\/]/) == 0
          n_line << Operator.new(t)
        elsif (t =~ /@@/) == 0
          t = t[0][2..-1]
          n_line << ClassVariable.new(t)
        elsif (t =~ /@/) == 0
          t[0] = t[0][1..-1]
          n_line << InstanceVariable.new(t)
        elsif (t =~ /[a-zA-Z_]\w*/) == 0
          n_line << ScopedVariable.new(t)
        elsif (t =~ /\d+/) == 0
          n_line << NumericLiteral.new(t)
        elsif (t =~ /'/) == 0
          n_line << StringLiteral.new(t[1..-2])
        end
        tok.each do |m|
          n_line << MethodCall.new(m)
        end
        line = n_line
      end
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

def print_def(d, line_numbers=false, indent=0, indent_style='|  ')
  puts "#{indent_style*indent}"
  print "#{indent_style*indent}#{d.type.to_s} #{d.id}"
  print ":#{d.start+1}" if line_numbers
  puts
  d.code.each do |line|
    unless line.size == 0
      print "#{indent_style*(indent+1)}"
      line.each do |token|
        print "#{token.inspect} "
      end
      puts
    end
  end
  d.hash.each do |key, value|
    print_def(value, line_numbers, indent+1, indent_style)
  end
  print "#{indent_style*indent}end"
  print ":#{d.end+1}" if line_numbers
  puts
end

def compile(c, f, pad=0)
  case c.type
    when :class
      f.puts "#{' '*pad}class #{c.id} : id {"
      c.hash.each do |_, e|
        compile(e, f, pad+2)
      end
      f.puts "#{' '*pad}};"
    when :method
      f.puts "#{' '*pad}id #{c.id}(Array args) {"
      f.puts "#{' '*(pad+2)}"
      f.puts "#{' '*pad}}"
  end
end

compile $main, STDOUT

File.open('../examples/example1.cpp', 'w') do |file|
  compile $main, file
end
