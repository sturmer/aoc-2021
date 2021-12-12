# Create lib, rspec, and input test file for day ARGV[0]
if ARGV.length < 1
  puts "Usage: ruby gen_day.rb <DAY>"
  exit
end

TEMPLATE_PATH = 'lib/_dayXX.rb'
res = []

File.readlines(TEMPLATE_PATH).each do |line|
  res << line.gsub(/XX/, ARGV[0])
end

File.write("lib/day#{ARGV[0]}.rb", res.join(''))

File.write("../input_files/test.day#{ARGV[0]}.txt", '')

TEMPLATE_TEST_PATH = 'spec/_dayXX_spec.rb'
res = []
File.readlines(TEMPLATE_TEST_PATH).each do |line|
  res << line.gsub(/XX/, ARGV[0])
end

File.write("spec/day#{ARGV[0]}_spec.rb", res.join(''))

