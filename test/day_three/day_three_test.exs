defmodule DayThree.DayThreeTest do
  use ExUnit.Case
  doctest Day03.DayThree

  describe "part_01/0" do
    test "returns correct solution" do
      result = Day03.DayThree.part_01()
      assert is_integer(result)
      assert result == 181_345_830
    end
  end

  describe "part_02/0" do
    test "returns correct solution" do
      result = Day03.DayThree.part_02()
      assert is_integer(result)
      assert result == 98_729_041
    end
  end

  describe "find_valid_multiplications/1" do
    test "extracts multiplication instructions from string" do
      input = "mul(123, 456)\nsome other text\nmul(789, 101)"
      result = Day03.DayThree.find_valid_multiplications(input)

      assert result == [{123, 456}, {789, 101}]
    end
  end

  describe "find_valid_multiplications_with_state/1" do
    test "parses basic multiplication instructions" do
      input = "mul(2,3) mul(4,5)"
      assert Day03.DayThree.find_valid_multiplications_with_state(input) == [{2, 3}, {4, 5}]
    end

    test "respects do() and don't() state changes" do
      input = """
      mul(1,2)
      don't()
      mul(3,4)
      do()
      mul(5,6)
      """

      assert Day03.DayThree.find_valid_multiplications_with_state(input) == [{1, 2}, {5, 6}]
    end

    test "handles whitespace and multiple state changes" do
      input = """
      mul(1,1)
      don't()
      mul(2,2)
      don't()
      mul(3,3)
      do()
      mul(4,4)
      """

      assert Day03.DayThree.find_valid_multiplications_with_state(input) == [{1, 1}, {4, 4}]
    end

    test "handles empty input" do
      assert Day03.DayThree.find_valid_multiplications_with_state("") == []
    end

    test "handles input with only state changes" do
      input = "do() don't() do()"
      assert Day03.DayThree.find_valid_multiplications_with_state(input) == []
    end
  end
end
