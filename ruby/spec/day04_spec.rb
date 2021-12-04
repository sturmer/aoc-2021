require_relative '../lib/day04'

RSpec.describe 'Day 4' do
  it '' do
    x = Day3::Mark.new(1, true)
    y = Day3::Mark.new(1, true)
    z = Day3::Mark.new(1, false)

    expect(x).to eq(y)
    expect(x).not_to eq(z)
  end

  it 'xva' do
    m = Matrix[
      [Day3::Mark.new(1, true), Day3::Mark.new(1, true)],
      [Day3::Mark.new(7, false), Day3::Mark.new(1, true)]
    ]

    expect(Day3::Part1.compute_score(m)).to eq(7)
  end

  it 'solves the first part' do
    expect(Day4::Part1.solve).to eq(8580)
  end

  it 'solves the second part' do
    expect(Day4::Part2.solve).to eq(9576)
  end
end
