module Day8
  # FP = '../input_files/test.day8.txt'
  FP = '../input_files/input.day8.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  def self.parse_input
    LINES
  end

  module Part1
    def self.solve
      count = 0
      Day8.parse_input.each do |line|
        _input, output = line.split(' | ')
        digits = output.split(' ')

        digits.each do |digit|
          len = digit.length
          if [4, 3, 2, 7].include?(len)
            count += 1
          end
        end
      end

      count
    end
  end

  module Part2
    def self.solve
      res = 0

      Day8.parse_input.each do |line|
        input, output = line.split(' | ')
        input_digits = input.split(' ').map { |x| x.split('').sort.join('') }

        four = seven = one = eight = ''
        i235 = []
        i069 = []
        input_digits.each do |digit|
          len = digit.length

          if len == 4
            four = digit
          elsif len == 3
            seven = digit
          elsif len == 2
            one = digit
          elsif len == 7
            eight = digit
          elsif len == 5
            i235 << digit
          elsif len == 6
            i069 << digit
          end
        end

        # 3 is the one having 3 letters in common with seven
        three_index = i235.index { |i| i.split('').intersection(seven.split('')).length == 3 }
        three = i235.delete_at(three_index)

        six_index = i069.index { |i| i.split('').intersection(one.split('')).length == 1 }
        six = i069.delete_at(six_index)

        five_index = i235.index { |i| i.split('').intersection(four.split('')).length == 3 }
        five = i235.delete_at(five_index)
        two = i235[0]

        nine_index = i069.index { |i| i.split('').intersection(five.split('')).length == 5 }
        nine = i069.delete_at nine_index
        zero = i069[0]

        output_digits = output.split(' ').map { |x| x.split('').sort.join('') }
        cur_num = ''
        output_digits.each do |o|
          case o
          when zero
            cur_num += '0'
          when one
            cur_num += '1'
          when two
            cur_num += '2'
          when three
            cur_num += '3'
          when four
            cur_num += '4'
          when five
            cur_num += '5'
          when six
            cur_num += '6'
          when seven
            cur_num += '7'
          when eight
            cur_num += '8'
          when nine
            cur_num += '9'
          end

        end
        res += Integer(cur_num.sub(/^0*/, ''))
      end

      res
    end
  end
end

puts Day8::Part1.solve #519
# puts Day8::Part2.solve # 1027483


