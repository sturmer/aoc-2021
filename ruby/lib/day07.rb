require 'matrix'

module Day7
  # FP = '../input_files/test.day7.txt'
  FP = '../input_files/input.day7.txt'

  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  class Common
    def self.parse_input
      LINES.map do |line|
        line.split(',').map { |num| Integer(num) }
      end
    end

    def self.compute_consumption(hposes, i)
      fuels = []

      hposes.each_with_index do |pos, cur|
        next if cur == i

        fuel = self.compute_cost(pos, hposes[i])
        fuels << fuel unless fuel.nil?
      end

      fuels.reduce(:+)
    end

    def self.solve
      hposes = parse_input.flatten

      min_fuel = 10000000000
      hposes.each_with_index do |hpos, i|
        fuel = compute_consumption(hposes, i)
        min_fuel = [min_fuel, fuel].min
      end

      min_fuel
    end
  end

  class Part1 < Common
    def self.compute_cost(a, b)
      (a - b).abs
    end

  end

  class Part2 < Common
    def self.compute_cost(a, b)
      x, y = [a, b].minmax
      (1..(y - x)).reduce(:+)
    end
  end
end


