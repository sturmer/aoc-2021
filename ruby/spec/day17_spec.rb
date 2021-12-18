require_relative '../lib/day17'

include Day17

RSpec.describe 'Day 17' do
  it 'can tell if a point is in the area' do
    expect(Part1.new(20, 30, -10, -5).target.contain?([28, -7])).to be_truthy
  end

  it 'computes the next position correctly' do
    p = Point[13, 3]
    v = Point[5, 0]

    expect(Part1.next_pos(p, v)).to eq(Point[18, 3])
  end

  it 'computes correctly the next velocity' do
    v1 = Point[6, 1]
    v2 = Point[0, -5]
    v3 = Point[-3, 0]

    expect(Part1.next_v(v1)).to eq(Point[5, 0])
    expect(Part1.next_v(v2)).to eq(Point[0, -6])
    expect(Part1.next_v(v3)).to eq(Point[-2, -1])
  end

  xit 'solves the first part' do
    expect(Part1.new(1, 2, 3 ,4).solve).to eq('todo')
  end

  xit 'solves the second part' do
    # expect(Part2.new(0, 0, 0, 0).solve).to eq('todo')
  end
end
