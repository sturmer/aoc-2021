require 'matrix'

module Day11
  # FP = '../input_files/test.day11.txt'
  # FP = '../input_files/test.day11-2.txt'
  FP = '../input_files/input.day11.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  def self.parse_input
    LINES
      .map { |line| line.split('').map { |x| { energy: Integer(x), visited: false } } }
  end

  class Part1
    attr_accessor :flashes_count

    def initialize
      @flashes_count = 0
    end

    def solve
      map = Matrix[*(Day11.parse_input)]

      # (1..100).each do |step|
      step = 0
      while true
        step += 1

        # First, increase all by 1
        map.each_with_index do |elem, i, j|
          elem[:energy] += 1
        end

        # Then, see who flashes
        map.each_with_index do |elem, i, j|
          if elem[:energy] >= 10
            flash(map, i, j)
          end
        end

        # Now reset
        map.each do |elem|
          elem[:visited] = false
        end

        values_map = map.map{ |el| el[:energy]}
        if values_map.zero?
          return step
        end
      end

      @flashes_count
    end

    def flash(map, i, j)
      @flashes_count += 1
      map[i, j][:energy] = 0
      map[i, j][:visited] = true

      if i - 1 >= 0 && j - 1 >= 0 && !map[i - 1, j - 1][:visited]
        map[i - 1, j - 1][:energy] += 1
        if !map[i - 1, j - 1][:visited] && map[i - 1, j - 1][:energy] >= 10
          flash(map, i-1, j-1)
        end
      end

      if i - 1 >= 0 && !map[i - 1, j][:visited]
        map[i - 1, j][:energy] += 1
        if !map[i - 1, j][:visited] && map[i - 1, j][:energy] == 10
          flash(map, i-1, j)
        end
      end

      if i - 1 >= 0 && j + 1 < map.column_count && !map[i - 1, j + 1][:visited]
        map[i - 1, j + 1][:energy] += 1
        if !map[i - 1, j + 1][:visited] && map[i - 1, j + 1][:energy] == 10
          flash(map, i-1, j+1)
        end
      end

      if j + 1 < map.column_count && !map[i, j + 1][:visited]
        map[i, j + 1][:energy] += 1
        if !map[i, j + 1][:visited] && map[i, j + 1][:energy] == 10
          flash(map, i, j+1)
        end
      end

      if i + 1 < map.row_count && j + 1 < map.column_count && !map[i + 1, j + 1][:visited]
        map[i + 1, j + 1][:energy] += 1
        if !map[i + 1, j + 1][:visited] && map[i + 1, j + 1][:energy] == 10
          flash(map, i+1, j+1)
        end
      end

      if i + 1 < map.row_count && !map[i + 1, j][:visited]
        map[i + 1, j][:energy] += 1
        if !map[i + 1, j][:visited] && map[i + 1, j][:energy] == 10
          flash(map, i+1, j)
        end
      end

      if i + 1 < map.row_count && j - 1 >= 0 && !map[i + 1, j - 1][:visited]
        map[i + 1, j - 1][:energy] += 1
        if !map[i + 1, j - 1][:visited] && map[i + 1, j - 1][:energy] == 10
          flash(map, i+1, j-1)
        end
      end

      if j - 1 >= 0 && !map[i, j - 1][:visited]
        map[i, j - 1][:energy] += 1
        if !map[i, j - 1][:visited] && map[i, j - 1][:energy] == 10
          flash(map, i, j-1)
        end
      end
    end
  end
end

puts Day11::Part1.new.solve
# puts Day11::Part2.solve


