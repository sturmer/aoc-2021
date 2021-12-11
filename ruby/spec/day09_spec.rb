require_relative '../lib/day09'

RSpec.describe 'Day 9' do
  it 'solves the first part' do
    expect(Day9::Part1.solve).to eq(600)
  end

  it 'solves the second part' do
    expect(Day9::Part2.solve).to eq(987840)
  end
end
