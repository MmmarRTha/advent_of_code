defmodule Day01.DayOne do
  @moduledoc """
  --- Day 1: Historian Hysteria ---
  https://adventofcode.com/2024/day/1
  """

  @doc """
  Loads the puzzle input from a text file containing pairs of numbers separated by whitespace.
  Each line contains two numbers - one for the left list and one for the right list.
  Returns a list of strings, where each string is a line from the input file.

  Solves part one of day 1's puzzle.

  Takes the input file containing two lists of location IDs, sorts them independently,
  pairs up corresponding numbers from each sorted list, and calculates the total
  distance between all pairs.

  The distance for each pair is the absolute difference between the two numbers.

  Returns the sum of all distances between paired numbers.

  ## Example:

      iex> DayOne.part_01()
      2176849

  """

  def load_input(path \\ "lib/day01/input.txt") do
    {:ok, contents} = File.read(path)
    String.split(contents, "\n", trim: true)
  end

  def part_01 do
    {left_nums, right_nums} =
      load_input()
      |> extract_and_accumulate_pairs()

    calculate_distance(left_nums, right_nums)
  end

  defp extract_and_accumulate_pairs(data) do
    Enum.reduce(data, {[], []}, fn line, {left_acc, right_acc} ->
      case String.split(line, ~r/\s+/, trim: true) do
        [left, right] ->
          {
            [String.to_integer(left) | left_acc],
            [String.to_integer(right) | right_acc]
          }

        _ ->
          {left_acc, right_acc}
      end
    end)
  end

  defp calculate_distance(left_nums, right_nums) do
    left_sorted = Enum.sort(left_nums)
    right_sorted = Enum.sort(right_nums)

    Enum.zip(left_sorted, right_sorted)
    |> Enum.map(fn {left, right} -> abs(left - right) end)
    |> Enum.sum()
  end

  @doc """
   Returs the similarity score of left and right lists

   ## Example:

      iex> DayOne.part_02()
      23384288
  """
  def part_02 do
    {left_nums, right_nums} =
      load_input()
      |> extract_and_accumulate_pairs()

    calculate_similarity_score(left_nums, right_nums)
  end

  defp calculate_similarity_score(left_nums, right_nums) do
    right_counts = Enum.frequencies(right_nums)

    left_nums
    |> Enum.map(fn num -> num * Map.get(right_counts, num, 0) end)
    |> Enum.sum()
  end
end
