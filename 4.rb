filename = '4-input.txt'
file = File.new("#{__dir__}/#{filename}")
data = file.read
file.close

passports = data.split("\n\n").map do |passport|
  passport.split(/\s+/).sort.each_with_object({}) do |raw, h|
    kv = raw.split(':')
    h[kv[0]] = kv[1] unless kv[0] == 'cid'
  end
end

required = %w(
  byr
  iyr
  eyr
  hgt
  hcl
  ecl
  pid
)

valid_count = passports.select do |passport|
  required.all? do |key|
    passport.key?(key)
  end
end.count

puts 'Part 1'
puts valid_count

valid_count = passports.select do |passport|
  next unless passport['byr'].to_i.between?(1920, 2002)
  next unless passport['iyr'].to_i.between?(2010, 2020)
  next unless passport['eyr'].to_i.between?(2020, 2030)

  next unless passport['hgt']
  hgt = passport['hgt']
  hgt_num = hgt[/\d+/].to_i
  if hgt.end_with?('cm')
    next unless hgt_num.between?(150, 193)
  else
    next unless hgt.end_with?('in')
    next unless hgt_num.between?(59, 76)
  end

  next unless passport['hcl']&.match?(/^#[0-9a-f]{6}$/)
  next unless %w(amb blu brn gry grn hzl oth).include?(passport['ecl'])
  next unless passport['pid']&.match?(/^\d{9}$/)

  puts passport

  true
end.count

puts 'Part 2'
puts valid_count


