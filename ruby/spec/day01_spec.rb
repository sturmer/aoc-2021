require_relative '../lib/day01'

RSpec.describe 'Day 1' do
  it 'solves the first part' do
    expect(PartOne.new.solve('../input.day1.txt')).to eq(1532)
  end
  it 'solves the second part' do
    expect(PartTwo.new.solve('../input.day1.txt')).to eq(1571)
  end
end
