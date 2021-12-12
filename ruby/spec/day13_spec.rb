require_relative '../lib/day13'

RSpec.describe 'Day 13' do
  it 'solves the first part' do
    expect(Day13::Part1.new.solve).to eq('todo')
  end

  it 'solves the second part' do
    expect(Day13::Part2.new.solve).to eq('todo')
  end
end
