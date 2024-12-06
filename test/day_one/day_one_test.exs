defmodule Day01.DayOneTest do
  alias Day01.DayOne
  use ExUnit.Case
  doctest DayOne

  test "day 01 part one" do
    assert DayOne.part_01() == 2_176_849
  end

  test "day 01 part two" do
    assert DayOne.part_02() == 23_384_288
  end
end
