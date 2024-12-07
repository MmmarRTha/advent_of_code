defmodule Day03.DayThree do
  def load_input(path \\ "lib/day03/input.txt") do
    {:ok, contents} = File.read(path)
    String.split(contents, "\n", trim: true)
  end

  @doc """
   Solves part one of day 3's puzzle.

   ## Example:

     iex> Day03.DayThree.part_01()
     181345830
  """
  def part_01 do
    load_input()
    |> Enum.join("\n")
    |> find_valid_multiplications()
    |> Enum.map(&multiply_instructions/1)
    |> Enum.sum()
  end

  def find_valid_multiplications(memory_string) do
    Regex.scan(~r/mul\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)/, memory_string)
    |> Enum.map(fn [_, x, y] -> {String.to_integer(x), String.to_integer(y)} end)
  end

  def multiply_instructions({x, y}) do
    x * y
  end
end
