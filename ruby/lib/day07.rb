require 'matrix'

module Day7
  # FP = '../input_files/test.day7.txt'
  FP = '../input_files/input.day7.txt'

  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  def self.parse_input
    LINES.map do |line|
      line.split(',').map { |num| Integer(num) }
    end
  end


  # module Part1
  # def self.compute_consumption(hposes, i)
  #       fuel = []
  #
  #       hposes.each_with_index do |pos, cur|
  #         next if cur == i
  #         fuel << (pos - hposes[i]).abs
  #       end
  #
  #       fuel.reduce(:+)
  #     end
  #
  #   def self.solve
  #     hposes = Day7.parse_input.flatten
  #     # puts "hposes: #{hposes}"
  #
  #     min_fuel = 10000000000
  #     hposes.each_with_index do |hpos, i|
  #       fuel = compute_consumption(hposes, i)
  #       # puts "fuel: #{fuel}"
  #       min_fuel = [min_fuel, fuel].min
  #     end
  #
  #     puts min_fuel
  #   end
  # end

  module Part2
    def self.compute_cost(a, b)
      x,y = [a,b].minmax
      (1..(y-x)).reduce(:+)
    end

    def self.compute_consumption(hposes, i)
      fuels = []

      hposes.each_with_index do |pos, cur|
        next if cur == i

        fuel = self.compute_cost(pos, hposes[i])
        # puts "fuel from #{pos} to #{hposes[i]}: #{fuel}" if pos == 2
        fuels << fuel unless fuel.nil?
      end

      # puts "i: #{i}, fuels: #{fuels}"

      fuels.reduce(:+)
    end

    def self.solve
      hposes = Day7.parse_input.flatten
      # puts "hposes: #{hposes}"

      min_fuel = 10000000000
      hposes.each_with_index do |hpos, i|
        fuel = compute_consumption(hposes, i)
        # puts "fuel: #{fuel}"
        min_fuel = [min_fuel, fuel].min
      end

      puts min_fuel
    end
  end
end

# puts Day7::Part2.compute_cost(16, 5)
Day7::Part2.solve

