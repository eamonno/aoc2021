input = File.read!("day/1/input")
  |> String.split()
  |> Enum.map(&String.to_integer/1)

input
  |> Enum.chunk_every(2, 1, :discard)
  |> Enum.map(fn [a, b] -> a < b end)
  |> Enum.count(&(&1))
  |> IO.inspect()

input
  |> Enum.chunk_every(3, 1, :discard)
  |> Enum.map(&Enum.sum/1)
  |> Enum.chunk_every(2, 1, :discard)
  |> Enum.map(fn [a, b] -> a < b end)
  |> Enum.count(&(&1))
  |> IO.inspect()
