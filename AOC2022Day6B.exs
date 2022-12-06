{:ok, contents} = File.read("day6input.txt")
[input] = contents \
  |> String.split("\n")

defmodule AOC2022Day6A do
  def go(i) do
    i
    |> String.graphemes()
    |> Enum.chunk_every(14, 1)
    |> Enum.with_index()
    |> Enum.reduce(nil, fn {l, i}, a ->
      cond do
        a != nil -> a
        Enum.frequencies(l)
        |> Map.keys()
        |> Enum.count() == 14 -> i + 14
        true -> a
      end
    end)
    |> IO.inspect()
  end
end

AOC2022Day6A.go(input)
