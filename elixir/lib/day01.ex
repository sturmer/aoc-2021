defmodule Aoc2021.Day01 do
  def solve(part) do
    case File.read('../input_files/input.day1.txt') do
      {:ok, content} -> content
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> dispatch(part)
    end
  end

  def dispatch(lines, part) do
    if part == :one do
      solve1(lines)
    else
      solve2(lines)
    end
  end

  def solve1(lines) do
    find_depth(lines, -1, 0)
  end

  defp find_depth([head | tail], prev_depth, count) do
    depth = head

    if prev_depth === -1 or depth <= prev_depth do
      find_depth(tail, depth, count)
    else
      find_depth(tail, depth, count+1)
    end
  end

  defp find_depth(_, _, count) do
    count
  end

  def solve2(lines) do
    find_tri_depth(lines, [-1, -1, -1], -1, 0)
  end

  defp find_tri_depth([head | tail], prev_samples, prev_sum, count) do
    {_popped, first_two} = List.pop_at(prev_samples, 0)
    new_prev_samples = List.insert_at(first_two, -1, head)

    if Enum.member?(prev_samples, -1) do
      find_tri_depth(tail, new_prev_samples, prev_sum, count)
    else
      sum = Enum.sum(prev_samples)

      cond do
        prev_sum == -1 -> find_tri_depth(tail, new_prev_samples, sum, count)
        sum > prev_sum -> find_tri_depth(tail, new_prev_samples, sum, count+1)
        true -> find_tri_depth(tail, new_prev_samples, sum, count)
      end
    end
  end

  defp find_tri_depth([], _prev_samples, _prev_sum, count) do
    count+1
  end
end
