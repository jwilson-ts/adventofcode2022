{:ok, contents} = File.read("day2input.txt")
input = contents \
  |> String.split("\n")

defmodule AOC2022Day1A do
  def go(i) do
    i
    |> Enum.map(fn move ->
      move
      |> String.split(" ")
      |> determine_points()
    end)
    |> Enum.sum()
    |> IO.puts()
  end

  def determine_points(["A", you]) do
    case you do
      "X" -> 4
      "Y" -> 8
      "Z" -> 3
    end
  end

  def determine_points(["B", you]) do
    case you do
      "X" -> 1
      "Y" -> 5
      "Z" -> 9
    end
  end

  def determine_points(["C", you]) do
    case you do
      "X" -> 7
      "Y" -> 2
      "Z" -> 6
    end
  end
end

AOC2022Day1A.go(input)
