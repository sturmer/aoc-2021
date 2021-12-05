require 'matrix'

module Day5
  # FP = '../input_files/test.day5.txt'
  FP = '../input_files/input.day5.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  def self.parse_input
    LINES.map do |line|
      line.split('-> ')
        .map { |coords| coords.split(',') }
        .flatten!
        .map { |num| Integer(num) }
    end
  end

  def self.get_range(c1, c2)
    if c1 > c2
      (c2..c1).to_a
    else
      (c1..c2).to_a
    end
  end

  module Part1
    def self.solve
      coords = Day5.parse_input

      # FIXME(gianluca.ciccarelli): so inefficient
      ascissas = []
      ordinates = []
      coords.map do |c|
        x1, y1, x2, y2 = c
        ascissas << x1 << x2
        ordinates << y1 << y2
      end
      max_x = ascissas.max
      max_y = ordinates.max

      rows = max_x + 1
      cols = max_y + 1
      chart = Matrix.build(rows, cols) { |row, col| 0 }

      coords.each do |pl|
        x1, y1, x2, y2 = pl

        next if x1 != x2 && y1 != y2

        range = if x1 == x2
                  Day5.get_range(y1, y2).map { |y| [x1, y] }
                else
                  Day5.get_range(x1, x2).map { |x| [x, y1] }
                end

        range.each do |coords|
          x, y = coords
          chart[x, y] += 1
        end
      end

      count = 0
      chart.each do |u|
        count += 1 if u >= 2
      end

      count
    end
  end

  module Part2
    def self.get_range(x1, y1, x2, y2)
      if x1 == x2
        Day5.get_range(y1, y2).map { |y| [x1, y] }
      elsif y1 == y2
        Day5.get_range(x1, x2).map { |x| [x, y1] }
      else
        if x1 < x2
          if y1 < y2
            (x1..x2).zip(y1..y2)
          else
            (y2..y1)
              .zip((x1..x2).to_a.reverse)
              .map { |c| [c[1], c[0]] }
          end
        else
          if y1 < y2
            (x2..x1).to_a.reverse.zip(y1..y2)
          else
            (y2..y1)
              .zip(x2..x1)
              .map { |c| [c[1], c[0]] }
          end
        end
      end
    end

    def self.solve
      coords = Day5.parse_input

      # FIXME(gianluca.ciccarelli): so inefficient
      ascissas = []
      ordinates = []
      coords.map do |c|
        x1, y1, x2, y2 = c
        ascissas << x1 << x2
        ordinates << y1 << y2
      end
      max_x = ascissas.max
      max_y = ordinates.max

      rows = max_x + 1
      cols = max_y + 1
      chart = Matrix.build(rows, cols) { |row, col| 0 }

      coords.each do |pl|
        x1, y1, x2, y2 = pl

        range = Day5::Part2.get_range(x1, y1, x2, y2)

        range.each do |coords|
          x, y = coords

          chart[x, y] += 1
        end
      end

      count = 0
      chart.each do |u|
        count += 1 if u >= 2
      end

      count
    end
  end
end
