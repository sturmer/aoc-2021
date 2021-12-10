require 'matrix'

module Day10
  # FP = '../input_files/test.day10.txt'
  FP = '../input_files/input.day10.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }
  CLOSERS = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }

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
      incomplete_lines = lines.map { |line| { line: line, remove: false } }
      lines.each_with_index do |line, i|
        # puts "\nline: #{line}"
        stack = []
        line.each do |sym|
          if is_opener sym
            stack.push sym
          elsif CLOSERS[stack.last] == sym
            stack.pop
          else
            # puts "wrong closer: expected #{CLOSERS[stack.last]} but found #{sym} instead"
            # score += worth(sym)
            incomplete_lines[i][:remove] = true
            break
          end
        end
      end

      scores = []
      incomplete_lines
        .filter { |line| line[:remove] == false }
        .map { |line| line[:line] }
        .each do |line|

        stack = []
        line.each do |sym|
          if is_opener sym
            stack.push sym
          elsif CLOSERS[stack.last] == sym
            stack.pop
          else
            puts "shouldn't be here"
          end
        end

        closers = []
        stack.reverse_each do |sym|
          closers << CLOSERS[sym]
        end
        # puts "closers: #{closers.join('')}"
        scores << eval_closers(closers)
      end

      # puts "scores: #{scores}"
      # Take middle score
      scores.sort!
      scores[scores.length.div(2)]
    end

    def self.eval_closers(closers)
      val = {')' => 1, ']' => 2, '}' => 3, '>' => 4}
      acc = 0
      closers.each do |c|
        acc = acc * 5 + val[c]
      end

      acc
    end
  end
end

# puts Day10::Part1.solve
puts Day10::Part2.solve


