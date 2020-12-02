require 'set'

filename = '1-input.txt'

file = File.new("#{__dir__}/#{filename}")
nums = file.readlines.map(&:to_i)
file.close

numset = Set.new(nums)
first = nums.find do |num|
  numset.include?(2020 - num)
end

puts 'Part 1'
puts first * (2020 - first)
puts ''

nums.sort!
first_index = 0
second_index = 1
while(!numset.include?(2020 - nums[first_index] - nums[second_index])) do
  second_index += 1
  if nums[second_index].nil? || (nums[first_index] + nums[second_index] >= 2020)
    first_index += 1
    second_index = first_index + 1
  end
end
first = nums[first_index]
second = nums[second_index]
third = 2020 - first - second

puts 'Part 2'
puts first * second * third
