~r/^(\d+),(\d+) -> (\d+),(\d+)$/m
  |> Regex.scan(File.read!("day/5/input"))
  |> Enum.map(fn [_, x1, y1, x2, y2] -> [String.to_integer(x1)..String.to_integer(x2), String.to_integer(y1)..String.to_integer(y2)] end)
  |> Enum.map(fn [xrange, yrange] = line ->
    case line do
      [%{ first: _x1, last: _x2 }, %{ first: y, last: y }] -> Enum.map(xrange, &({&1, y}))
      [%{ first: x, last: x }, %{ first: _y1, last: _y2 }] -> Enum.map(yrange, &({x, &1}))
      # Uncomment for part one
      #_ -> []
      # Uncomment for part two
      _ -> Enum.zip(xrange, yrange)
    end
  end)
  |> List.flatten()
  |> Enum.frequencies()
  |> Enum.filter(fn {_, freq} -> freq > 1 end)
  |> Enum.count()
  |> IO.inspect()
