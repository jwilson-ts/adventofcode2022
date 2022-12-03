{:ok, contents} = File.read("day3input.txt")
input = contents \
  |> String.split("\n")

defmodule AOC2022Day3B do
  @letters String.graphemes("abcdefghijklmnopqrstuvwxyz")

  def go(i) do
    i
    |> Enum.chunk_every(3)
    |> Enum.reduce([], fn chunk, acc_1 ->
      [a, b, c] = chunk
      letters = String.graphemes(a)
      match =
        String.graphemes(a)
        |> Enum.reduce([], fn l, acc_2 ->
          if String.contains?(b, l) and String.contains?(c, l) do
            [l | acc_2]
          else
            acc_2
          end
        end)
        |> Enum.take(1)
      [match | acc_1]
    end)
    |> List.flatten()
    |> Enum.reduce([], fn l, acc_3 ->
      index = cond do
        String.upcase(l) == l -> Enum.find_index(@letters, &(&1 == String.downcase(l))) + 26
        true -> Enum.find_index(@letters, &(&1 == l))
      end
      [index + 1 | acc_3]
    end)
    |> Enum.sum()
    |> IO.puts()
  end
end

AOC2022Day3B.go(input)
