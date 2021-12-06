require_relative '../lib/day04'

RSpec.describe 'Day 4' do
  it 'can compute a board score' do
    board = Matrix[
      [{ num: 1, marked: true }, { num: 1, marked: true }],
      [{ num: 7, marked: false }, { num: 1, marked: true }]
    ]

    expect(Day4.compute_score(board)).to eq(7)
  end

  it 'solves the first part' do
    expect(Day4::Part1.solve).to eq(8580)
  end

  it 'solves the second part' do
    expect(Day4::Part2.solve).to eq(9576)
  end
end
