require 'matrix'

module Day13
  # FILE_PATH = '../input_files/test.day13.txt'
  FILE_PATH = '../input_files/input.day13.txt'
  LINES = File.readlines(FILE_PATH).map { |x| x.chomp("\n") }

  def self.parse_input
    ones = []
    how_to_fold = []
    rows = cols = 0

    LINES.map do |line|
      if line.start_with?('f')
        words, value_s = line.split('=')
        axis = words[-1]
        value = Integer(value_s)
        how_to_fold << { axis => value }
      elsif line.length == 0
        next
      else
        y, x = line.split(',').map { |n| Integer(n) }
        # puts("x: #{x}, y: #{y}")
        rows = [rows, x].max
        cols = [cols, y].max
        ones << [x, y]
      end
    end

    m = Matrix.zero(rows + 1, cols + 1)
    ones.each do |p|
      m[*p] = 1
    end

    [m, how_to_fold]
  end

  class Part1
    attr_accessor :paper, :how_to_fold

    def initialize
      @paper, @how_to_fold = Day13.parse_input
    end

    def solve
      dir = @how_to_fold[0].keys[0]

      # # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} @how_to_fold: #{@how_to_fold}")

      folded = if dir == 'x'
                 fold_left @how_to_fold[0].values[0]
               else
                 fold_up @how_to_fold[0].values[0]
               end

      folded.reject { |elem| elem == 0 }.length

      # dir = @how_to_fold[1].keys[0]
      # # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} new_dir: #{dir}")
      # second_fold = fold_left( @how_to_fold[1].values[0], folded)
      # # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} second_fold: #{second_fold}")
    end

    def fold_up(axis, paper = @paper)
      upper_rows = []
      lower_rows = []

      paper.row_vectors.each_with_index do |row, i|
        if i < axis
          upper_rows << row
        elsif i == axis
          next
        else
          lower_rows << row
        end
      end

      diff = (upper_rows.length - lower_rows.length).abs
      if upper_rows.length > lower_rows.length
        (0..diff - 1).each { lower_rows << Vector.zero(lower_rows[0].length) }
      elsif upper_rows.length < lower_rows.length
        (0..diff - 1).each { upper_rows = [Vector.zero(lower_rows[0].length)] + upper_rows }
      end

      upper_paper = Matrix.rows(upper_rows)
      lower_paper = Matrix.rows(lower_rows.reverse)

      # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} upper: #{upper_paper}")
      # puts("------------------#{__FILE__}:#{__LINE__} lower_paper: #{lower_paper}")

      result = []
      upper_paper.row_vectors.each_with_index do |row, i|
        new_row = []
        row.each_with_index do |elem, j|
          new_row << [elem, lower_paper[i, j]].max
        end

        result << new_row
      end

      Matrix.rows(result)
    end

    def fold_left(axis, paper = @paper)
      left_cols = []
      right_cols = []

      # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} paper.column_vectors.length: #{paper.column_vectors.length}")

      paper.column_vectors.each_with_index do |col, j|
        if j < axis
          left_cols << col
        elsif j == axis
          next
        else
          right_cols << col
        end
      end

      # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} left cols length: #{left_cols.length}")
      # puts("------------------#{__FILE__}:#{__LINE__} right cols length: #{right_cols.length}")

      diff = (left_cols.length - right_cols.length).abs
      # puts("------------------#{__FILE__}:#{__LINE__} diff: #{diff}")
      if left_cols.length > right_cols.length
        (0..diff - 1).each do
          right_cols << Vector.zero(left_cols[0].size)
        end
      elsif left_cols.length < right_cols.length
        (0..diff - 1).each do
          # Put in front
          left_cols = [Vector.zero(left_cols[0].size)] + left_cols
        end
      end

      left_paper = Matrix.columns(left_cols)
      right_paper = Matrix.columns(right_cols.reverse)

      # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} left: #{left_paper.row_size}x#{left_paper.column_size}")
      # puts("------------------#{__FILE__}:#{__LINE__} right_paper: #{right_paper.row_size}x#{right_paper.column_size}")

      result = []
      left_paper.row_vectors.each_with_index do |row, i|
        new_row = []
        row.each_with_index do |elem, j|
          new_row << [elem, right_paper[i, j]].max
        end

        result << new_row
      end

      Matrix.rows(result)
    end

  end

  class Part2
    attr_accessor :paper, :how_to_fold

    def initialize
      @paper, @how_to_fold = Day13.parse_input
    end

    def solve
      paper = @paper
      @how_to_fold.each do |kv|
        dir = kv.keys.first
        axis = kv.values.first

        if dir == 'x'
          paper = fold_left(axis, paper)
        else
          paper = fold_up(axis, paper)
        end

        # TODO(gianluca): Remove when done
      end

      print_paper paper
    end

    def print_paper(paper)
      paper.row_vectors.each { |row| puts row }
    end

    def fold_up(axis, paper = @paper)
      upper_rows = []
      lower_rows = []

      paper.row_vectors.each_with_index do |row, i|
        if i < axis
          upper_rows << row
        elsif i == axis
          next
        else
          lower_rows << row
        end
      end

      diff = (upper_rows.length - lower_rows.length).abs
      if upper_rows.length > lower_rows.length
        (0..diff - 1).each { lower_rows << Vector.zero(lower_rows[0].size) }
      elsif upper_rows.length < lower_rows.length
        (0..diff - 1).each { upper_rows = [Vector.zero(lower_rows[0].size)] + upper_rows }
      end

      upper_paper = Matrix.rows(upper_rows)
      lower_paper = Matrix.rows(lower_rows.reverse)

      # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} upper: #{upper_paper}")
      # puts("------------------#{__FILE__}:#{__LINE__} lower_paper: #{lower_paper}")

      result = []
      upper_paper.row_vectors.each_with_index do |row, i|
        new_row = []
        row.each_with_index do |elem, j|
          new_row << [elem, lower_paper[i, j]].max
        end

        result << new_row
      end

      Matrix.rows(result)
    end

    def fold_left(axis, paper = @paper)
      left_cols = []
      right_cols = []

      # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} paper.column_vectors.length: #{paper.column_vectors.length}")

      paper.column_vectors.each_with_index do |col, j|
        if j < axis
          left_cols << col
        elsif j == axis
          next
        else
          right_cols << col
        end
      end

      # TODO(gianluca): Remove when done
      # puts("------------------#{__FILE__}:#{__LINE__} left cols length: #{left_cols.length}")
      # puts("------------------#{__FILE__}:#{__LINE__} right cols length: #{right_cols.length}")

      diff = (left_cols.length - right_cols.length).abs
      # puts("------------------#{__FILE__}:#{__LINE__} diff: #{diff}")
      if left_cols.length > right_cols.length
        (0..diff - 1).each do
          right_cols << Vector.zero(left_cols[0].size)
        end
      elsif left_cols.length < right_cols.length
        (0..diff - 1).each do
          # Put in front
          left_cols = [Vector.zero(left_cols[0].size)] + left_cols
        end
      end

      left_paper = Matrix.columns(left_cols)
      right_paper = Matrix.columns(right_cols.reverse)

      result = []
      left_paper.row_vectors.each_with_index do |row, i|
        new_row = []
        row.each_with_index do |elem, j|
          new_row << [elem, right_paper[i, j]].max
        end

        result << new_row
      end

      Matrix.rows(result)
    end

  end
end

# puts Day13::Part1.new.solve # 706
Day13::Part2.new.solve # LRFJBJEH :D

