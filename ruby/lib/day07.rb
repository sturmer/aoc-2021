require 'matrix'

module Day7
  # FP = '../input_files/test.day7.txt'
  FP = '../input_files/input.day7.txt'

  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  class Common
    attr_reader :horizontal_positions

    def initialize
      @horizontal_positions = Common.parse_input.flatten
    end

    def self.parse_input
      LINES.map do |line|
        line.split(',').map { |num| Integer(num) }
      end
    end

    def compute_consumption(i)
      fuels = []

      @horizontal_positions.each_with_index do |pos, cur|
        next if cur == i

        fuel = self.compute_cost(pos, @horizontal_positions[i])
        fuels << fuel unless fuel.nil?
      end

      fuels.reduce(:+)
    end

    def solve
      min_fuel = 10000000000
      @horizontal_positions.each_with_index do |hpos, i|
        fuel = compute_consumption(i)
        min_fuel = [min_fuel, fuel].min
      end

      min_fuel
    end
  end

  class Part1 < Common
    def compute_cost(a, b)
      (a - b).abs
    end

  end

  class Part2 < Common
    def compute_cost(a, b)
      x, y = [a, b].minmax
      (1..(y - x)).reduce(:+)
    end
  end
end


