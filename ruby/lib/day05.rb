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

  def self.points_in_segment(c1, c2)
    Range.new(*([c1, c2].minmax.sort!)).to_a
  end

  def self.build_matrix(coords)
    max_x = max_y = 0
    coords.map do |x1, y1, x2, y2|
      max_x = [max_x, [x1, x2].max].max
      max_y = [max_y, [y1, y2].max].max
    end

    Matrix.zero(max_x + 1, max_y + 1)
  end

  module Part1
    def self.solve
      all_endpoints = Day5.parse_input
      chart = Day5.build_matrix all_endpoints

      all_endpoints.each do |x1, y1, x2, y2|
        next if x1 != x2 && y1 != y2

        if x1 == x2
          Day5.points_in_segment(y1, y2).map { |y| [x1, y] }
        else
          Day5.points_in_segment(x1, x2).map { |x| [x, y1] }
        end
          .each { |coords| chart[*coords] += 1 }
      end

      chart.reduce do |cnt, u|
        if u >= 2
          cnt + 1
        else
          cnt
        end
      end
    end
  end

  module Part2
    def self.points_in_segment(x1, y1, x2, y2)
      if x1 == x2
        Day5.points_in_segment(y1, y2).map { |y| [x1, y] }
      elsif y1 == y2
        Day5.points_in_segment(x1, x2).map { |x| [x, y1] }
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
      all_endpoints = Day5.parse_input
      chart = Day5.build_matrix all_endpoints

      all_endpoints.each do |x1, y1, x2, y2|
        Day5::Part2.points_in_segment(x1, y1, x2, y2)
          .each { |coords| chart[*coords] += 1 }
      end

      chart.reduce do |cnt, u|
        if u >= 2
          cnt + 1
        else
          cnt
        end
      end
    end
  end
end

