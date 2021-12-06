require_relative '../lib/day06'
include Day6

RSpec.describe 'Day 6' do
  it 'solves the first part' do
    expect(Part1.solve).to eq(379414)
  end

  it 'solves the second part' do
    expect(Part2.solve).to eq(1705008653296)
  end
end
