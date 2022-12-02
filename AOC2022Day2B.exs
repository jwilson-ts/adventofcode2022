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
      "X" -> 3
      "Y" -> 4
      "Z" -> 8
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
      "X" -> 2
      "Y" -> 6
      "Z" -> 7
    end
  end
end

AOC2022Day1A.go(input)
