fish =
  File.read!("day/6/input")
  |> String.trim()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

fish_on_day = fn fish, day ->
  Enum.reduce(1..day, Enum.frequencies(fish), fn day, fish ->
    case Map.pop(fish, day - 1) do
      {nil, _} -> fish
      {n, fish} -> Map.merge(fish, %{day + 8 => n, day + 6 => Map.get(fish, day + 6, 0) + n})
    end
  end) |> Map.values() |> Enum.sum()
end

IO.puts("After  80 days #{fish_on_day.(fish, 80)} fish.")
IO.puts("After 256 days #{fish_on_day.(fish, 256)} fish.")
