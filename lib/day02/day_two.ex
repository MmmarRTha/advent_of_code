defmodule Day02.DayTwo do
  def load_input(path \\ "lib/day02/input.txt") do
    {:ok, contents} = File.read(path)
    String.split(contents, "\n", trim: true)
  end

  @doc """
  Solves part one of day 2's puzzle.

  Analyzes a list of sensor reports where each report is a sequence of numbers.
  A report is considered "safe" if the numbers are either:
  - Strictly increasing with differences of 1-3 between consecutive numbers
  - Strictly decreasing with differences of 1-3 between consecutive numbers

  Returns the count of reports that are considered safe.

  ## Example:

      iex> Day02.DayTwo.part_01()
      269
  """

  def part_01 do
    load_input()
    |> Enum.map(&parse_report/1)
    |> Enum.count(&is_safe?/1)
  end

  def parse_report(report_string) do
    report_string
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def is_safe?(report) do
    increasing?(report) or decreasing?(report)
  end

  def increasing?(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> b - a > 0 and b - a <= 3 end)
  end

  def decreasing?(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> a - b > 0 and a - b <= 3 end)
  end

  @doc """
    Solves part two of day 2's puzzle.

    Returns the total count of reports that are safe or can be made safe by removing one number.

    ## Example:

      iex(1)> Day02.DayTwo.part_02
      337
  """
  def part_02 do
    load_input()
    |> Enum.map(&parse_report/1)
    |> Enum.count(&is_safe_with_dampener?/1)
  end

  defmacro return_true_if(condition, result) do
    quote do
      if unquote(condition), do: unquote(result), else: nil
    end
  end

  def is_safe_with_dampener?(report) do
    return_true_if(is_safe?(report), true)

    Enum.any?(0..(length(report) - 1), fn index ->
      modified_report = List.delete_at(report, index)
      is_safe?(modified_report)
    end)
  end
end
