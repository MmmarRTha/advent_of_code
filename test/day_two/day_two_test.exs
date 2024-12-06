defmodule Day02.DayTwoTest do
  use ExUnit.Case
  alias Day02.DayTwo

  describe "load_input/1" do
    test "loads and splits input file" do
      # Create a temporary file for testing
      path = "test/day02_test_input.txt"
      File.write!(path, "1 4 7\n2 5 8\n")

      result = DayTwo.load_input(path)

      assert result == ["1 4 7", "2 5 8"]
      File.rm!(path)
    end
  end

  describe "part_01/0" do
    # This test will depend on your actual input file
    test "returns count of safe reports" do
      result = DayTwo.part_01()
      assert is_integer(result)
    end
  end

  describe "parse_report/1" do
    test "converts string report to list of integers" do
      result = DayTwo.parse_report("1 4 7")
      assert result == [1, 4, 7]
    end
  end

  describe "is_safe?/1" do
    test "returns true for increasing sequence within bounds" do
      assert DayTwo.is_safe?([1, 3, 5])
      assert DayTwo.is_safe?([1, 2, 4])
    end

    test "returns false for increasing sequence outside bounds" do
      refute DayTwo.is_safe?([1, 5, 9])
      refute DayTwo.is_safe?([1, 6, 8])
    end

    test "returns true for decreasing sequence within bounds" do
      assert DayTwo.is_safe?([5, 3, 1])
      assert DayTwo.is_safe?([6, 4, 2])
    end

    test "returns false for decreasing sequence outside bounds" do
      refute DayTwo.is_safe?([9, 5, 1])
      refute DayTwo.is_safe?([8, 2, 1])
    end

    test "returns false for non-monotonic sequence" do
      refute DayTwo.is_safe?([1, 3, 2])
      refute DayTwo.is_safe?([3, 1, 2])
    end
  end
end
