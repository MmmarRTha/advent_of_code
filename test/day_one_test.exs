defmodule Day01.DayOneTest do
  alias Day01.DayOne
  use ExUnit.Case
  doctest DayOne

  test "day 01 part one" do
    DayOne.load_input()
    assert DayOne.day_one_part_one() == 1_341_714
  end
end
