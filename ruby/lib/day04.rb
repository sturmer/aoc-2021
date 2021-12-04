require 'matrix'

module Day3
  # FP = '../input_files/test.day4.txt'
  FP = '../input_files/input.day4.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  class Mark
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

  # module Part1
  #   def Part1.solve
  #     seq_init = false
  #     seq = []
  #     rows = []
  #     boards = []
  #
  #     # Build seq and boards
  #     LINES.each do |l|
  #       if l.empty? && rows.length != 5
  #         next
  #       end
  #
  #       unless seq_init
  #         seq = l.split(',')
  #         seq_init = true
  #
  #         # puts "seq: #{seq}"
  #         next
  #       end
  #
  #       # puts "adding row #{l}"
  #       row = l.split(' ').map { |x| Mark.new(x) }
  #       rows.append(row)
  #
  #       if rows.length == 5
  #         board = Matrix[*rows]
  #         boards.append(board)
  #         # puts "board: #{board}, top-right: #{board[0, -1]}"
  #
  #         rows = []
  #       end
  #     end
  #
  #     seq.each do |s|
  #       boards.each do |b|
  #         i = b.find_index(Mark.new(s, false))
  #         while i != nil
  #           b[*i].marked = true
  #           i = b.find_index(Mark.new(s, false))
  #         end
  #       end
  #
  #       # Check if we have winners:
  #       boards.each do |b|
  #         b.row_vectors.each do |rv|
  #           if rv.all? { |x| x.marked == true}
  #             score = compute_score(b)
  #             res = Integer(s) * score
  #
  #             puts "res is #{res}"
  #             return res
  #           end
  #         end
  #
  #         b.column_vectors.each do |cv|
  #           if cv.all? { |x| x.marked == true}
  #             puts "board is a winner"
  #             score = compute_score(b)
  #             res = Integer(s) * score
  #
  #             puts "res is #{res}"
  #             return res
  #           end
  #         end
  #       end
  #     end
  #
  #     # puts "\nMarked boards #{boards}"
  #   end
  #
  #   def Part1.compute_score(board)
  #     score = 0
  #     board.each do |el|
  #       unless el.marked
  #         score += Integer(el.num)
  #       end
  #     end
  #
  #     score
  #   end
  # end

  module Part2
    def Part2.solve
      seq_init = false
      seq = []
      rows = []
      boards = []

      # Build seq and boards
      LINES.each do |l|
        if l.empty? && rows.length != 5
          next
        end

        unless seq_init
          seq = l.split(',')
          seq_init = true

          # puts "seq: #{seq}"
          next
        end

        # puts "adding row #{l}"
        row = l.split(' ').map { |x| Mark.new(x) }
        rows.append(row)

        if rows.length == 5
          board = Matrix[*rows]
          boards.append(board)
          # puts "board: #{board}, top-right: #{board[0, -1]}"

          rows = []
        end
      end

      marked_boards = boards.map { |b| { board: b, winner: false } }

      seq.each do |s|
        marked_boards.each do |mb|
          next if mb[:winner]

          b = mb[:board]

          i = b.find_index(Mark.new(s, false))
          while i != nil
            b[*i].marked = true
            i = b.find_index(Mark.new(s, false))
          end
        end

        # Check if we have winners:
        marked_boards.each do |mb|
          b = mb[:board]

          b.row_vectors.each do |rv|
            if rv.all? { |x| x.marked == true }
              puts "board is a winner"
              mb[:winner] = true

              if marked_boards.all? { |mb| mb[:winner] == true }
                # this was the last to win
                score = compute_score(b)
                res = Integer(s) * score

                puts "res is #{res}"
                return res
              end
            end
          end

          b.column_vectors.each do |cv|
            if cv.all? { |x| x.marked == true }
              puts "board is a winner"
              mb[:winner] = true

              if marked_boards.all? { |mb| mb[:winner] == true }
                # this was the last to win
                score = compute_score(b)
                res = Integer(s) * score

                puts "res is #{res}"
                return res
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

Day3::Part2.solve
