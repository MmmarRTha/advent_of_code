defmodule Day02.DayTwo do
  @spec load_input() :: [binary()]
  def load_input(path \\ "lib/day02/input.txt") do
    {:ok, contents} = File.read(path)
    String.split(contents, "\n", trim: true)
  end

  @spec part_01() :: non_neg_integer()
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
end
