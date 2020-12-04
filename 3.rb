filename = '3-input.txt'

file = File.new("#{__dir__}/#{filename}")
lines = file.readlines
file.close

def tree_count(lines, x_delta, y_delta)
  x, y, trees = 0, 0, 0
  rows = lines.size
  cols = lines[0].chomp.size

  while y < rows do
    if lines[y][x % cols] == '#'
      trees += 1
    end

    y += y_delta
    x += x_delta
  end

  trees
end

puts 'Part 1'
puts tree_count(lines, 3, 1)

puts 'Part 2'
puts ([
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2],
  ].map do |x, y|
    tree_count(lines, x, y)
  end.reduce(&:*)
)
