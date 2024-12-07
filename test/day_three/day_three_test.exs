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

  describe "find_valid_multiplications/1" do
    test "extracts multiplication instructions from string" do
      input = "mul(123, 456)\nsome other text\nmul(789, 101)"
      result = Day03.DayThree.find_valid_multiplications(input)

      assert result == [{123, 456}, {789, 101}]
    end
  end
end
