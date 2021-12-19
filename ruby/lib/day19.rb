require 'matrix'

module Day19
  FILE_PATH = '../input_files/test.day19.txt'
  # FILE_PATH = '../input_files/input.day19.txt'
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

    def rotate_point(v)
      # It's half of the permutations of components and sign change, but which half?
      # [26] pry(main)> [5, 6, -4].permutation(3) {|p| p p}
      #   [5, 6, -4]
      #   [5, -4, 6]
      #   [6, 5, -4]
      #   [6, -4, 5]
      #   [-4, 5, 6]
      #   [-4, 6, 5]
      # The sign can change in 8 ways (2**3):
      #   [5, 6, -4]
      #   [5, -6, -4]
      #   [-5, -6, -4]
      #   [-5, -6, 4]
      #   [-5, 6, 4]
      #   [5, 6, 4]
      #   [5, -6, 4]
      #   [-5, 6, -4]
      # ???
      #
      # Once I face a direction, I can rotate in multiple of 90 deg only in 4 ways.
    end

    def solve

    end

  end


end

puts Day19::Part1.new.solve


