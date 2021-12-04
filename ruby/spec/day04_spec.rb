require_relative '../lib/day04'
include Day4

RSpec.describe 'Day 4' do
  it 'can check equality of Mark' do
    x = MarkedNumber.new(1, true)
    y = MarkedNumber.new(1, true)
    z = MarkedNumber.new(1, false)

    expect(x).to eq(y)
    expect(x).not_to eq(z)
  end

  it 'can compute a board score' do
    board = Matrix[
      [MarkedNumber.new(1, true), MarkedNumber.new(1, true)],
      [MarkedNumber.new(7, false), MarkedNumber.new(1, true)]
    ]

    expect(Day4.compute_score(board)).to eq(7)
  end

  it 'solves the first part' do
    expect(Part1.solve).to eq(8580)
  end

  it 'solves the second part' do
    expect(Part2.solve).to eq(9576)
  end
end
