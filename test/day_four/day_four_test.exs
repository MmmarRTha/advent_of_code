defmodule DayFour.DayFourTest do
  use ExUnit.Case
  alias Day04.DayFour

  describe "count_xmas_occurrences/1" do
    test "finds horizontal XMAS" do
      grid = [
        [".", ".", ".", "."],
        ["X", "M", "A", "S"],
        [".", ".", ".", "."]
      ]

      assert DayFour.count_xmas_occurrences(grid) == 1
    end

    test "finds vertical XMAS" do
      grid = [
        ["X", ".", "."],
        ["M", ".", "."],
        ["A", ".", "."],
        ["S", ".", "."]
      ]

      assert DayFour.count_xmas_occurrences(grid) == 1
    end

    test "finds diagonal XMAS" do
      grid = [
        ["X", ".", ".", "."],
        [".", "M", ".", "."],
        [".", ".", "A", "."],
        [".", ".", ".", "S"]
      ]

      assert DayFour.count_xmas_occurrences(grid) == 1
    end

    test "finds reverse horizontal XMAS" do
      grid = [
        [".", ".", ".", "."],
        ["S", "A", "M", "X"],
        [".", ".", ".", "."]
      ]

      assert DayFour.count_xmas_occurrences(grid) == 1
    end

    test "finds multiple XMAS occurrences" do
      grid = [
        ["X", "M", "A", "S"],
        [".", ".", ".", "."],
        ["S", "A", "M", "X"]
      ]

      assert DayFour.count_xmas_occurrences(grid) == 2
    end

    test "handles example from puzzle description" do
      grid = [
        ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
        ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
        ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
        ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
        ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
        ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
        ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
        ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
        ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
        ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"]
      ]

      assert DayFour.count_xmas_occurrences(grid) == 18
    end
  end

  describe "part_01/0" do
    test "solves the puzzle with actual input" do
      result = DayFour.part_01()
      assert is_integer(result)
      assert result == 2654
    end
  end
end
