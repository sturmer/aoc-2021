class PartOne
  def initialize
    @count = 0
    @prev_depth = -1
  end

  def solve(fp)
    File.readlines(fp).each do |line|
      depth = Integer(line)
      if @prev_depth === -1
        @prev_depth = depth
      elsif depth > @prev_depth
        @count += 1
        @prev_depth = depth
      else
        @prev_depth = depth
      end
    end

    @count
  end
end

class PartTwo
  def initialize
    @count = 0
    @prev_samples = [-1, -1, -1]
    @prev_sum = -1
  end

  def solve(fp)
    File.readlines(fp).each do |line|
      depth = Integer(line)
      @prev_samples.push(depth)
      @prev_samples.slice!(0)

      next if @prev_samples.include?(-1)

      sum = @prev_samples.reduce(:+)

      if @prev_sum == -1
        @prev_sum = sum
      else
        @count += 1 if sum > @prev_sum
        @prev_sum = sum
      end
    end

    @count
  end
end
