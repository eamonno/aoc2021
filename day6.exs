fish =
  File.read!("day/6/input")
  |> String.trim()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

days = [80, 256]

Enum.reduce(1..Enum.max(days), Enum.frequencies(fish), fn day, fish ->
  fish =
    if Map.has_key?(fish, 0) do
      fish
      |> Map.merge(%{9 => Map.get(fish, 0), 7 => Map.get(fish, 7, 0) + Map.get(fish, 0)})
      |> Map.delete(0)
    else
      fish
    end
    |> Enum.into(%{}, fn {days_to_go, fish_spawning} -> {days_to_go - 1, fish_spawning} end)

  if day in days do
    IO.puts("After #{day} days #{Map.values(fish) |> Enum.sum()} fish.")
  end

  fish
end)
