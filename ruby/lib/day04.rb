require 'matrix'

module Day4
  FP = '../input_files/input.day4.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  def self.parse_input
    seq_init = false
    rows = []

    seq = []
    boards = []

    LINES.each do |l|
      next if l.empty? && rows.length != 5

      unless seq_init
        seq = l.split(',')
        seq_init = true
        next
      end

      row = l.split(' ').map { |x| { num: x, marked: false } }
      rows.append(row)

      if rows.length == 5
        board = Matrix[*rows]
        boards.append(board)

        rows = []
      end
    end

    [seq, boards]
  end

  def self.compute_score(board)
    score = 0
    board.each do |el|
      unless el[:marked]
        score += Integer(el[:num])
      end
    end

    score
  end

  def self.winning_line?(row_or_column)
    row_or_column.all? { |element| element[:marked] == true }
  end

  module Part1
    def self.solve
      seq, boards = Day4.parse_input

      seq.each do |extracted_num|
        boards.each do |board|
          while index = board.find_index({num: extracted_num, marked: false})
            board[*index][:marked] = true
          end
        end

        # Check if we have winners:
        boards.each do |board|
          [:row_vectors, :column_vectors].each do |as_vectors_method|
            board.send(as_vectors_method).each do |vector|
              if Day4.winning_line?(vector)
                score = Day4.compute_score(board)
                return Integer(extracted_num) * score
              end
            end
          end
        end
      end
    end
  end

  module Part2
    def self.solve
      seq, boards = Day4.parse_input

      annotated_boards = boards.map { |b| { board: b, winner: false } }

      seq.each do |extracted_num|
        annotated_boards.each do |annotated_board|
          next if annotated_board[:winner]

          board = annotated_board[:board]

          while index = board.find_index({ num: extracted_num, marked: false })
            board[*index][:marked] = true
          end
        end

        # Check if we have winners:
        annotated_boards.each do |annotated_board|
          board = annotated_board[:board]

          [:row_vectors, :column_vectors].each do |as_vectors_method|
            board.send(as_vectors_method).each do |vector|
              if Day4.winning_line?(vector)
                annotated_board[:winner] = true

                if annotated_boards.all? { |mb| mb[:winner] == true }
                  # this was the last to win
                  score = Day4.compute_score(board)
                  return Integer(extracted_num) * score
                end
              end
            end
          end
        end
      end
    end
  end
end
