{:ok, contents} = File.read("day3input.txt")
input = contents \
  |> String.split("\n")

defmodule AOC2022Day3A do
  @letters String.graphemes("abcdefghijklmnopqrstuvwxyz")

  def go(i) do
    i
    |> Enum.reduce([], fn line, acc_1 ->
      {side_a, side_b} =
        line
        |> String.split_at(Kernel.round(String.length(line) / 2))
      match =
        String.graphemes(side_a)
        |> Enum.reduce([], fn l, acc_2 ->
          if String.contains?(side_b, l) do
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

AOC2022Day3A.go(input)
