require 'matrix'

class Point
  attr_accessor :x, :y, :z

  def self.[](x, y, z)
    Point.new(x, y, z)
  end

  def ==(p)
    @x == p.x && @y == p.y && @z == p.z
  end

  def to_s
    "(#{@x}, #{@y}, #{@z})"
  end

  private

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end
end

module Day19
  FILE_PATH = '../input_files/test.day19.txt'
  # FILE_PATH = '../input_files/input.day19.txt'
  LINES = File.readlines(FILE_PATH).map { |x| x.chomp("\n") }

  def self.parse_input
    LINES
      .map { |line| line.split('') }
  end

  class Part1

    # p: Point
    def rotate_point(p)
      rotate_around_z(p) +
        rotate_around_y(p) +
        rotate_around_x(p)
    end

    def solve

    end

    private

    def rotate_around_x(p)
      x_rotations = []

      # Z axis "front/back"
      # [y, z, x]
      x_rotations << Point[p.y, p.z, p.x]
      x_rotations << Point[p.y, -p.z, p.x]

      # [-z, y, x]
      x_rotations << Point[-p.z, p.y, p.x]
      x_rotations << Point[p.z, p.y, p.x]

      # [-y, -z, x]
      x_rotations << Point[-p.y, -p.z, p.x]
      x_rotations << Point[-p.y, p.z, p.x]

      # [z, -y, -x]
      x_rotations << Point[-p.z, -p.y, p.x]
      x_rotations << Point[p.z, -p.y, p.x]

      x_rotations
    end

    def rotate_around_z(p)
      z_rotations = []

      # Z axis "up/down"
      # [x, y, z]
      z_rotations << p
      z_rotations << Point[p.x, p.y, -p.z]

      # [-y, x, z]
      z_rotations << Point[-p.y, p.x, p.z]
      z_rotations << Point[-p.y, p.x, -p.z]

      # [-x, -y, z]
      z_rotations << Point[-p.x, -p.y, p.z]
      z_rotations << Point[-p.x, -p.y, -p.z]

      # [y, -x, z]
      z_rotations << Point[p.y, -p.x, p.z]
      z_rotations << Point[p.y, -p.x, -p.z]

      z_rotations
    end

    def rotate_around_y(p)
      y_rotations = []

      # Z axis "right/left"
      # [z, x, y]
      y_rotations << Point[p.z, p.x, p.y]
      y_rotations << Point[-p.z, p.x, p.y]

      # [-x, z, y]
      y_rotations << Point[-p.x, p.z, p.y]
      y_rotations << Point[-p.x, -p.z, p.y]

      # [-z, -x, y]
      y_rotations << Point[-p.z, -p.x, p.y]
      y_rotations << Point[p.z, -p.x, p.y]

      # [x, -z, y]
      y_rotations << Point[p.x, -p.z, p.y]
      y_rotations << Point[p.x, p.z, p.y]

      y_rotations
    end

  end

end

puts Day19::Part1.new.solve


