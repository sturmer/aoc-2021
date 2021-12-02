module Day2
  FP = '../input_files/input.day2.txt'

  module Part1
    x = 0
    depth = 0
    File.readlines(FP).each do |line|
      res = line.partition(' ')
      cmd = res.first
      qty = Integer(res[-1])
      if cmd == 'forward'
        x += qty
      elsif cmd == 'down'
        depth += qty
      elsif cmd == 'up'
        depth -= qty
      end
    end

    # 1694130
    puts "res: #{depth * x}"
  end

  module Part2
    x = 0
    depth = 0
    aim = 0
    File.readlines(FP).each do |line|
      res = line.partition(' ')
      cmd = res.first
      qty = Integer(res[-1])
      if cmd == 'forward'
        x += qty
        depth += aim * qty
      elsif cmd == 'down'
        aim += qty
      elsif cmd == 'up'
        aim -= qty
      end
    end

    # 1698850445
    puts "res: #{depth * x}"
  end
end

