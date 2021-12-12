require 'matrix'

module DayXX
  # FILE_PATH = '../input_files/test.dayXX.txt'
  FILE_PATH = '../input_files/input.dayXX.txt'
  LINES = File.readlines(FILE_PATH).map { |x| x.chomp("\n") }

  def self.parse_input
    LINES
      .map { |line| line.split('') }
  end

  class Part1
    attr_accessor :attr1

    def initialize
      @attr1 = 0
    end

    def solve

    end

  end

  class Part2
    attr_accessor :attr1

    def initialize
      @attr1 = 0
    end

    def solve

    end

  end
end

puts DayXX::Part1.new.solve
# puts DayXX::Part2.solve


