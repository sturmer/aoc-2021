require_relative '../lib/day05'
include Day5

RSpec.describe 'Day 5' do
  it 'solves the first part' do
    expect(Part1.solve).to eq(5197)
  end

  it 'solves the second part' do
    expect(Part2.solve).to eq(18605)
  end
end
