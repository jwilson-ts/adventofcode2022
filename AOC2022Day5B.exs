{:ok, contents} = File.read("day5input.txt")
input = contents \
  |> String.split("\n")

defmodule AOC2022Day5B do
  def go(i) do
    [layout,  moves] =
      i
      |> Enum.chunk_by(&(String.length(&1) == 0))
      |> Enum.reject(&(&1 == [""]))

    parse_layout(layout)
    |> parse_moves(moves)
    |> determine_outcome()
    |> IO.inspect()
  end

  defp parse_layout(layout) do
    [_head | layers] = Enum.reverse(layout)
    layers
    |> Enum.map(fn layer ->
      layer
      |> String.split("", trim: true)
      |> Enum.chunk_every(4)
      |> Enum.map(fn i ->
        i |> Enum.reject(&(&1 in ["[", " ", "]"]))
      end)
    end)
    |> Enum.reduce(%{}, fn layer, layers_acc ->
      %{col: _, layers: acc} =
        layer
        |> Enum.reduce(%{col: 0, layers: layers_acc}, fn col, %{col: col_count, layers: layer_acc} ->
          col_num = Integer.to_string(col_count + 1)
          new_acc = Map.update(layer_acc, col_num, [col], fn col_vals ->
            [col | col_vals] |> Enum.reject(&(&1 == [])) |> List.flatten()
          end)
          %{col: col_count + 1, layers: new_acc}
        end)
      acc
    end)
  end

  defp parse_moves(layers, moves) do
    moves
    |> Enum.reduce(layers, fn move, acc_layers ->
      {count, from_col, to_col} =
        move
        |> String.split(" ")
        |> parse_move()

      col_to_take_from = Map.get(acc_layers, from_col)

      {taken_vals, remaining_vals} = col_to_take_from |> Enum.split(String.to_integer(count))

      acc_layers
      |> Map.update!(from_col, fn _ -> remaining_vals end)
      |> Map.update!(to_col, fn col -> [taken_vals | col] |> List.flatten() end)
    end)
  end

  defp parse_move(["move", count, "from", from_col, "to", to_col]) do
    {count, from_col, to_col}
  end

  defp determine_outcome(final_state) do
    final_state
    |> Map.keys()
    |> Enum.reduce("", fn key, val ->
      [col_val] =
        final_state
        |> Map.get(key)
        |> Enum.take(1)
      val <> col_val
    end)
  end
end

AOC2022Day5B.go(input)
