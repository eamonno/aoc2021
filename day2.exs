input = File.stream!("day/2/input", [], :line)
  |> Stream.map(&String.split/1)
  |> Stream.map(fn [direction, amount] -> {String.to_atom(direction), String.to_integer(amount)} end)
  |> Enum.to_list()

defmodule Navigate do
  # navigate is used in the first part
  def navigate({:forward, n}, {horizontal, depth}), do: {horizontal + n, depth}
  def navigate({:down, n}, {horizontal, depth}), do: {horizontal, depth + n}
  def navigate({:up, n}, {horizontal, depth}), do: {horizontal, depth - n}

  # aim is used in the second part
  def aim({:forward, n}, {horizontal, depth, aim}), do: {horizontal + n, depth + aim * n, aim}
  def aim({:down, n}, {horizontal, depth, aim}), do: {horizontal, depth, aim + n}
  def aim({:up, n}, {horizontal, depth, aim}), do: {horizontal, depth, aim - n}
end

part_one = Enum.reduce(input, {0, 0}, &Navigate.navigate/2)
IO.puts("Part 1 answer: #{inspect(part_one)}, #{elem(part_one, 0) * elem(part_one, 1)}")

part_two = Enum.reduce(input, {0, 0, 0}, &Navigate.aim/2)
IO.puts("Part 2 answer: #{inspect(part_two)}, #{elem(part_two, 0) * elem(part_two, 1)}")
