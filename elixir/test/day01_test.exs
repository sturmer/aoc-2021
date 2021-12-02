defmodule Day15Test do
  use ExUnit.Case
  doctest Aoc2021.Day01
  import Aoc2021.Day01

  test "part 1" do
    assert solve(:one) == 1532
  end

  test "part 2" do
    assert solve(:two) == 1571
  end
end
