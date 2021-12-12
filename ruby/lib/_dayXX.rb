require 'matrix'

module DayXX
  # FP = '../input_files/test.day12.txt'
  FP = '../input_files/input.day12.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  def self.parse_input
    LINES
      .map { |line| line.split('') }
  end

  class Part1
    attr_accessor :flashes_count

    def initialize
      @flashes_count = 0
    end

    def solve

    end

  end
end

puts Day12::Part1.new.solve
# puts Day12::Part2.solve


