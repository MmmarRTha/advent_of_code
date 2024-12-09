defmodule Day04.DayFour do
  @word "XMAS"
  @directions [
    {0, 1},
    {0, -1},
    {1, 0},
    {-1, 0},
    {1, 1},
    {1, -1},
    {-1, 1},
    {-1, -1}
  ]
  def load_input(path \\ "lib/day04/input.txt") do
    {:ok, contents} = File.read(path)
    String.split(contents, "\n", trim: true)
  end

  @doc """
   Solves part one of day 4's puzzle.

   ## Example:

     iex> Day04.DayFour.part_01()
     2654
  """

  def part_01 do
    load_input()
    |> Enum.map(&String.graphemes/1)
    |> count_xmas_occurrences()
  end

  def count_xmas_occurrences(grid) do
    height = length(grid)
    width = length(Enum.at(grid, 0))

    for row <- 0..(height - 1),
        col <- 0..(width - 1),
        direction <- @directions,
        reduce: 0 do
      acc -> acc + search(grid, {row, col}, direction)
    end
  end

  defp search(grid, {row, col}, {dx, dy}) do
    height = length(grid)
    width = length(Enum.at(grid, 0))

    if is_valid?(row, col, dx, dy, height, width) do
      @word
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.all?(fn {char, i} ->
        curr_row = row + dx * i
        curr_col = col + dy * i

        get_char(grid, curr_row, curr_col) == char
      end)
      |> if(do: 1, else: 0)
    else
      0
    end
  end

  defp is_valid?(row, col, dx, dy, height, width) do
    Enum.all?(0..3, fn i ->
      new_row = row + dx * i
      new_col = col + dy * i
      new_row >= 0 and new_row < height and new_col >= 0 and new_col < width
    end)
  end

  defp get_char(grid, row, col) do
    grid
    |> Enum.at(row)
    |> Enum.at(col)
  end

  @doc """
   Solves part two of day 4's puzzle.

   ## Example:

     iex> Day04.DayFour.part_02()
     1990
  """
  def part_02 do
    load_input()
    |> Enum.map(&String.graphemes/1)
    |> count_xmas_x_patterns()
  end

  def count_xmas_x_patterns(grid) do
    height = length(grid)
    width = length(Enum.at(grid, 0))

    for row <- 1..(height - 2),
        col <- 1..(width - 2),
        reduce: 0 do
      acc -> acc + check_x_pattern(grid, row, col)
    end
  end

  defp check_x_pattern(grid, row, col) do
    center_char = get_char(grid, row, col)

    if center_char == "A" do
      x_patterns = [
        # Top-left to bottom-right + Top-right to bottom-left
        {[{-1, -1}, {1, 1}], [{-1, 1}, {1, -1}]},
        # Top-right to bottom-left + Top-left to bottom-right
        {[{-1, 1}, {1, -1}], [{-1, -1}, {1, 1}]}
      ]

      Enum.any?(x_patterns, fn {dir1, dir2} ->
        check_mas_pair(grid, row, col, dir1, dir2)
      end)
      |> if(do: 1, else: 0)
    else
      0
    end
  end

  defp check_mas_pair(grid, row, col, dir1, dir2) do
    check_single_mas(grid, row, col, dir1) and check_single_mas(grid, row, col, dir2)
  end

  defp check_single_mas(grid, row, col, [{dr1, dc1}, {dr2, dc2}]) do
    # Check both forward and backward directions
    forward = [
      get_char(grid, row + dr1, col + dc1) == "M",
      get_char(grid, row, col) == "A",
      get_char(grid, row + dr2, col + dc2) == "S"
    ]

    backward = [
      get_char(grid, row + dr1, col + dc1) == "S",
      get_char(grid, row, col) == "A",
      get_char(grid, row + dr2, col + dc2) == "M"
    ]

    Enum.all?(forward) or Enum.all?(backward)
  end
end
