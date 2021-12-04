require_relative '../lib/day04'

RSpec.describe 'Day 4' do
  it 'can check equality of Mark' do
    x = Day4::MarkedNumber.new(1, true)
    y = Day4::MarkedNumber.new(1, true)
    z = Day4::MarkedNumber.new(1, false)

    expect(x).to eq(y)
    expect(x).not_to eq(z)
  end

  it 'can compute a board score' do
    board = Matrix[
      [Day4::MarkedNumber.new(1, true), Day4::MarkedNumber.new(1, true)],
      [Day4::MarkedNumber.new(7, false), Day4::MarkedNumber.new(1, true)]
    ]

    expect(Day4::Part1.compute_score(board)).to eq(7)
  end

  it 'solves the first part' do
    expect(Day4::Part1.solve).to eq(8580)
  end

  it 'solves the second part' do
    expect(Day4::Part2.solve).to eq(9576)
  end
end
