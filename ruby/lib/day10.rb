require 'matrix'

module Day10
  # FP = '../input_files/test.day10.txt'
  FP = '../input_files/input.day10.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }
  CLOSERS = {'(' => ')', '[' => ']', '{' => '}', '<' => '>'}

  def self.parse_input
    LINES
      .map { |line| line.split('') }
  end

  module Part1
    def self.is_opener(c)
      CLOSERS.keys.include?(c)
    end

    def self.worth(c)
      case c
      when ')'
        3
      when ']'
        57
      when '}'
        1197
      when '>'
        25137
      else
        puts "syntax error"
      end
    end

    def self.solve
      lines = Day10.parse_input

      score = 0
      lines.each do |line|
        # puts "\nline: #{line}"
        stack = []
        line.each do |sym|
          if is_opener sym
            stack.push sym
          elsif CLOSERS[stack.last] == sym
            stack.pop
          else
            # puts "wrong closer: expected #{CLOSERS[stack.last]} but found #{sym} instead"
            score += worth(sym)
            break
          end
        end
      end

      score
    end
  end

  module Part2

    def self.solve
    end
  end
end

puts Day10::Part1.solve
# puts Day10::Part2.solve


