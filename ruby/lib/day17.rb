require 'perfect-shape'
include PerfectShape

MAX_LOOPS = 100_000

module Day17

  class Point
    attr_accessor :x, :y

    def self.[](x, y)
      Point.new(x, y)
    end

    def ==(p)
      @x == p.x && @y == p.y
    end

    def to_s
      "(#{@x}, #{@y})"
    end

    private

    def initialize(x, y)
      @x = x
      @y = y
    end

  end

  class Part1
    attr_accessor :target, :tx1, :tx2, :ty1, :ty2

    def initialize(tx1, tx2, ty1, ty2)
      @tx1, @tx2 = [tx1, tx2].minmax

      # Assumes they're on the negative semi-axis
      raise ArgumentError if ty1 > 0 || ty2 > 0
      @ty2, @ty1 = [ty1, ty2].minmax

      width = @tx2 - @tx1
      height = @ty1 - @ty2

      @target = Rectangle.new(x: @tx1, y: @ty2, width: width, height: height)
    end

    def solve
      max_y = -10_000_000
      best_v = nil
      (0..10_000_000).each do |x|
        catch :try_next_x do
          (0..20_000).each do |y|
            # puts "trying #{Point[x, y]}"
            y, v0 = verify_solution(Point[x, y])

            # Once we overshoot, increasing y doesn't help anymore
            throw :try_next_x if y.nil?

            if y > max_y
              max_y = y
              best_v = v0
            end
          end
        end
      end

      [max_y, best_v]
    end

    def self.next_v(v)
      next_vx = if v.x > 0
                  v.x - 1
                elsif v.x < 0
                  v.x + 1
                else
                  v.x
                end

      Point[next_vx, v.y - 1]
    end

    def self.next_pos(p, v)
      Point[p.x + v.x, p.y + v.y]
    end

    # Distance between point and center of rect
    def dist(p)
      center = Point[@target.center_x, @target.center_y]
      Math.sqrt((p.x - center.x) ** 2 + (p.y - center.y) ** 2)
    end

    # pi is a Point
    def escaping?(p)
      p.x > @tx2 || p.y < @ty2
    end

    # Return true if it's a valid solution
    def verify_solution(v)
      p = Point[0, 0]

      next_v = v
      count = 0
      max_y = -10000
      while count < MAX_LOOPS
        # return nil if escaping?(p)
        if escaping?(p)
          puts "escaped!"
          return nil
        end

        # puts "#{p} contained in target" if @target.contain?([p.x, p.y])
        return [max_y, v] if @target.contain?([p.x, p.y])

        p = Part1.next_pos(p, next_v)
        next_v = Part1.next_v(next_v)

        max_y = [p.y, max_y].max

        # puts("count: #{count}, next_p: #{p}, next_v: #{next_v}")
        count += 1
      end

      puts "Try more loops!"
      nil
    end
  end
end

# max_y, v0 = Day17::Part1.new(20, 30, -10, -5).solve
# max_y, v0 = Day17::Part1.new(96, 125, -144, -98).solve
# puts "Max y is: #{max_y} with starting velocity #{v0}"

# x=96..125, y=-144..-98 -> 1176 is too low

pb = Day17::Part1.new(96, 125, -144, -98)

# Didn't find an algorithm, but tried with verify_solution and coordinates that seemed to give better and better results.
# The best is for v0 = 14, 142, that gives max y 10296.
puts pb.verify_solution(Day17::Point[15, 144])

# puts Day17::Part2.solve


