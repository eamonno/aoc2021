fish =
  File.read!("day/6/input")
  |> String.trim()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

days = [80, 256]

Enum.reduce(1..Enum.max(days), Enum.frequencies(fish), fn day, fish ->
  fish =
    if Map.has_key?(fish, day - 1) do
      fish
      |> Map.merge(%{day + 8 => Map.get(fish, day - 1), day + 6 => Map.get(fish, day + 6, 0) + Map.get(fish, day - 1)})
      |> Map.delete(day - 1)
    else
      fish
    end

  if day in days do
    IO.puts("After #{day} days #{Map.values(fish) |> Enum.sum()} fish.")
  end

  fish
end)
