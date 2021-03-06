input = File.read!("day/1/input")
  |> String.split()
  |> Enum.map(&String.to_integer/1)

input
  |> Enum.chunk_every(2, 1, :discard)
  |> Enum.count(fn [a, b] -> a < b end)
  |> IO.inspect()

input
  |> Enum.chunk_every(4, 1, :discard)
  |> Enum.count(fn [a, _, _, d] -> a < d end)
  |> IO.inspect()
