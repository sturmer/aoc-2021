require 'matrix'

module Day13
  # FILE_PATH = '../input_files/test.day13.txt'
  FILE_PATH = '../input_files/input.day13.txt'
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

puts Day13::Part1.new.solve
# puts Day13::Part2.solve


