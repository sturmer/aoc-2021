require 'matrix'

module Day4
  # FP = '../input_files/test.day4.txt'
  FP = '../input_files/input.day4.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }


  class MarkedNumber
    attr_accessor :num, :marked

    def initialize(num, marked = false)
      @num = num
      @marked = marked
    end

    def to_s
      "(#{@num} #{@marked})"
    end

    def ==(other)
      @num == other.num && @marked == other.marked
    end
  end

  def self.parse_input
    seq_init = false
    rows = []

    seq = []
    boards = []

    LINES.each do |l|
      if l.empty? && rows.length != 5
        next
      end

      unless seq_init
        seq = l.split(',')
        seq_init = true
        next
      end

      row = l.split(' ').map { |x| MarkedNumber.new(x) }
      rows.append(row)

      if rows.length == 5
        board = Matrix[*rows]
        boards.append(board)

        rows = []
      end
    end

    [seq, boards]
  end

  module Part1
    def Part1.solve
      seq, boards = Day4.parse_input

      seq.each do |s|
        boards.each do |b|
          i = b.find_index(MarkedNumber.new(s, false))
          while i != nil
            b[*i].marked = true
            i = b.find_index(MarkedNumber.new(s, false))
          end
        end

        # Check if we have winners:
        boards.each do |b|
          b.row_vectors.each do |rv|
            if rv.all? { |x| x.marked == true }
              score = compute_score(b)
              return Integer(s) * score
            end
          end

          b.column_vectors.each do |cv|
            if cv.all? { |x| x.marked == true }
              score = compute_score(b)
              return Integer(s) * score
            end
          end
        end
      end
    end

    def Part1.compute_score(board)
      score = 0
      board.each do |el|
        unless el.marked
          score += Integer(el.num)
        end
      end

      score
    end
  end

  module Part2
    def Part2.solve
      seq, boards = Day4.parse_input

      marked_boards = boards.map { |b| { board: b, winner: false } }

      seq.each do |s|
        marked_boards.each do |mb|
          next if mb[:winner]

          b = mb[:board]

          i = b.find_index(MarkedNumber.new(s, false))
          while i != nil
            b[*i].marked = true
            i = b.find_index(MarkedNumber.new(s, false))
          end
        end

        # Check if we have winners:
        marked_boards.each do |mb|
          b = mb[:board]

          b.row_vectors.each do |rv|
            if rv.all? { |x| x.marked == true }
              mb[:winner] = true

              if marked_boards.all? { |mb| mb[:winner] == true }
                # this was the last to win
                score = compute_score(b)
                return Integer(s) * score
              end
            end
          end

          b.column_vectors.each do |cv|
            if cv.all? { |x| x.marked == true }
              mb[:winner] = true

              if marked_boards.all? { |mb| mb[:winner] == true }
                # this was the last to win
                score = compute_score(b)
                return Integer(s) * score
              end
            end
          end
        end
      end
    end

    def Part2.compute_score(board)
      score = 0
      board.each do |el|
        unless el.marked
          score += Integer(el.num)
        end
      end

      score
    end
  end
end

Day4::Part2.solve
