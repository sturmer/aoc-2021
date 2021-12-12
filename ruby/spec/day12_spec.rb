require_relative '../lib/day12'

RSpec.describe 'Day 12' do
  it 'solves the first part' do
    expect(Day12::Part1.new.solve).to eq(5756)
  end

  it 'solves the second part' do
    expect(Day12::Part2.new.solve).to eq(144603)
  end
end
