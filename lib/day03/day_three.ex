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

  @doc """
   Solves part one of day 3's puzzle.

   ## Example:

     iex> Day03.DayThree.part_02()
     98729041
  """

  def part_02 do
    load_input()
    |> Enum.join("\n")
    |> find_valid_multiplications_with_state()
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

  def find_valid_multiplications_with_state(memory_string) do
    # First find all instructions in order (both multiplications and state changes)
    all_instructions =
      Regex.scan(~r/(?:mul\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)|do\(\)|don't\(\))/, memory_string)

    # Process instructions keeping track of enabled state
    {_, valid_muls} =
      Enum.reduce(all_instructions, {true, []}, fn
        ["do()"], {_, acc} ->
          {true, acc}

        ["don't()"], {_, acc} ->
          {false, acc}

        [_full, x, y], {enabled, acc} ->
          if enabled do
            {enabled, [{String.to_integer(x), String.to_integer(y)} | acc]}
          else
            {enabled, acc}
          end
      end)

    Enum.reverse(valid_muls)
  end
end
