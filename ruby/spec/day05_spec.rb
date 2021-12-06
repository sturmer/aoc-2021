require_relative '../lib/day05'

RSpec.describe 'Day 5' do
  it 'solves the first part' do
    expect(Day5::Part1.solve).to eq(5197)
  end

  it 'solves the second part' do
    expect(Day5::Part2.solve).to eq(18605)
  end
end
