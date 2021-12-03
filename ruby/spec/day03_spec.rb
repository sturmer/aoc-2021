require_relative '../lib/day03'

RSpec.describe 'Day 3' do
  it 'solves the first part' do
    expect(Day3::Part1.solve).to eq(3549854)
  end

  it 'solves the second part' do
    expect(Day3::Part2.solve).to eq(3765399)
  end
end
