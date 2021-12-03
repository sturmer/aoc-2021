module Day3
  FP = '../input_files/input.day3.txt'

  def self.count(lines)
    pos_count = []
    init = false

    lines.each do |line|
      bits = line.split('')

      unless init
        init = true

        bits.each do |_x|
          pos_count.append({ zero: 0, one: 0 })
        end
      end

      bits.each_with_index do |b, i|
        if b == '1'
          pos_count[i][:one] += 1
        elsif b == '0'
          pos_count[i][:zero] += 1
        else
          puts "Unrecognized char: #{b}"
        end
      end
    end

    return pos_count
  end

  module Part1
    pos_count = []
    init = false

    File.readlines(FP).each do |line|
      bits = line.chomp!("\n").split('')

      unless init
        init = true

        bits.each do |_x|
          pos_count.append({ zero: 0, one: 0 })
        end
      end

      bits.each_with_index do |b, i|
        if b == '1'
          pos_count[i][:one] += 1
        elsif b == '0'
          pos_count[i][:zero] += 1
        else
          puts "Unrecognized char: #{b}"
        end
      end

    end

    gamma_rate = ''
    epsilon_rate = ''
    pos_count.each do |cnt|
      if cnt[:zero] > cnt[:one]
        gamma_rate += '0'
        epsilon_rate += '1'
      else
        gamma_rate += '1'
        epsilon_rate += '0'
      end
    end

    puts "Gamma rate: #{gamma_rate} (bin), #{gamma_rate.to_i(2)}"
    puts "Epsilon rate: #{epsilon_rate} (bin), #{epsilon_rate.to_i(2)}"
    puts "Result: #{gamma_rate.to_i(2) * epsilon_rate.to_i(2)}"
  end

  module Part2

    ox_gen_rating = 0

    scrub_filtered = filtered = File.readlines(FP).map { |x| x.chomp!("\n") }
    max_step = filtered[0].length

    step = 0
    while filtered.length > 1 && step < max_step do
      pos_count = Day3.count(filtered)

      majority = if pos_count[step][:one] >= pos_count[step][:zero]
                   '1'
                 else
                   '0'
                 end
      filtered = filtered.select { |x| x[step] == majority }
      ox_gen_rating = filtered.first.to_i(2) if filtered.length == 1

      step += 1
    end

    co2_scrub_rating = 0
    step = 0
    while scrub_filtered.length > 1 && step < max_step do
      pos_count = Day3.count(scrub_filtered)

      majority = if pos_count[step][:one] >= pos_count[step][:zero]
                   '1'
                 else
                   '0'
                 end
      scrub_filtered = scrub_filtered.select { |x| x[step] != majority }
      co2_scrub_rating = scrub_filtered.first.to_i(2) if scrub_filtered.length == 1

      step += 1
    end

    puts "ox_gen_rating: #{ox_gen_rating}"
    puts "co2_scrub_rating: #{co2_scrub_rating}"
    puts "res: #{ox_gen_rating * co2_scrub_rating}"
  end
end

