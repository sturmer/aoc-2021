require 'matrix'

module Day9
  # FP = '../input_files/test.day9.txt'
  FP = '../input_files/input.day9.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  def self.parse_input
    LINES
      .map { |line| line.split('').map { |num| { depth: Integer(num), visited: false } } }
  end

  module Part1
    def self.find_low_points(hm)
      low_points = []

      hm.each_with_index do |elem, i, j|
        n = if i - 1 >= 0
              hm[i - 1, j][:depth]
            else
              10
            end

        s = if i + 1 < hm.row_count
              hm[i + 1, j][:depth]
            else
              10
            end

        w = if j - 1 >= 0
              hm[i, j - 1][:depth]
            else
              10
            end

        e = if j + 1 < hm.column_count
              hm[i, j + 1][:depth]
            else
              10
            end

        # puts "n: #{n}, s: #{s}, w: #{w}, e: #{e}, depth: #{elem[:depth]}"
        if [n, s, w, e].all? { |x| x > elem[:depth] }
          low_points << elem
        end
      end

      low_points
    end

    def self.solve
      hm = Matrix.rows(Day9.parse_input)

      low_points = find_low_points(hm)

      low_points.reduce(0) { |sum, lp| sum + lp[:depth] + 1 }
    end
  end

  module Part2
    def self.find_low_points(hm)
      low_points = []

      hm.each_with_index do |element, i, j|
        n = if i - 1 >= 0
              hm[i - 1, j][:depth]
            else
              10
            end

        s = if i + 1 < hm.row_count
              hm[i + 1, j][:depth]
            else
              10
            end

        w = if j - 1 >= 0
              hm[i, j - 1][:depth]
            else
              10
            end

        e = if j + 1 < hm.column_count
              hm[i, j + 1][:depth]
            else
              10
            end

        if [n, s, w, e].all? { |x| x > element[:depth] }
          low_points << { pos: [i, j] }
        end
      end

      low_points
    end

    def self.solve
      hm = Matrix.rows(Day9.parse_input)

      low_points = find_low_points(hm)

      sizes = []
      low_points.each do |lp|
        sizes << count_members(hm, lp[:pos][0], lp[:pos][1], 0)
      end

      sizes.sort { |a, b| b - a }.slice(0, 3).reduce(:*)
    end

    def self.count_members(hm, i, j, count)
      return count if i < 0 || j < 0 || i >= hm.row_count || j >= hm.column_count

      return count if hm[i, j][:visited] || hm[i, j][:depth] == 9

      hm[i, j][:visited] = true

      return 1 + count_members(hm, i + 1, j, count) + count_members(hm, i - 1, j, count) +
        count_members(hm, i, j - 1, count) + count_members(hm, i, j + 1, count)
    end
  end
end
