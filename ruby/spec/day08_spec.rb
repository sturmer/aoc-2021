require_relative '../lib/day08'

RSpec.describe 'Day 8' do
  it 'solves the first part' do
    expect(Day8::Part1.new.solve).to eq('todo')
  end

  it 'solves the second part' do
    expect(Day8::Part2.new.solve).to eq('todo')
  end
end
