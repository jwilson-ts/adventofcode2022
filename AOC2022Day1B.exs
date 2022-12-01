{:ok, contents} = File.read("day1input.txt")
input = contents \
  |> String.split("\n")

defmodule AOC2022Day1B do
  def go(i) do
    [h, s, t | _] =
      i
      |> Enum.chunk_by(&(String.length(&1) == 0))
      |> Enum.reject(&(&1 == [""]))
      |> Enum.reduce([], fn c, a ->
        [Enum.reduce(c, 0, &(&2 + String.to_integer(&1))) | a]
      end)
      |> Enum.sort(&(&1 > &2))
    IO.puts(h + s + t)
  end
end

AOC2022Day1B.go(input)
