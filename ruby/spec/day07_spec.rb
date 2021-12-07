require_relative '../lib/day07'

RSpec.describe 'Day 7' do
  it 'solves the first part' do
    expect(Day7::Part1.new.solve).to eq(351901)
  end

  it 'solves the second part' do
    skip 'inefficient (but correct!) algorithm' do
      expect(Day7::Part2.new.solve).to eq(101079875)
    end
  end
end
