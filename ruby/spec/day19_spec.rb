require_relative '../lib/day19'
include Day19

RSpec.describe 'Day 19' do
  it 'can rotate a point in 3D' do
    p = Point[5, 6, -4]

    rotations = Part1.new.rotate_point(p)
    # puts rotations
    expect(rotations).to include(Point[-5, -4, 6], Point[4, 6, 5], Point[-4, -6, 5], Point[-6, -4, 5])
  end

  xit 'solves the first part' do
    expect(Day19::Part1.new.solve).to eq('todo')
  end

  xit 'solves the second part' do
    expect(Day19::Part2.new.solve).to eq('todo')
  end
end
