{:ok, contents} = File.read("day4input.txt")
input = contents \
  |> String.split("\n")

defmodule AOC2022Day4B do
  def go(i) do
    i
    |> Enum.chunk_every(2)
    |> Enum.map(fn pair ->
      pair
      |> Enum.map(fn line ->
        val =
          line
          |> String.split(",")
          |> process_line()
          |> calc_overlap()
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
    |> IO.puts()

  end

  def process_line([first, second]), do:
    [process_range(first), process_range(second)]

  def process_range(range) do
    [a, b] = String.split(range, "-")
    [a1, b1] = [String.to_integer(a), String.to_integer(b)]
    {a1, b1, b1 - a1}
  end

  def calc_overlap([{first_a, first_b, first} = f, {second_a, second_b, second} = s]) do
    cond do
      second_b > first_b -> calc_overlap_value([[second_a, second_b], [first_a, first_b]])
      first_b > second_b -> calc_overlap_value([[first_a, first_b], [second_a, second_b]])
      first_b == second_b -> calc_diff_then_value([f, s])
      true -> 0
    end
  end

  def calc_overlap_value([[first_a, first_b], [second_a, second_b]]) do
    cond do
      second_a >= first_a and second_a <= first_b or second_b >= first_a and second_b <= first_b -> 1
      true -> 0
    end
  end

  def calc_diff_then_value([{first_a, first_b, first}, {second_a, second_b, second}]) do
    cond do
      first > second -> calc_overlap_value([[first_a, first_b], [second_a, second_b]])
      second > first -> calc_overlap_value([[second_a, second_b], [first_a, first_b]])
      first == second -> 1
      true -> 0
    end
  end
end

AOC2022Day4B.go(input)
