require 'matrix'

module Day6
  # FP = '../input_files/test.day6.txt'
  FP = '../input_files/input.day6.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  def self.parse_input
    LINES.map do |line|
      line.split(',')
        .map { |num| Integer(num) }
    end
  end

  module Part1
    def self.solve
      ages = Day6.parse_input.flatten
      next_ages = ages

      (1..80).each do |day|
        cur_ages = next_ages
        next_ages = []

        cur_ages.each do |age|
          if age == 0
            next_ages << 8 << 6
          else
            next_ages << (age - 1)
          end
        end
      end

      next_ages.length
    end
  end

  module Part2
    def self.solve
      ages = Day6.parse_input.flatten
      next_ages_map = {}
      (0..8).map { |days| next_ages_map[days] = 0 }

      ages.each do |age|
        next_ages_map[age] += 1
      end

      next_ages = next_ages_map.values

      (1..256).each do |day|
        birthing_count = next_ages.shift

        next_ages[6] += birthing_count
        next_ages << birthing_count
      end

      next_ages.reduce(:+)
    end
  end
end


