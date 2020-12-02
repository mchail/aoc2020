filename = '2-passwords.txt'

file = File.new("#{__dir__}/#{filename}")
passwords = file.readlines
file.close

valid = passwords.select do |line|
  min, max, letter, string = line.match(/(\d+)-(\d+)\s(\w):\s(\w+)/).captures
  count = string.split('').group_by(&:itself).transform_values(&:count)[letter] || 0
  count.between?(min.to_i, max.to_i)
end
file.close

puts 'Part 1'
puts valid.count
puts ''

valid = passwords.select do |line|
  p1, p2, letter, string = line.match(/(\d+)-(\d+)\s(\w):\s(\w+)/).captures
  c1 = string[p1.to_i - 1]
  c2 = string[p2.to_i - 1]
  (
    c1 == letter && c2 != letter ||
    c1 != letter && c2 == letter
  )
end

puts 'Part 2'
puts valid.count
